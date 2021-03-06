function guessedImage = guessImage( imagename )
% PROVIDED CODE
% Yiying Li
% CV Spring 2015
% Given a path to a scene image, guess what scene it is
% Input:
%   imagename - path to the image

L = 2;
load('vision.mat');
fprintf('[Loading..]\n');
image = im2double(imread(imagename));
% imshow(image);
fprintf('[Getting Visual Words..]\n');
wordMap = getVisualWords(image, filterBank, dictionary);
h = getImageFeaturesSPM( L, wordMap, size(dictionary,1));
%h = getImageFeatures( wordMap, size(dictionary,1));%TODO, code has been changed

assert(size(h,1)==size(train_features,1),'features size mismatched (%d features found, dictionary size is %d)', size(h,1), size(train_features,1));


distances = distanceToSet(h, train_features);
[~,nnI] = max(distances);
load('../data/images/traintest.mat','mapping');

guessedImage = mapping{train_labels(nnI)};
fprintf('[My Guess]:%s.\n',guessedImage);

end

