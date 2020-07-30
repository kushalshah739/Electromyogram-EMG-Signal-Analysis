Windowdata.m

function [averagedata,variancedata,dynamicrangedata,rmsdata,meansqrdata] = WindowData(bicepdata,window)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%PADDING DATA
c=zeros(1,window);
c=c.';
padded=vertcat(bicepdata,c);
lengthofdata=length(bicepdata);


%CREATE WINDOW
for i = 1:lengthofdata
    %GET WINDOW DATA
    windowdata=padded(i:i+window);
    %GET SHORT TERM ANALYSIS VARIABLE
    avedat(i)=mean(windowdata);
    vardat(i)=var(windowdata);
    dynamicrangedat(i)=max(windowdata)-min(windowdata);
    RMSdat(i)=rms(windowdata);
    MSdat(i)=(rms(windowdata))^2;
end

averagedata=avedat;
variancedata=vardat;
dynamicrangedata=dynamicrangedat;
rmsdata=RMSdat;
meansqrdata=MSdat;


end

