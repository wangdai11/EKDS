function F = fitness(x)
%%  Adjustable parameters   
     K = round(x(1));
     a = round(x(2));
  

 %% Testing signal
load('data.mat')
 
%% VMD parameters
    
    tau = 0;            % noise-tolerance (no strict fidelity enforcement)
    DC = 0;             % no DC part imposed
    init = 1;           % initialize omegas uniformly
    tol = 1e-7;
  
    [u] = VMD(s, a, tau, K, DC, init, tol);

%% MESEV
for i = 1:K
en = 0;
a = sqrt(imag(hilbert(u(i,:))).^2 + u(i,:).^2);
for j = 1: length(a)
p(j) = a(j)/sum(a);
en = -sum(p.*log(p));
end
ep(i) = en;
end
emin = min(ep);

F = emin;