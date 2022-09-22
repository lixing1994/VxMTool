function dydt=Sp(t,y)
% this is the function of free falling ball
% m*d2(x) + c*d(x) + x =0
% transfer this function to
% y(1) equals x; y(2) equals x';
% d(y(1)) = y(2)
% d(y(2)) = -(c/m)*y(2) - (k/m)*y(1)

%m=1
g = -9.81;
dydt=[y(2);2*g];
end