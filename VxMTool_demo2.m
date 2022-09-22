clc;clear;
file_flag = 'C:\VxMToolCache\flag.txt';
file_vrep_output = 'C:\VxMToolCache\vrep_output.txt';
file_matlab_output = 'C:\VxMToolCache\matlab_output.txt';

dt = 0.01; %Don't forget set the same dt in Vrep.
tspan = [0,dt];

%% recreate cache files && write init data to vrep_output.txt
zero_point = 0.5; % zero point for spring-damper system
cubic_init_velocity = 0;
ball_init_height = 0.8;
ball_init_velocity = 0;
init_data = [zero_point - 0.2 , cubic_init_velocity , ball_init_height,ball_init_velocity,0]; 
VxMTool_initFilesByMatlab(file_flag,file_vrep_output,init_data);
%%
%loop
while 1
  RnW = VxMTool_readSignalFile(file_flag);
  
  if RnW
       %% read 
        readData = VxMTool_readFromVrep(file_vrep_output);
       %% process readData
        loc = readData(1);
        vel = readData(2);
        height = readData(3);
        ball_vel = readData(4);
        bump = readData(5);
       %% YOUR Algrithm
        [~,Y1]=ode45(@Cu,tspan,[loc-zero_point;vel]);
        [~,Y2]=ode45(@Sp,tspan,[height,ball_vel]);
        cubic_new_loc = Y1(end,1) + zero_point;
        cubic_new_vel = Y1(end,2);
        ball_new_loc = Y2(end,1);
        ball_new_vel = Y2(end,2);
        if bump == 1
            [cubic_new_vel,ball_new_vel] = exchangeMoment(cubic_new_vel,ball_new_vel);
        end
       %% write
        VxMTool_writeMatlabOutput(file_matlab_output,[cubic_new_loc,cubic_new_vel,ball_new_loc,ball_new_vel]);
       %% reset flag
        VxMTool_resetFlag(file_flag);
  end
end

function [v1,v2]=exchangeMoment(v1,v2)
temp = v1;
v1 = v2;
v2 = temp;
end