pop_size = 40;
pc = 0.50;
pm = 0.30;
generation = 200;
bestGene = [];
bestGeneFitness = -99999;
lastGeneFitness = -99999;
stopCount = 0;
fitnessRec1 = zeros(1,pop_size);
fitnessRec2 = zeros(1,pop_size);
fitnessRec3 = zeros(1,pop_size);
fitnessRec4 = zeros(1,pop_size);
fitnessRecAll = zeros(1,generation);
fitnessRecAllSum =  zeros(1,generation);
%born Generation
thisGene = getNewGene(pop_size);
%evaluate phase 1
for i=1:length(thisGene)
    disp("Generation 1");
    fprintf("now: %d \n",i);
    vec = convGene2Value(thisGene{i});
    fprintf("X: %4.3f \n",roundn(vec(1), -3));
    fprintf("Y: %4.3f \n",roundn(vec(2), -3));
    fprintf("fit: %5.4f \n",roundn(fitness(vec(1), vec(2)), -4));
    fitnessRec1(i) = roundn(fitness(vec(1), vec(2)), -4);
    if(fitnessRec1(i)>bestGeneFitness)
        bestGene = thisGene{i};
        bestGeneFitness = fitnessRec1(i);
    end
end
fitnessRecAll(1) = max(fitnessRec1);
fitnessRecAllSum(1) = sum(fitnessRec1);

for times=2:generation
    fprintf("Generations %d \n", times);
    [newGene, pickRecord] = selectionProcess(thisGene); %pick gene
    % evaluate again 2
    for i=1:length(newGene)
        fprintf("now: %d \n",i);
        vec = convGene2Value(newGene{i});
        fprintf("X: %4.3f \n",roundn(vec(1), -3));
        fprintf("Y: %4.3f \n",roundn(vec(2), -3));
        fprintf("fit: %5.4f \n",roundn(fitness(vec(1), vec(2)), -4));
        fitnessRec2(i) = roundn(fitness(vec(1), vec(2)), -4);
    end

   newGene2 = crossoveer(newGene, pc); %crossover
    evaluate again 3
    for i=1:length(newGene)
        fprintf("now: %d \n",i);
        vec = convGene2Value(newGene{i});
        fprintf("X: %4.3f \n",roundn(vec(1), -3));
        fprintf("Y: %4.3f \n",roundn(vec(2), -3));
        fprintf("fit: %5.4f \n",roundn(fitness(vec(1), vec(2)), -4));
        fitnessRec3(i) = roundn(fitness(vec(1), vec(2)), -4);
    end

   newGene3 = mutation(newGene2, pm);
    for i=1:length(newGene3)
        fprintf("now: %d \n",i);
        vec2 = convGene2Value(newGene3{i});
        fprintf("X: %4.3f \n",roundn(vec2(1), -3));
        fprintf("Y: %4.3f \n",roundn(vec2(2), -3));
        fprintf("fit: %5.4f \n",roundn(fitness(vec2(1), vec2(2)), -4));
        fitnessRec4(i) = roundn(fitness(vec2(1), vec2(2)), -4);
        if(fitnessRec4(i)>bestGeneFitness)
            bestGene = newGene3{i};
            bestGeneFitness = fitnessRec4(i);
        end
    end
    fitnessRecAll(times) = max(fitnessRec4);
    fitnessRecAllSum(times) = sum(fitnessRec4);
    thisGene = newGene3;
    if(lastGeneFitness>bestGeneFitness-0.001&&lastGeneFitness<bestGeneFitness+0.001)
        count = count+1;
        if(count==10)
            break
        end
    else
        count=0;
    end
    lastGeneFitness = bestGeneFitness;
end
nexttile
title('每代染色體Fitness最大值')
plot([0,1:times], [0,fitnessRecAll(1:times)]);
xlabel('Generation') 
ylabel('Max Fitness') 
nexttile
title('每代染色體Fitness總和')
plot([0,1:times], [0,fitnessRecAllSum(1:times)]);
xlabel('Generation') 
ylabel('Sum of Fitness') 

vecFinal = convGene2Value(bestGene);
fprintf("VEC(X): %4.3f \n",roundn(vecFinal(1), -3));
fprintf("VEC(Y): %4.3f \n",roundn(vecFinal(2), -3));
fprintf("fit: %5.4f \n",roundn(fitness(vecFinal(1), vecFinal(2)), -4));
