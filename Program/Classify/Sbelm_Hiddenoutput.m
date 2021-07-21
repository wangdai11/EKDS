%calculate the hidden outputs 
function [Omega, Wih, BiasofHiddenNeurons]=Sbelm_Hiddenoutput(X,NumberofHiddenNeurons, Activation,seed)
[N,M]=size(X);
NumberofInputNeurons=M;
if nargin>=4
 rand('seed',seed);
end
InputWeight=rand(NumberofHiddenNeurons,NumberofInputNeurons)*2-1;
BiasofHiddenNeurons=rand(NumberofHiddenNeurons,1)*2-1;
%calculate hidden outputs
tempH=X*InputWeight';
for n=1:N
    tempH(n,:)= tempH(n,:)+BiasofHiddenNeurons';
end
Omega = Sbelm_HiddenActivation(tempH, Activation);
Wih = InputWeight';
end



