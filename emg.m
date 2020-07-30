%% Exercise 1.1
isobicepdata=readtable('isobiceps.csv');
%DATA INPUTS
bicepdata=isobicepdata(:,2);
sampfreq=1000;
secpersamp=1/sampfreq;
time=(0:26039-1);
time=time*secpersamp;
time=time.';
bicepdata=table2array(bicepdata);

%% WINDOW 1

window1=0.25;
window1=window1*sampfreq;

%Short-Term Analysis Variables
[Average1,Variance1,DR1,RMS1,MS1]= WindowData(bicepdata,window1);
%Flip to Vertical
Average1=Average1.';
Variance1=Variance1.';
DR1=DR1.';
RMS1=RMS1.';
MS1=MS1.';

%Plot of Short-Term Analysis Variables over Original
figure(1)
plot(time,bicepdata);
title('Plot of Short-Term Analysis Features of Bicep Data (Window Size 0.25sec)')
xlabel('Time(s)')
ylabel('Voltage(V)')
hold on
plot(time,Average1);
plot(time,Variance1);
plot(time,DR1);
plot(time,RMS1);
plot(time,MS1);
legend('Original Data','Average','Variance','Dynamic Range','RMS','MeanSquare')
hold off

%% WINDOW 2

window2=0.05;
window2=window2*sampfreq;

%Short-Term Analysis Variables
[Average2,Variance2,DR2,RMS2,MS2]= WindowData(bicepdata,window2);
Average2=Average2.';
Variance2=Variance2.';
DR2=DR2.';
RMS2=RMS2.';
MS2=MS2.';

%Plot of Short-Term Analysis Variables Over Original
figure(2)
plot(time,bicepdata);
title('Plot of Short-Term Analysis Features of Bicep Data (Window Size 0.05sec)')
xlabel('Time(s)')
ylabel('Voltage(V)')
hold on
plot(time,Average2);
plot(time,Variance2);
plot(time,DR2);
plot(time,RMS2);
plot(time,MS2);
legend('Original Data','Average','Variance','Dynamic Range','RMS','MeanSquare')
hold off

%% WINDOW 3

window3=1;
window3=window3*sampfreq;

%Short-Term Analysis Variables
[Average3,Variance3,DR3,RMS3,MS3]= WindowData(bicepdata,window3);
Average3=Average3.';
Variance3=Variance3.';
DR3=DR3.';
RMS3=RMS3.';
MS3=MS3.';

%Plot of Short-Term Analysis Variables Over Original
figure(3)
plot(time,bicepdata);
title('Plot of Short-Term Analysis Features of Bicep Data (Window Size 1sec)')
xlabel('Time(s)')
ylabel('Voltage(V)')
hold on
plot(time,Average3);
plot(time,Variance3);
plot(time,DR3);
plot(time,RMS3);
plot(time,MS3);
legend('Original Data','Average','Variance','Dynamic Range','RMS','MeanSquare')
hold off

Exercise 2:

%% Experiment 2

% Opening File
m = readtable('GraspForce.csv');

% Creating vectors
tx2 = m(:,1); %extracting time values from the experiment data
tx2 = tx2{:,:}; %making the matrix useful for calculations
emgx2 = m(:,2); %extracting emg values from the experiment data
emgx2 = emgx2{:,:}; %making the matrix useful for calculations
forcex2 = m(:,3); %extracting force values from the experiment data
forcex2 = forcex2{:,:}; %making the matrix useful for calculations

timex2 = 0 : length(tx2) - 1;
timex2 = timex2 * 0.001; %conversion of time array to take into the account the sampling rate (1000Hz)

%Normalizing the data
normForce = forcex2 - min(forcex2(:));
normForce = normForce ./ max(normForce(:));

normemg = emgx2 - min(emgx2(:));
normemg = normemg ./ max(normemg(:));

normemg2 = normemg;
normForce2 = normForce;

%Threshold for the data to find where fore was applied

thresholdind = find(0.12>normForce2); %finding where the force is below the threshold
normForce2(thresholdind) = 0;
normemg2(thresholdind) = 0;

% normForce = normForce .* (normForce>0.12); similar to above code but may

%% Plots showing where force was applied

normemg2(normemg2 == 0) = nan;
figure(1)
plot(timex2,normemg);
title('Sections of Interest on EMG Plot')
xlabel('Time(s)')
ylabel('Voltage(V)')
ylim([0.6 0.8])
hold on;
ylim([0.6 0.8])
plot(timex2,normemg2,'color','r');
legend('Original Signal', 'Sectioned Signal')
hold off;

normForce2(normForce2 == 0) = nan;
figure(2)
plot(timex2,normForce);
title('Sections of Interest on Force Plot')
xlabel('Time(s)')
ylabel('Voltage(V)')
hold on;
plot(timex2,normForce2,'color','r');
legend('Original Signal', 'Sectioned Signal')
hold off;


%% Find range function to find the areas of interest

