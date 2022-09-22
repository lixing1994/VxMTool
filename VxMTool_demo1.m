clc;clear;
file_flag = 'C:\VxMToolCache\flag.txt';
file_vrep_output = 'C:\VxMToolCache\vrep_output.txt';
file_matlab_output = 'C:\VxMToolCache\matlab_output.txt';

dt = 0.01; %Don't forget set the same dt in Vrep.
tspan = [0,dt];

%% recreate cache files && write init data to vrep_output.txt
zero_point = 0.5; % zero point for spring-damper system
init_data = [zero_point + 0.2 , 0]; % loc and vel
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
       %% YOUR Algrithm
        [~,Y]=ode45(@Cu,tspan,[loc-zero_point;vel]);
        new_loc = Y(end,1) + zero_point;
        new_vel = Y(end,2);
       %% write
        VxMTool_writeMatlabOutput(file_matlab_output,[new_loc,new_vel]);
       %% reset flag
        VxMTool_resetFlag(file_flag);
  end
end