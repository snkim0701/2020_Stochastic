
clear all; clc;
num = 1;
M = 1; % kg
b = 10;   % viscosity 
k = 20;  % srpring constant

%%  run simulink
%% check saved variables

whos
plot(tout, xout(:,1)); hold on; grid on
plot(tout,xout(:,2));
hold off

