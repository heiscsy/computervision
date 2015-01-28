function wordMap = getVisualWords(I, filterBank, dictionary)
% 16720 CV Spring 2015 - Stub Provided
% Inputs: 
%   I:     RGB Image with dimensions Rows x Cols (e.g. ouput from calling imread)
%   filterBank: Output from getFilterBankAndDictionary()
%   dictionary: Output from getFilterBankAndDictionary()
% Outputs:
%   wordMap:  matrix with dimensions Rows x Cols

[filterResponses]=extractFilterResponses(I,filterBank);

[~,wordMap]=min(pdist2(filterResponses,dictionary)');
	
wordMap = reshape(wordMap,[size(I,1),size(I,2)]);
