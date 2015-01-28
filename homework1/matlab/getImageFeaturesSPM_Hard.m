function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)

H = floor(size(wordMap,1)/4);
W = floor(size(wordMap,2)/4);

for i =1:4
	for j = 1:4
	second_layer(i,j,:) = hist(reshape(wordMap((i-1)*H+1:i*H,(j-1)*W+1:j*W),[1,numel(wordMap((i-1)*H+1:i*H,(j-1)*W+1:j*W))]),dictionarySize);
	end
end



%disp(size(second_layer));

first_layer(1,1,:) = second_layer(1,1,:)+second_layer(1,2,:)+second_layer(2,1,:)+second_layer(2,2,:);
first_layer(1,2,:) = second_layer(1,3,:)+second_layer(1,4,:)+second_layer(2,3,:)+second_layer(2,4,:);
first_layer(2,1,:) = second_layer(3,1,:)+second_layer(3,2,:)+second_layer(4,1,:)+second_layer(4,2,:);
first_layer(2,2,:) = second_layer(3,3,:)+second_layer(3,4,:)+second_layer(4,3,:)+second_layer(4,4,:);

%disp(size(first_layer));
zero_layer(1,1,:) = first_layer(1,1,:)+first_layer(1,2,:)+first_layer(2,1,:)+first_layer(2,2,:);

%disp(size(zero_layer));

h=[reshape(second_layer,[1,numel(second_layer)])*(1/2),reshape(first_layer,[1,numel(first_layer)])*(1/4),reshape(zero_layer,[1,numel(zero_layer)])*(1/4)];
h = (h/sum(h))';

end

