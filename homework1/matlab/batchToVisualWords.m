function batchToVisualWords(numCores, type)
% Xinlei Chen
% CV Fall 2013 - Provided Code
% Does parallel computation of the visual words 
%
% Input:
%   numCores - number of cores to use (default 2)


addpath ../data/images

if nargin < 1
    %default to 2 cores
    numCores = 2;
end

% Close the pools, if any
try
    fprintf('Closing any pools...\n');
    matlabpool close; 
catch ME
    disp(ME.message);
end


fprintf('Starting a pool of workers with %d cores\n', numCores);
matlabpool('local',numCores);
%load the files and texton dictionary
%load('traintest.mat','all_imagenames','mapping');
load('traintest.mat','all_imagenames','mapping');
load('dictionary.mat','filterBank','dictionary');

source = '../data/images/';
% storing mat files in the same directory as the jpg.
target = '../data/images/';

if ~exist(target,'dir')
    mkdir(target);
end

% for cate = mapping
%     if ~exist([target,cate{1}],'dir')
%         mkdir([target,cate{1}]);
%     end
% end

%This is a peculiarity of loading inside of a function with parfor. We need to 
%tell MATLAB that these variables exist and should be passed to worker pools.
filterBank = filterBank;
dictionary = dictionary;
%type = type;

%matlab can't save/load inside parfor; accumulate
%them and then do batch save
l = length(all_imagenames);

wordRepresentation = cell(l,1);
parfor i=1:l
    fprintf('Converting to visual words %s\n', all_imagenames{i});
    image = imread([source, all_imagenames{i}]);
    wordRepresentation{i} = getVisualWords(image, filterBank, dictionary);
end

%dump the files
fprintf('Dumping the files\n');
for i=1:l
    wordMap = wordRepresentation{i};
    % TODO: Brittle. Will fail if extension is not jpg.
    save([target, strrep(all_imagenames{i},'.jpg','.mat')],'wordMap');
end

%close the pool
fprintf('Closing the pool\n');
matlabpool close

end
