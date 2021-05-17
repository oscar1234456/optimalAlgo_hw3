function [prideValue] = prideFitness(Xm, Xf, maleCubs, femaleCubs, Age_mat, nowAge)
arguments
     Xm
     Xf
     maleCubs
     femaleCubs
     Age_mat
     nowAge
end
cubsLength = length(maleCubs);
sumOperator = 0;
for i=1:cubsLength
    vec = convLion2Value(maleCubs{i});
    nowMaleCub = fitness(vec(1), vec(2));
    vec = convLion2Value(femaleCubs{i});
    nowFemaleCub = fitness(vec(1), vec(2));
    sumOperator = sumOperator + ((nowMaleCub+nowFemaleCub)/cubsLength); 
end
vec = convLion2Value(Xm);
XmFit = fitness(vec(1), vec(2));
vec = convLion2Value(Xf);
XfFit = fitness(vec(1), vec(2));
prideValue = (1/2*(1+cubsLength))*(XmFit+XfFit+(Age_mat/nowAge+1)*sumOperator);
return

