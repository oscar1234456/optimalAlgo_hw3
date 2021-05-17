function [valueVec]=convLion2Value(lion)
 arguments
     lion
 end
 upperX = 600;
 upperY = 600;
 lowerX = -600;
 lowerY = -600;
 denominator = 2^24-1;
 
t1 = bi2de(lion(1:24));
coeX = (upperX - lowerX) / denominator;
X = lowerX + t1*coeX;

t2 = bi2de(lion(25:48));
coeY = (upperY - lowerY) / denominator;
Y = lowerY + t2*coeY;
 
 valueVec = [X,Y];
 return
 