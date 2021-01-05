

%% recursive - simple example
clear all; clc
x = 1:1:10;

% by batch method
AveBatch = 1/(size(x,2))*sum(x)

% by recursive method 
AveRec(1) = x(1);   % initialize
for i = 2:10
    AveRec(i) =((i-1)/i)* AveRec(i-1) +(1/i)*x(i);   
end
AveRec

%%  recursive min. var. estimator
% generate uniform R.V. on (a,b)  
% S.Kim 12/26/2020

clear all; clc
a1 = 0; b1 = 4;   
x =  a1 +(b1-a1)*rand(100,1);   % the state 
mean(x);     % mean 
var(x);         % variance   (b-a)^2/12

a2 = -1/2; b2=1/2; 
v =  a2 +(b2-a2)*rand(100,1);   % the noise
mean(v);     % mean 
var(v);         % variance   (b-a)^2/12

% generate the measurement

for i =1:100
    z(i) = x(i)+v(i);
end
mean(z);

% design recursive MV estimator
% define parameter 

MeanX  = mean(x);  % mean of state
H  = 1;                  % weighting of state
M  = (b1-a1)^2/12;  % variance of state
V  = (b2-a2)^2/12;   % variance of noise


% initialize
mvX(1)  = MeanX;
P(1) =inv(inv(M) + H'*inv(V)*H);
K(1) = P(1)*H'*inv(V);
mvX(1) = MeanX + K(1)*(z(1) - H*MeanX);
% recursive

for i = 2: 100
    P(i) = inv(inv(P(i-1)) + H'*inv(V)*H);
    K(i) = P(i)*H'*inv(V);
    mvX(i) = mvX(i-1) + K(i)*(z(i) - H*mvX(i-1));
end

plot(1:100, z, 'b', 1:100, mvX, 'r'); grid on

