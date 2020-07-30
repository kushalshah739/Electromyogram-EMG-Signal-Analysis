
%Linear regression.m

function [output,coeff] = LinearRegression(ForceVector,AnalysisVector)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
coeff=polyfit(ForceVector,AnalysisVector,1);
output=polyval(coeff,ForceVector);
end
