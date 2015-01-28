function [h] = getImageFeatures(wordMap,dictionarySize)
% 16720 CV Spring 2015 - Stub Provided
% Inputs: 
%   wordMap:        Matrix of H x W containing IDs of visual words
%   dictionarySize: number of visual words
% Outputs:
%   histInter: dictionarySize x 1 normalized histogram


h = (hist(reshape(wordMap,[1,numel(wordMap)]),dictionarySize)/sum(hist(reshape(wordMap,[1,numel(wordMap)]),dictionarySize)))'; 
