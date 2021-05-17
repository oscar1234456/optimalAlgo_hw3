function [cubs] = crossover(parentLion, pc, pc2)
arguments
     parentLion
     pc
     pc2
end
cubs = {};
%Generate c1 cubs
GOD = rand(1,48);
c1 = 0;  %Crossover1

    %---Select c1 pointer---
for i=1:length(GOD)
    if(GOD(i)<=pc)
        c1 = i;
        fprintf("c1: %d \n", c1);
        break
    end
    if(i==length(GOD))
        GOD = rand(1,48);
        disp("no choice c1");
        i = 1;
    end
end
    %---Genersate First Cub---
cubs{1} = [parentLion{1}(1:c1),parentLion{2}(c1+1:48)];
    %---Genersate Second Cub---
cubs{2} = [parentLion{1}(c1+1:48),parentLion{2}(1:c1)];


%Generate c2 cubs
GOD = rand(1,48);
c2 = 0;  %Crossover1

    %---Select c1 pointer---
for i=1:length(GOD)
    if(GOD(i)<=pc2 && c1 ~= i)
        c2 = i;
        fprintf("c2: %d \n", c2);
        break
    end
    if(i==length(GOD))
        GOD = rand(1,48);
        disp("no choice c1");
        i = 1;
    end
end
    %---Genersate First Cub---
cubs{3} = [parentLion{1}(1:c2),parentLion{2}(c2+1:48)];
    %---Genersate Second Cub---
cubs{4} = [parentLion{1}(c2+1:48),parentLion{2}(1:c2)];

return