function [greatGene, pickRecord] = selectionProcess(oldGene)
 arguments
     oldGene
 end
 
 greatGene = cell(1,length(oldGene));
 eval = zeros(1, length(oldGene));
 wheel = zeros(1, length(oldGene));
 pickRecord = cell(1, length(oldGene));
 
 %Calculate fitness value
 for i=1:length(oldGene)
    vecs = convGene2Value(oldGene{i});
    eval(i) = roundn(fitness(vecs(1), vecs(2)), -4);
 end
 
 %pick Max fitness Value
  maxFitnessVal = max(eval);
  fprintf("Now Generation Max FitnessValue: %5.4f \n", maxFitnessVal);
  
  %picl Min fitness Value
  minFitnessVal = min(eval);
  fprintf("Now Generation Min FitnessValue: %5.4f \n", minFitnessVal);
  
  if(minFitnessVal<0)
    distance = 1 - minFitnessVal;
    eval = eval+distance;
  end
  
  %sum all fitness value
  sumFitnessVal = sum(eval);
  fprintf("Now Generation Sum FitnessValue: %5.4f \n",  sumFitnessVal);
  
  
  %caculate probability for each chromosome
  probability = eval / sumFitnessVal;
  
  
  %create a roulette wheel
  wheel(1) = probability(1);
  for i=2:length(oldGene)
    wheel(i) = wheel(i-1)+probability(i);
  end
  
  %spin the roulette wheel
   GOD = rand(1,length(oldGene));
   for i=1:length(GOD)
       now = GOD(i);
    for j=1:length(wheel)
        if(now <= wheel(j))
            greatGene{i} = oldGene{j};
            pickRecord{i} = j;
            break;
        end
    end
   end
   disp("New Generation Was Created!");
   disp("greatGene Length");
   disp(length(greatGene));
   return
  
 