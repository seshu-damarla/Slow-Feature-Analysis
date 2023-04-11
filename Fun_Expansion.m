function DATA=Fun_Expansion(DATA,degree)
% EXPANSION Expand a signal in the space of polynomials of degree 2.
%   EXPDATA = EXPANSION(HDL, DATA) expands the data set 'DATA' in the 
%   space of polynomials of degree n. 
if degree==2
  n=size(DATA,2);
  
  % allocate expansion space
  DATA=[DATA zeros(size(DATA,1), xp_dim(n)-size(DATA,2))];
  k=n+1;
  for i=1:n,
    len=n-i+1;
    tmp=repmat(DATA(:,i),1,len);
    DATA(:,k:k+len-1)=tmp.*DATA(:,i:n);
    k=k+len;
  end 
%   DATA=cat(2, DATA, DATA.^4);
elseif degree==3
    x1=DATA(:,1);x2=DATA(:,2);
    DATA=[x1 x2 (x1.^2) (x2.^2) (x1.*x2) (x1.^3) ((x1.^2).*x2) (x1.*(x2.^2)) (x2.^3)];
else
    DATA=DATA;
end      
  
%   return
%   
%   % old version
%   k=n;
%   for i=1:n,
%     tmp=DATA(:,i);
%     for j=i:n,
%       k=k+1;
%       DATA(:,k)=tmp.*DATA(:,j);
%     end
%   end
%   DATA=[DATA ones(length(DATA),1)];
end
