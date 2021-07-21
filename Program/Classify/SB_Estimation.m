% Inputs: 
% PHI:  -the hidden outputs of SBELM
% t:    -the expected output
% alpha   -the initial alpha ,beta,maxIts
% maxIts  -the maximum iteration of determining alpha and weight
% Output: 
% Weights   -the estimated output Weights
% UsedNodes      -the remaining position of hidden units
% alpha, gamma -final estimated alpha, gamma
% more details,  pls refer to our paper "Sparse Bayesian Extreme Learning
% Machine for Multi-classification" by Jiahua Luo, Chi-Man Vong.etc
%%%%    Authors:    JIAHUA LUO, CHI-MAN VONG
%%%%    UNIVERSITY OF MACAU, MACAO, CHINA
%%%%    EMAIL:      mb15457@umac.mo; cmvong@umac.mo
%%%%    WEBSITE:    http://www.fst.umac.mo/en/staff/fstcmv.html

function [Weights, UsedNodes,usedAlpha, Gamma] =  SB_Estimation(PHI,t,initalpha,maxIts)
% Terminate estimation when no log-alpha value changes by more than this
MIN_DELTA_LOGALPHA	= 1e-3;
% Prune basis function when its alpha is greater than this
ALPHA_MAX		= 1e10;
maxIts_pm = 100; % Maximum iterations for posterior mode-finder
% Set up parameters and hyperparameters
[N,M]	= size(PHI);
W	= zeros(M,1);
Alpha	= initalpha*ones(M,1);
%Gamma	= ones(M,1);

for i=1:maxIts % or the difference of largest alpha value between two successive iteration 
  useful	= (Alpha<ALPHA_MAX);
  usedAlpha	= Alpha(useful);
  % Prune Weights and basis
  W(~useful)	= 0;
 % diagSigOfHessian(~useful)=0;
  PHI_UsedNodes	= PHI(:,useful);
  %try
    [W(useful),diagSigOfHessian,isFailed] = SB_PosteriorMode(PHI_UsedNodes,t,W(useful),usedAlpha,maxIts_pm);
if isFailed || isempty(diagSigOfHessian)
    if isFailed && i<3 %  the hessian matrix is singual or condition sick
       Weights=[]; UsedNodes=1; Alpha=[];  Gamma=[];
       return;
    end
    break;
end
   if size(usedAlpha,1)~=size(diagSigOfHessian,1)
       fprintf('dimension not equally\n');
   end
    Gamma		= 1 - usedAlpha.*diagSigOfHessian;%(useful);
    clear diagSigOfHessian;
    logAlpha		= log(Alpha(useful));
    % Alpha re-estimation
    Alpha(useful)	= Gamma ./ (W(useful).^2);
    % Terminate if the largest alpha change is smaller than threshold
    Alpha_old		= Alpha(useful);
    maxDAlpha	= max(abs(logAlpha(Alpha_old~=0)-log(Alpha_old(Alpha_old~=0))));
    if maxDAlpha<MIN_DELTA_LOGALPHA
        break;
    end
end
Weights	= W(useful); % the weights between the hidden layer and output layer
UsedNodes	= find(useful);
end



  
  
