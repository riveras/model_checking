% Simple loop
% Lyapunov function's difference eventually > 0

% (C) Dejanira Araiza-Illan, University of Bristol

clear

A=[1.5 0.5;0.5 1.0];
B=[2; 0];
des_con=eig([0.8 0.3;0 -0.6]);
K=place(A,B,des_con);
Q=eye(size(A));
P=dlyap((A-B*K)',Q);

model = 'controller_loop'; %Model

init_cond = [-10 10;-10 10;1 1];

input_range = []; %Initial conditions
cp_array = [];

phi = '<>r1' ; %Requirement

ii = 1; 
preds(ii).str='r1';
preds(ii).A = -1; %>=0
preds(ii).b = 0.001; % 0
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
%  plot(T1,XT1(:,1),T1,XT1(:,2))
%   title('X')
%  hold on 



