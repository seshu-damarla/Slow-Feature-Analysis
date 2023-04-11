%dvgpro%
function [Y,lambda,W,vx0]=nSFA_Wiskott(s,degree,index)

for AI=1:1:index   % Iterative SFA
Ss=s';
s_mean=mean(Ss);   % mean of training data
s_std=(std(Ss));   % std of training data
s_norml=zeros(size(Ss)); 
for ii=1:1:size(Ss,2)
    s_norml(:,ii)=(Ss(:,ii)-s_mean(ii))/s_std(ii); % z-score normalization
end
x=s_norml';
vx=(Fun_Expansion(x',degree))';   % expansion of normalized input signal
vx0=mean(vx,2);
B=((vx*vx')/(length(vx)))-(vx0*vx0');
size(B)
[U,S,V]=svd(B);                   
W0=diag((diag(S)).^(-0.5))*U';    % whitening matrix
BB=[];
for j=1:size(vx,1)
BB=[BB;vx0(j)*ones(1,size(vx,2))];
end

z=W0*(vx-BB);                     % breaking correlation among features of inut signal
diff_vx=diff(z,1,2);              % time derivtive of expanded signal
diff_vx0=mean(diff_vx,2);
Cprime=((diff_vx*diff_vx')/(length(diff_vx)))-(diff_vx0*diff_vx0'); % Covariance matrix of whitened expaned signal
% [U1,S1]=eig(Cprime);
[U1,S1,V1]=svd(Cprime);
lambda=(sort(diag(S1)));  % eigenvalues in ascending order
U11=zeros(size(U1));
for i=1:size(U1,2)
    U11(:,i)=U1(:,end-i+1);
end
Wj_prime=U11';   % weights
Y=Wj_prime*z;    % SFA output signal
s=Y;             % for repetition
end
W=Wj_prime*W0;  % weight along with whitening matrix
end

