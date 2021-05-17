function [greatGene] = crossover(oldGene, pc)
arguments
     oldGene
     pc
end
GOD = rand(1,length(oldGene));
pickedGene = [];

for i=1:length(GOD)
    if(GOD(i)<=pc)
        pickedGene(end+1) = i;
    end
end

if(mod(length(pickedGene),2)~=0)
    %the number of selected chromosomes were odd
     selectedGOD = randi([0 1],1,1);
     if(selectedGOD==0)
        %remove one selected chromosome
        removeCh = randperm(length(pickedGene));
        removeCh = removeCh(1);
        pickedGene = pickedGene([1:removeCh-1, removeCh+1:end]);
     else
        %add one extra chromosome
        GOD = rand(1,length(oldGene));
        for i=1:length(GOD)
            if(~ismember(i,pickedGene) && GOD(i)<=pc)
                pickedGene(end+1) = i;
                break
            end
        end
     end
end
times = length(pickedGene)/2;
for i=1:times
    base = i*2;
    cutRandom = randperm(26);
%     oldGene{pickedGene(base-1)} =   oldGene{pickedGene(base-1)}([1:cutRandom(1), cutRandom(1)+1:end]);
    alne1 = oldGene{pickedGene(base-1)}(cutRandom(1)+1:end);
    alne2 = oldGene{pickedGene(base)}(cutRandom(1)+1:end);
    oldGene{pickedGene(base-1)} =  [ oldGene{pickedGene(base-1)}(1:cutRandom(1)),  alne2];
    oldGene{pickedGene(base)} =  [ oldGene{pickedGene(base)}(1:cutRandom(1)),  alne1];
end
greatGene = oldGene;
return