function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% 16720 CV Spring 2015 - Stub Provided
% Inputs: 
%   layerNum:       number of layers
%   wordMap:        Matrix of H x W containing IDs of visual words
%   dictionarySize: number of visual words
% Outputs:
%   histInter: normalized histogram vector

layerNum = layerNum+1;
grid = 2^(layerNum-1);
H = floor(size(wordMap,1)/grid);
W = floor(size(wordMap,2)/grid);
%h = zeros (dictionary*(4^layerNum-1)/3,1);
h=[];
last_layer = zeros(grid,grid,dictionarySize);
for i =1:grid
	for j = 1:grid
	last_layer(i,j,:) = hist(reshape(wordMap((i-1)*H+1:i*H,(j-1)*W+1:j*W),[1,numel(wordMap((i-1)*H+1:i*H,(j-1)*W+1:j*W))]),dictionarySize);
	end
end
layer = layerNum - 1;
h = reshape(last_layer,[1,numel(last_layer)])*(2^(1-layerNum+layer-1));



for layer = layerNum-2:-1:1
 	grid = 2^layer;
	new_layer = zeros(grid,grid,dictionarySize);
	for i =1:grid
		for j = 1: grid
		new_layer(i,j,:) = sum(sum(last_layer((2*i-1):(2*i),(2*j-1):(2*j),:),1),2);	
		end
	end
	last_layer=new_layer;
	h=[h,reshape(last_layer,[1,numel(last_layer)])*(2^(layer-(layerNum-1)-1))];
end


h =[h, reshape(sum(sum(last_layer(1:2,1:2,:),1),2),[1,dictionarySize])*(2^(-(layerNum-1)))];

h = (h/sum(h))';
assert(size(h,1) == dictionarySize*(4^layerNum-1)/3,'length of h should be %d, but it should be %d',size(h,1),dictionarySize*(4^layerNum-1)/3);



end
