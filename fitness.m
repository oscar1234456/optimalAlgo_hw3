function [res] = fitness(X, Y)
 arguments
     X
     Y
 end
 
 res = (X^2 + Y^2)/4000 - cos(X)*cos(Y/sqrt(2))+1;
 return