nanLocations = ~isnan(normForce2); % Get logical array of whether element is NaN or not.
props = regionprops(nanLocations, 'Area', 'PixelIdxList'); % Find all the regions.
% DONE!  Now let's print them out
for k = 1 : length(props)
  fprintf('Region #%d has length %d and starts at element %d and ends at element %d\n',...
	k, props(k).Area, props(k).PixelIdxList(1), props(k).PixelIdxList(end));
end

%% Window for each section of the signals outlined by the code above

%creating vectors with the respective window sizes based off of above code
forcesec1 = normForce(4949:8720);
forcesec2 = normForce(11873:14696);
forcesec3 = normForce(18009:21180);
forcesec4 = normForce(24753:28580);
forcesec5 = normForce(31773:35976);
forcesec6 = normForce(39069:43324);

emgsec1 = normemg(4949:8720);
emgsec2 = normemg(11873:14696);
emgsec3 = normemg(18009:21180);
emgsec4 = normemg(24753:28580);
emgsec5 = normemg(31773:35976);
emgsec6 = normemg(39069:43324);

%windows
sampfreq=1000;
window1=0.25;
window1=window1*sampfreq;

%Short-Term Analysis Variables
%FSec1
[AverageF1,VarianceF1,DRF1,RMSF1,MSF1]= WindowData(emgsec1,window1);
%Flip to Vertical
AverageF1=mean(AverageF1);
meanF1=mean(forcesec1);
VarianceF1=mean(VarianceF1);
DRF1=mean(DRF1);
RMSF1=mean(RMSF1);
MSF1=mean(MSF1);

%FSec2
[AverageF2,VarianceF2,DRF2,RMSF2,MSF2]= WindowData(emgsec2,window1);
%Flip to Vertical
AverageF2=mean(AverageF2);
meanF2=mean(forcesec2);
VarianceF2=mean(VarianceF2);
DRF2=mean(DRF2);
RMSF2=mean(RMSF2);
MSF2=mean(MSF2);

%FSec3
[AverageF3,VarianceF3,DRF3,RMSF3,MSF3]= WindowData(emgsec3,window1);
%Flip to Vertical
AverageF3=mean(AverageF3);
meanF3=mean(forcesec3);
VarianceF3=mean(VarianceF3);
DRF3=mean(DRF3);
RMSF3=mean(RMSF3);
MSF3=mean(MSF3);

%FSec4
[AverageF4,VarianceF4,DRF4,RMSF4,MSF4]= WindowData(emgsec4,window1);
%Flip to Vertical
AverageF4=mean(AverageF4);
meanF4=mean(forcesec4);
VarianceF4=mean(VarianceF4);
DRF4=mean(DRF4);
RMSF4=mean(RMSF4);
MSF4=mean(MSF4);

%FSec5
[AverageF5,VarianceF5,DRF5,RMSF5,MSF5]= WindowData(emgsec5,window1);
%Flip to Vertical
AverageF5=mean(AverageF5);
meanF5=mean(forcesec5);
VarianceF5=mean(VarianceF5);
DRF5=mean(DRF5);
RMSF5=mean(RMSF5);
MSF5=mean(MSF5);

%FSec6
[AverageF6,VarianceF6,DRF6,RMSF6,MSF6]= WindowData(emgsec6,window1);
%Flip to Vertical
AverageF6=mean(AverageF6);
meanF6=mean(forcesec6);
VarianceF6=mean(VarianceF6);
DRF6=mean(DRF6);
RMSF6=mean(RMSF6);
MSF6=mean(MSF6);
%% Linear regression values
AverageFvector = [meanF1, meanF2, meanF3, meanF4, meanF5, meanF6];
%force
meanFvector = [AverageF1, AverageF2, AverageF3, AverageF4, AverageF5, AverageF6];
%Variance
meanVvector = [VarianceF1,VarianceF2,VarianceF3,VarianceF4,VarianceF5,VarianceF6];
%DR
meanDRvector = [DRF1, DRF2, DRF3, DRF4, DRF5, DRF6];
%RMS
meanRMSvector = [RMSF1, RMSF2, RMSF3, RMSF4, RMSF5, RMSF6];
%MS
meanMSvector = [MSF1, MSF2, MSF3, MSF4, MSF5, MSF6];
%% Linear Regression
[meanFaverage,coeffF]=LinearRegression(AverageFvector,meanFvector);
[meanVaverage,coeffV]=LinearRegression(AverageFvector,meanVvector);
[meanDRaverage,coeffDR]=LinearRegression(AverageFvector,meanDRvector);
[meanRMSaverage,coeffRMS]=LinearRegression(AverageFvector,meanRMSvector);
[meanMSaverage,coeffMS]=LinearRegression(AverageFvector,meanMSvector );

%% Linear regression plots
%force
figure(5)
scatter(AverageFvector,meanFvector);
title('Mean Force True Value vs Force')
xlabel('Force Vector')
ylabel('Mean Force Vector')
hold on
plot(AverageFvector,meanFaverage);
text(0.4,0.664,'y = 0.0096F + 0.6622');
hold off;

