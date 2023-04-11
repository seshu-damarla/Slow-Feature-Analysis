%dvgpro%
clc
clear all

load debutanizer.mat
rng('default') 

% original data
Xorg=[u1 u2 u3 u4 u5 u6 u7];% Soft sensor inputs
Yorg=y;% Soft sensor traget variable
Data=[Xorg Yorg];

Data=rmoutliers(Data);
Xorg=Data(:,1:end-1);Yorg=Data(:,end);

method='RS';Ns=1500;
[Xtraining_data,Xtesting_data,training_QualityVar,testing_Qualityvar]=train_test_data(Xorg,Yorg,method,Ns,0);

X=Xtraining_data;y=training_QualityVar;

% [~,bootsam] = bootstrp(10,[],X,y);
% X=X(bootsam(:,9),:); y=y(bootsam(:,9),:);

meanX=mean(X);stdX=std(X);
for i=1:1:size(X,2)
    X(:,i)=(X(:,i)-meanX(i))/stdX(i);
end

meany=mean(y);stdy=std(y);
y_norml=(y-meany)/stdy;Y_measured=y_norml;

index=1;degree=2;
[S,eigenvalue,Weight,BB]=nSFA_Wiskott(X',degree,index);
XS=S';
nsfa=size(XS,2);
N_slowfea=nsfa;  % optimum no.of slow features
XS=XS(:,1:N_slowfea);
S_features=XS;

beta=LeastSquares(S_features,Y_measured);
Y_predicted=S_features*beta;

Y_predicted=Y_predicted*stdy+meany;  
Y_measured=Y_measured*stdy+meany;

[AE_train,MAE_train,RMSE_train,R_train]=PerfMeas(Y_measured,Y_predicted);
[AE_train;MAE_train;RMSE_train;R_train]

t=[1:1:length(y)];

figure(1)
plot(t,Y_measured,'b',t,Y_predicted,'r')
xlabel('sample number'),ylabel('NB Ratio in IPS Feed Stream')
legend('Lab data','Model output')
title('Performance of soft sensor during training')

figure(2)
subplot(2,1,1),plot(t,S(1,:))
subplot(2,1,2),plot(t,S(2,:))

close all

%% testing;online prediction 

Xtest=Xtesting_data;
ymeas_test=testing_Qualityvar;

% Xtest=Xtraining_data;  ymeas_test=training_QualityVar;

Ypred_test=zeros(size(ymeas_test));

% online prediction using one sample at a time

for i=1:1:size(Xtest,2)
    Xtest(:,i)=(Xtest(:,i)-meanX(i))/stdX(i);
end
% preprocessing
[vx_test]=Preprocess_test(Xtest,degree,BB);%(xtest,dg,vx0',s0',vx_std,W0);
S1=Weight*vx_test;S1=S1';Stest=S1(:,1:N_slowfea);
Stest_features=Stest;
ypred_test=Stest_features*beta;
Ypred_test=ypred_test;

Ypred_test=Ypred_test*stdy+meany;

[AE_test,MAE_test,RMSE_test,R_test]=PerfMeas(ymeas_test,Ypred_test);
[AE_test;MAE_test;RMSE_test;R_test]

t=[1:1:length(ymeas_test)];

figure(3)
subplot(2,1,1),plot(t',Stest(:,1))
subplot(2,1,2),plot(t',Stest(:,end))

figure(4)
plot(t,Ypred_test,'r',t,ymeas_test,'b')
xlabel('sample number'),ylabel('NB Ratio in IPS Feed Stream')
legend('Lab data','Model output')
title('Performance of soft sensor during testing')

% close all