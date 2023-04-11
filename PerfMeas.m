%dvgpro%

function [AE,MAE,RMSE,Corr]=PerfMeas(d,yy)
AE=max(abs(d-yy));
MAE=(sum(abs(d-yy)))/length(d);
RMSE=sqrt((sum((d-yy).^2))/length(d));
Corr=sum((d-mean(d)).*(yy-mean(yy)))/sqrt(sum((d-mean(d)).^2).*sum((yy-mean(yy)).^2));
end