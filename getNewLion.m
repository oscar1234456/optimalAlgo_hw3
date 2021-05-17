%This Function was used to create a new Generation
function [newCell]=getNewLion(createNum)
 arguments
      createNum
 end
 
 newCell = cell(1,createNum);

 for i=1:createNum
    x = randi([0 1],1,48);
    newCell{i} = x;
 end
 
 return