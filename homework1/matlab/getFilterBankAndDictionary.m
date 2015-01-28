function [filterBank, dictionary] = getFilterBankAndDictionary(image_names)
% 16720 CV Spring 2015 - Stub Provided
% Inputs: 
%   image_names: cell array of strings (full path to images)
% Outputs:
%   filterBank:  a cell array of N filters
%   dictionary:  \alpha x K matrix 


% create the filter bank for image processing
[filterBank] = createFilterBank();

fprintf('========Get Filter Dictionary========\n');

filter_responses = [];
% take the image with a certain name


matlabpool('local',12);

parfor i = 1:length(image_names)
	% read the image
	I = imread(image_names{i});
	% applying the filter on different images
	[filter_response] = extractFilterResponses(I, filterBank);
  	idx = randperm(size(filter_response,1),150);
	% concatenate the filter_response to the filter_responses list
	[filter_responses] = [filter_responses;filter_response(idx,:)]; 
	fprintf('#%d/%d image %s is done\n', i,length(image_names), image_names{i});
end


matlabpool close



assert(size(filter_responses,1) == 150*length(image_names), 'rows of filter_responses is %d, but should be %d', size(filter_responses,1), 150*length(image_names));
assert(size(filter_responses,2) == 20*3, 'column of filter_responses is %d, but should be %d', size(filter_responses,2), 20*3);
% reshape the filter responses

% extracting the words from the dictionary
fprintf('========Computer K means========\n');
%assert(size(filter_responses,1)>300, 'filter_responsees has %d rows, which is less than 300', size(filter_responses,1));

[~,dictionary] = kmeans(filter_responses,300,'EmptyAction','drop');


