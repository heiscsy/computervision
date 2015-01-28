% 16720 CV Spring 2015 - Stub Provided
% buildRecognitionSystem script here, it sould save a "vision.mat" file




% Parameter settings
dictionarySize = 300;
L =0;
alpha = 150;

% First, extract the filter bank and dictionary

 computeDictionary;

% Second, wordMap should be processed

 batchToVisualWords(12);

% Third, do features generation for the training images

%filterBank=createFilterBank;
%load('dictionary.mat');

load('../data/images/traintest.mat');

to_process = strcat(['../data/wordmaps/'],strrep(train_imagenames,'.jpg','.mat'));


train_features = zeros(dictionarySize*(4^(L+1)-1)/3,length(to_process));
%train_labels = zeros(length(to_process),1);



for i = 1:length(to_process)
	load(to_process{i});
	train_features(:,i)=getImageFeatures(wordMap,dictionarySize);
	%train_features(:,i)=getImageFeaturesSPM_Hard(L,wordMap,dictionarySize);
	clear wordMap;
end

%train_labels = train_labels;


% TODO, refine the save to specific parameters
save('vision.mat')

