% This file compares prision in two different ways. 
% 1.solve the equation in one step
% 2.solve the equation in many steps, former result as next step's input
% then compare the error

clc;clear;
%1
tspan = 0:0.1:20;
[T1,Y1]=ode45(@F,tspan,[0;1]);
%2
Y2=[0,1];
[T,Y]=ode45(@F,[0,0.1],[0;1]);
Y2(end+1,1:2)=[Y(end,1),Y(end,2)];
for i =1:199

    [T,Y]=ode45(@F,[0,0.1],[Y(end,1),Y(end,2)]);
    % add a bump, change vel
%     if i==100
%         Y(end,2) = Y(end,2)-0.3;
%     end
    Y2(end+1,1:2)=[Y(end,1),Y(end,2)];
end
plot(T1,Y1(:,1))

hold on 
plot(T1,Y2(:,1))

% obviously the error is not significant. (under no bump situation)
% d2's error is almost 10 times of d1
err = sum(Y2-Y1)