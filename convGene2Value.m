function [valueVec]=convGene2Value(gene)
 arguments
     gene
 end
 upperX = 4;
 upperY = 3;
 lowerX = -1.5;
 lowerY = -3;
 denominator = 2^13-1;
 
t1 = bi2de(gene(1:13));
coeX = (upperX - lowerX) / denominator;
X = lowerX + t1*coeX;

t2 = bi2de(gene(14:26));
coeY = (upperY - lowerY) / denominator;
Y = lowerY + t2*coeY;
 
 valueVec = [X,Y];
 return
 