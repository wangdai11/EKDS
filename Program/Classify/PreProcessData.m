%scale data to [-1,1]
function [BASIS,nor_factors] =PreProcessData(BASIS,nor_factors)

[N,M]	= size(BASIS);
if nargin<2
  nor_factors = zeros(2,M);
  for m=1:M
  %BASIS(:,m)	= BASIS(:,m) / Scales(m);
   max_el=max(BASIS(:,m));
   min_el=min(BASIS(:,m));
   nor_factors(1,m) = max_el;%*2; // in case of out of range for future points, we recommend a *2 for maximum value, and /2 for minimum values
   nor_factors(2,m)=min_el;%/2;
  end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%an
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%method
for m=1:M
  %BASIS(:,m)	= BASIS(:,m) / Scales(m);
%  max_el=max(BASIS(:,m));
%  min_el=min(BASIS(:,m));
  max_el = nor_factors(1,m) ;
  min_el =nor_factors(2,m);
  if max_el==min_el
      BASIS(:,m)=1.0;
  %else if max_el<=1.0 && min_el>=-1.0
          continue;
  else
       BASIS(:,m)	= 2*(BASIS(:,m)-min_el) / (max_el-min_el)-1;
      end
  end
end

