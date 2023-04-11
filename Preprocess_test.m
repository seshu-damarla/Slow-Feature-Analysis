%dvgpro%

function [vx]=Preprocess_test(x,degree,BB)
% s=x;
% s0=s_mean;sstd=s_std;
% s_norml=(s-s0)./sstd;
% % cov_s=((s'*s)/(1))-s0'*s0;
% % [U,S,V]=svd(cov_s);
% % W0=diag((diag(S)).^(-0.5))*U';
% % size(W0)
% % size(s)
% % size(s0)
% % x=W0*((s-s0)');x=x';
% 
% vx=(Fun_Expansion(s_norml,degree));
% % vx0=mean(vx);
% size(vx)
% size(vx0)
% vx_meanfree=(vx-vx0);%./vx_std;
% vx=W0*(vx'-vx0');vx=vx';
% x=W0*(x-s_mean)';x=x';
% x=W0*x';x=x';
vx=(Fun_Expansion(x,degree))';
vx=(vx-BB);
end