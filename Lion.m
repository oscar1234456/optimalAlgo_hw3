%Initialization
Age_mat = 3;
Bstrength = 20;
Gen_max = 100;
Pc_1 = 0.2;
Pc_2 = 0.6;
Pm = 0.5;

%Data Variable & Structure Initialization
Bcount = 0;
nowAge = 0;
nowGen = 0;
fitnessRecAllLion = zeros(1,Gen_max);

%Step1. Pride Generation
%---Generate territorial male and female---
Xm = getNewLion();
Xf = getNewLion();

while(nowGen <= Gen_max) %keep running until Gen_max
    nowCubsFitness = [];
    maleCubs = {};
    femaleCubs = {};
    disp("Mating");
    %Step2. Mating
    %---Generate cubs from territorial male and female (Crossover & mutation)---
    crossoverCubs = crossover({Xm,Xf},Pc_1, Pc_2);
    mutationCubs = mutation(crossoverCubs, Pm);
    nowCubs = [crossoverCubs(1:4),mutationCubs(1:4)];
    location = convLion2Value(nowCubs{1});
    for i=2:length(nowCubs)
        vec = convLion2Value(nowCubs{i});
        location = cat(1,vec,location);
    end

    %---Kmeans to cluster cubs to male and female---
    [team,C] = kmeans(location, 2);

    for i=1:length(team)
        if(team(i)==1)
            %male cubs
            maleCubs{end+1} = nowCubs{i};
        else
            %female cubs
            femaleCubs{end+1} = nowCubs{i};
        end
    end

    if(length(maleCubs) ~= length(femaleCubs))
        distance = abs(length(maleCubs)-length(femaleCubs));
        if(length(maleCubs)>length(femaleCubs))
            % male Cubs bigger than female Cubs
            disp("Male Change");
            tempMaleCubsFitness = [];
            for i=1:length(maleCubs)
                vec = convLion2Value(maleCubs{i});
                tempMaleCubsFitness(end+1) = fitness(vec(1), vec(2));
            end
            for j=1:distance
                [big, bigIndex] = max(tempMaleCubsFitness); %pick weak male cubs
                tempMaleCubsFitness(bigIndex) = [];
                maleCubs(bigIndex) = [];
            end
        else
            % female Cubs bigger than male Cubs
             disp("Female Change");
             tempFemaleCubsFitness = [];
            for i=1:length(femaleCubs)
                vec = convLion2Value(femaleCubs{i});
                tempFemaleCubsFitness(end+1) = fitness(vec(1), vec(2));
            end
            for j=1:distance
                [big, bigIndex] = max(tempFemaleCubsFitness); %pick weak female cubs
                tempFemaleCubsFitness(bigIndex) = [];
                femaleCubs(bigIndex) = [];
            end
        end
    end

    disp("Territorial Defense");
    %Step3. Territorial Defense
    nowAge = 0;
    flag = true;
    while(nowAge <= Age_mat)  %keep running until Age_mat
        nomalLion = getNewLion(); %generate a nomal lion
        vec =  convLion2Value(nomalLion);
        nomalLionFit = fitness(vec(1), vec(2));

        vec = convLion2Value(Xm);
        XmFit = fitness(vec(1), vec(2));
         if(nomalLionFit < XmFit)
            % nomal Lion win Xmale Lion
           if(nomalLionFit < prideFitness(Xm, Xf, maleCubs, femaleCubs, Age_mat, nowAge))
                %kill Male Cubs and Female Cubs
                maleCubs = {};
                femaleCubs = {};
                Xm = nomalLion; %change male Lion
                %goto mating
                flag = false;
                break
           end
         else
             %nomal Lion Lose
             nowAge = nowAge + 1;
         end
    end
    if(~flag)
        continue %goto mating(Step2)
    end
    
    %This Pride win over nomal Lion and cuns had matured
    
    disp("Territorial Takeover");
    %Step4.Territorial Takeover
    vec = convLion2Value(Xm);
    XmFit = fitness(vec(1), vec(2));
    vec = convLion2Value(Xf);
    XfFit = fitness(vec(1), vec(2));
    maleCubsFitness = [];
    femaleCubsFitness = [];
    for k=1:length(maleCubs) %count male cubs fitness
        vec = convLion2Value(maleCubs{k});
        maleCubsFitness(end+1) = fitness(vec(1), vec(2));
    end
    for k=1:length(femaleCubs) %count female cubs fitness
        vec = convLion2Value(femaleCubs{k});
        femaleCubsFitness(end+1) = fitness(vec(1), vec(2));
    end
    [bestMaleCubs, bestMaleCubsIndex] = min(maleCubsFitness);  %pick the best Male Cub Fitness Value
    [bestFemaleCubs, bestFemaleCubsIndex] = min(femaleCubsFitness);  %pick the best Female Cub Fitness Value
    if(bestMaleCubs < XmFit)
     %bestMaleCubs win!!
        Xm = maleCubs{bestMaleCubsIndex};
    end
    if(bestFemaleCubs < XfFit)
    %bestFemaleCubs win!!
        Xf = femaleCubs{bestFemaleCubsIndex};
        Bcount = 0;
    else
        %bestFemaleCubs lose.
        Bcount = Bcount + 1;
    end
    vec = convLion2Value(Xf);  %new Xf
    XfFit = fitness(vec(1), vec(2));
    if(Bcount>Bstrength)
        newFemaleLionFitness = 9999999999;
        count = 0;
        while(newFemaleLionFitness >= XfFit)
            disp("find new Female");
            newFemaleLion = getNewLion();
            vec = convLion2Value(newFemaleLion);
            newFemaleLionFitness = fitness(vec(1), vec(2));
            fprintf("nowGen:%d,count:%d, new:%f, old:%f \n",nowGen,count,newFemaleLionFitness,XfFit);
            count = count+1;
            if(count > 1000)
                newFemaleLion = Xf;
                break
            end
        end
        Xf = newFemaleLion;
    end
    nowGen = nowGen + 1;
    
    vec = convLion2Value(Xm);
    XmFit = fitness(vec(1), vec(2));
    vec = convLion2Value(Xf);
    XfFit = fitness(vec(1), vec(2));
    if(XmFit<XfFit)
        %Xm win
        BestLionFitness = XmFit; 
    else
        %Xf win
        BestLionFitness = XfFit;
    end
    fitnessRecAllLion(nowGen) = BestLionFitness;
end
nexttile
title('每代染色體Fitness最大值')
plot(1:Gen_max, fitnessRecAllLion(1:Gen_max));
xlabel('Generation') 
ylabel('Min Objection Function Value') 
