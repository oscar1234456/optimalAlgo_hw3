function [greatGene] = mutation(oldGene, pm)
arguments
     oldGene
     pm
end
GOD = rand(1,length(oldGene)*26);

for i=1:length(GOD)
    if(GOD(i)<=pm)
        if(mod(i,26)==0)
            number = floor(i/26);
            if(oldGene{number}(26)==0)
                oldGene{number}(26) = 1;
            else
                oldGene{number}(26) = 0;
            end
        else
            number = ceil(i/26);
            pos = mod(i,26);
            if(oldGene{number}(pos)==0)
                 oldGene{number}(26) = 1;
            else
                 oldGene{number}(26) = 0;
            end
        end
    end
end

greatGene = oldGene;
return