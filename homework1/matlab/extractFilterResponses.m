function [filterResponses] = extractFilterResponses(I, filterBank)
% 16720 CV Spring 2015 - Partially Provided Code
% Inputs: 
%   I:                  a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W*H x N*3 size matrix of filter responses

% NOTE: THIS IS IMPORTANT SINCE IMAGES DEFAULT IMPORT AT UINT8
doubleI = double(I);

% STEP 1: Call to RGB2Lab. See `help RGB2Lab' provided in the folder
I_Lab = RGB2Lab(doubleI);
% STEP 2: Compute the number of pixels in each channel (not for all
%           channels combined). Hint: Width x Height
pixelCount = size(I_Lab,1)*size(I_Lab,2);

% STEP 3: Initialize output filter responses
filterResponses = zeros(pixelCount,1);

%for each filter and channel, apply the filter, and vectorize
for filterI = 0:length(filterBank)-1
    % extract filter from the bank
    filter = filterBank{filterI+1};
    
    filterResponses(:,filterI*3+1) = reshape(imfilter(I_Lab(:,:,1), filter), pixelCount, 1);
    filterResponses(:,filterI*3+2) = reshape(imfilter(I_Lab(:,:,2), filter), pixelCount, 1);
    filterResponses(:,filterI*3+3) = reshape(imfilter(I_Lab(:,:,3), filter), pixelCount, 1);


    % STEP 4: For each of the a, b image channels, compute the filter response
    %  HINT: We have given example output for the L channel. Replicate for
    %  a and b. Take care of indices for the output.
    %       filterResponses(:,filterI*3+1) = reshape(imfilter(L, filter), pixelCount, 1);

end

