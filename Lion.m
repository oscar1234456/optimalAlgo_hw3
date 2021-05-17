%Initialization
Age_mat = 3;
B_strength = 5;
Gen_max = 50;
Pc_1 = 0.2;
Pc_2 = 0.6;
Pm = 0.5;

%Data Variable & Structure Initialization
nowCubs = {};
nowCubsFitness = [];
%Step1. Pride Generation
%---Generate territorial male and female---
Xm = getNewLion();
Xf = getNewLion();

%Step2. Mating
%---Generate cubs from territorial male and female (Crossover)---
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
[team,C] = kmeans(location, 2);


%Step3. Territorial Defense




%Step4.Territorial Takeover