%variance
figure(6)
scatter(AverageFvector,meanVvector);
title('Variance True Value vs Force')
xlabel('Force Vector')
ylabel('Mean Force Variance')
hold on
plot(AverageFvector,meanVaverage);
text(0.4,0.0055,'y = -0.0021F + 0.0064');
hold off;

%DR
figure(7)
scatter(AverageFvector,meanDRvector);
title('Dynamic Range True Value vs Force')
xlabel('Force Vector')
ylabel('Mean Force Dynamic Range')
hold on
plot(AverageFvector,meanDRaverage);
text(0.4,0.075,'y = 0.0351F + 0.0653');
hold off;

%RMS
figure(8)
scatter(AverageFvector,meanRMSvector);
title('Root Mean Squared True Value vs Force')
xlabel('Force Vector')
ylabel('Mean Force Root Mean Squared')
text(0.4,0.673,'y = 0.0065F + 0.6714');
hold on
plot(AverageFvector,meanRMSaverage);
hold off;

%MS
figure(9)
scatter(AverageFvector,meanMSvector);
title('Mean Squared True Value vs Force')
xlabel('Force Vector')
ylabel('Mean Force Mean Squared')
text(0.4,0.458,'y = 0.0067F + 0.4568');
hold on
plot(AverageFvector,meanMSaverage);
hold off;
%% Residuals
% force
res1 = meanFvector - meanFaverage;
% variance
res2 = meanVvector - meanVaverage;
% DR
res3 = meanDRvector - meanDRaverage;
% RMS
res4 = meanRMSvector - meanRMSaverage;
%MS
res5 = meanMSvector - meanMSaverage;
%% Residual Plots
%force
figure(5)
scatter(AverageFvector,res1);
title('Force Residuals')
hold on
scatter(AverageFvector,meanFaverage);
legend('True Values','Residuals');
hold off;

%variance
figure(6)
scatter(AverageFvector,res2);
title('Variance Residuals')
hold on
scatter(AverageFvector,meanVaverage);
legend('True Values','Residuals');
hold off;

%DR
figure(7)
scatter(AverageFvector,res3);
title('Dynamic Range Residuals')
hold on
scatter(AverageFvector,meanDRaverage);
legend('True Values','Residuals');
hold off;

%RMS
figure(8)
scatter(AverageFvector,res4);
title('Root Mean Squared Residuals')
hold on
scatter(AverageFvector,meanRMSaverage);
legend('True Values','Residuals');
hold off;

%MS
figure(9)
scatter(AverageFvector,res5);
title('Mean Squared Residuals')
hold on
scatter(AverageFvector,meanMSaverage);
legend('True Values','Residuals');
hold off;
%% Mean square error and Correlation Coefficients
[MSEF,coeffF]=MSEandResiduals(AverageFvector,meanFvector);
[MSEV,coeffV]=MSEandResiduals(AverageFvector,meanVvector);
[MSEDR,coeffDR]=MSEandResiduals(AverageFvector,meanDRvector);
[MSERMS,coeffRMS]=MSEandResiduals(AverageFvector,meanRMSvector);
[MSEMS,coeffMS]=MSEandResiduals(AverageFvector,meanMSvector);

%% 20 Windows

windows = [0.02,0.04,0.06,0.08,0.1,0.2,0.4,0.6,0.8,1,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2];
for i = 1:20
	window=windows(i);
	window=window*sampfreq;
	[msemean2(i),coeffmean2(i),msems2(i),coeffms2(i),mserms2(i),coeffrms2(i)]=exp2p2(AverageFvector,window,emgsec1,emgsec2,emgsec3,emgsec4,emgsec5,emgsec6);
end

%making data vetors length 20
msemean2=msemean2(1:20);
coeffmean2=coeffmean2(1:20);
msems2=msems2(1:20);
coeffms2=coeffms2(1:20);
mserms2=mserms2(1:20);
coeffrms2=coeffrms2(1:20);

figure(10)
plot(windows,msemean2);
hold on
title('MSE and Correlation Coefficients for Mean');

plot(windows,coeffmean2);
legend('MSE','Correlation Coefficients');
hold off

figure(11)
plot(windows,msems2);
hold on
title('MSE and Correlation Coefficients for MS');
xlabel('Window size (sec)')
plot(windows,coeffms2);
legend('MSE','Correlation Coefficients');
hold off

figure(12)
plot(windows,mserms2);
hold on
title('MSE and Correlation Coefficients for RMS');
xlabel('Window size (sec)')
plot(windows,coeffrms2);
legend('MSE','Correlation Coefficients');
hold off

Window function:
function [averagedata,variancedata,dynamicrangedata,rmsdata,meansqrdata] = WindowData(bicepdata,window)
%Pad
w=zeros(1,window);
w=w.';
padded=vertcat(bicepdata,w);
lengthofdata=length(bicepdata);

%Window
for i = 1:lengthofdata
	windowdata=padded(i:i+window);
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

End
