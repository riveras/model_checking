% Simple loop
% Lyapunov's difference always <= 0 

% (C) Dejanira Araiza-Illan, University of Bristol

clear

model = 'scalar_loop_unstable'; %Model

init_cond = [-10 10; 1 1];

input_range = []; %Initial conditions
cp_array = [];

phi = '[]r1' ; %Requirement to verify always <= 0

ii = 1; 
preds(ii).str='r1';
preds(ii).A = 1; %<=
preds(ii).b = 0; %0
preds(ii).loc = [1:7];

time = 10; %Simulation time

opt = staliro_options();

opt.runs = 1;
n_tests = 100;
opt.interpolationtype={'pconst'};


%opt.optimization_solver = 'SA_Taliro';
%opt.optimization_solver = 'CE_Taliro';
opt.optimization_solver = 'UR_Taliro';

opt.optim_params.n_tests = n_tests;


tic
results = staliro(model,init_cond,input_range,cp_array,phi,preds,time,opt);
runtime=toc;

runtime

robustness = results.run(results.optRobIndex).bestRob

% figure
% [T1,XT1,YT1,IT1] = SimSimulinkMdl(model,init_cond,input_range,cp_array,results.run(results.optRobIndex).bestSample(:,1),time,opt);
%  plot(T1,XT1(:,1))
%  title('X')
%  hold on 


