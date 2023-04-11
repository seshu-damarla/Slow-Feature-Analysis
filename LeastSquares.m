%dvgpro%

function beta=LeastSquares(X,Y)
% X-columns are variables,rows are dtapoints
A=X'*X;
B=X'*Y;
beta=A\B;
% beta=linsolve(X,Y);
end