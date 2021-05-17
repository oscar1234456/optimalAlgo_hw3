%Initialization
Age_mat = 3;
B_strength = 5;
Gen_max = 50;
Pc_1 = 0.2;
Pc_2 = 0.6;
Pm = 0.5;

%Data Variable & Structure Initialization
nowAge = 0;
nowCubs = {};
nowCubsFitness = [];
maleCubs = {};
femaleCubs = {};
%Step1. Pride Generation
%---Generate territorial male and female---
Xm = getNewLion();
Xf = getNewLion();

%Step2. Mating
%---Generate cubs from territorial male and female (Crossover & mutation)---
crossoverCubs = crossover({Xm,Xf},Pc_1, Pc_2);
mutationCubs = mutation(crossoverCubs, Pm);
nowCubs = [crossoverCubs(1:4),mutationCubs(1:4)];
% for i=1:length(nowCubs)
%     vec = convLion2Value(nowCubs{i});
%     nowCubsFitness(i) = fitness(vec(1), vec(2));
% end
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
            [big, bigIndex] = max(tempMaleCubsFitness);
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
            [big, bigIndex] = max(tempFemaleCubsFitness);
            tempFemaleCubsFitness(bigIndex) = [];
            femaleCubs(bigIndex) = [];
        end
    end
end

%Step3. Territorial Defense
nowAge = 0;
nomalLion = getNewLion();
vec =  convLion2Value(nomalLion);
nomalLionFit = fitness(vec(1), vec(2));

vec = convLion2Value(Xm);
XmFit = fitness(vec(1), vec(2));
 if(nomalLionFit < XmFit)
    % nomal Lion win Xmale Lion
    %compare with pride:
 end




%Step4.Territorial Takeover