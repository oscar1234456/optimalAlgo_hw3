function [newCubs] = mutation(oldCubs, pm)
arguments
     oldCubs
     pm
end
newCubs = {};
for now=1:length(oldCubs)
    GOD = rand(1,48);
    for i=1:length(GOD)
        if(GOD(i)<=pm)
            newCubs{now} = oldCubs{now};
            if(newCubs{now}(i)==0)
                newCubs{now}(i) = 1;
            else
                newCubs{now}(i) = 0;
            end
        end
    end
end



return