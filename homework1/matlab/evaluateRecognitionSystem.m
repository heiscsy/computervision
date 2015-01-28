% 16720 CV Spring 2015 - Stub Provided
% evaluateRecognitionSystem script here, should output the confusion matrix

load('vision.mat');
load('../data/images/traintest.mat');
addpath '../data/wordmaps/'
to_process = strcat(['../data/images/'],test_imagenames);

correct = 0;

L=2;


for i=1: length(to_process)
%for i=1:1
	image = im2double(imread(to_process{i}));
	%wordMap = getVisualWords(image, filterBank, dictionary);
	load (strrep(strrep(to_process{i},'.jpg','.mat'),'images','wordmaps'));

	h = getImageFeatures( wordMap, size(dictionary,1));
	%h = getImageFeaturesSPM( 2, wordMap, size(dictionary,1));	
	%h = getImageFeaturesSPM_Hard( 2, wordMap, size(dictionary,1));	
	distances = distanceToSet(h, train_features);
	[~,nnI] = max(distances);	
	
	fprintf('#%d/%d prediction is %s, actual is %s \n',i,length(to_process),mapping{train_labels(nnI)},mapping{test_labels(i)});
	if train_labels(nnI)==test_labels(i)
		correct = correct+1;	
	end
%	clear image;
%	clear wordMap;
end


fprintf('Correct: %d\n', correct);
fprintf('Accuracy: %f\n', correct/length(to_process));


	
