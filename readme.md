# VxMTool

VxMTool is a synchronous co-simulation toolbox for Vrep(coppeliarobotics) and Matlab. 

Although Vrep has the built-in function of co-simulation between Vrep and Matlab both synchronous  and non-synchronous, but it don't have a good support for synchronous co-simulation. Besides, with the help of VxMTool, we can do a lot of self-defined functions such like you can calculate the dynamics in Matlab by self-defined algorithm and leave the collision and contact calculation to Vrep which is quite difficult for Matlab.

## How to use

#### 1.Create cache folder

```
C:\VxMToolCache\
  	|--flag.txt
  	|--matlab_output.txt
  	|--vrep_output.txt
```

<p align="center" width="100%">
  <img src=".\image\cache.png" />
</p>

#### 2.Set init data

When you set 1 in `flag.txt`, matlab will read data from `vrep_output.txt`, run your algorithm and return data write to `matlab_output.txt`. After that, reset `flag.txt` to 0.

When you set 0 in `flag.txt`, Vrep will read data from `matlab_output.txt`, the rest procedures are the same.

So, if you want to start this co-simulation, you need to manually set the init data either to Matlab or Vrep. 

<p align="center" width="100%">
  <img src=".\image\how to start.png" width="400" />
</p>

#### 3.Run co-simulation

## Demo1

Demo1 is a simulation of a single spring-damper system. 

<p align="center" width="100%">
  <img src=".\image\spring-damper system.jpg" width="300" />
</p>

It can be described as follow

<p align="center" width="100%">
  <img src=".\image\eq1.png"  />
</p>

Here we need to transfer it to first-order ordinary differential equations to fit in Matlab

<p align="center" width="100%">
  <img src=".\image\eq2.png"  />
</p>

Function of the cubic.

```matlab
function dydt=Cu(t,y)
% this is the function of single spring-damper system 
% m*d2(x) + c*d(x) + x =0
% transfer this function to
% y(1) equals x; y(2) equals x';
% d(y(1)) = y(2)
% d(y(2)) = -(c/m)*y(2) - (k/m)*y(1)
%m=1
c=1;
k=500;
dydt=[y(2);-c*y(2)-k*y(1)];
end
```



Matlab calculate the z axis location and velocity by ode45. Solve this equation and you get a  decaying harmonic curve

<p align="center" width="100%">
  <img src=".\image\normal.png"  />
</p>

With the help of VxMTool, you can visualize it.

<p align="center" width="100%">
  <img src=".\image\demo1.gif"  />
</p>

## Demo2

In demo2, we add a ball free falling upon the cubic, when ball touch the cubic they exchange moment(m1=m2=1).

Model of ball

<p align="center" width="100%">
  <img src=".\image\eq3.png"  />
</p>

Transfer to first-order ordinary differential equations
<p align="center" width="100%">
  <img src=".\image\eq4.png"  />
</p>

Function of ball

```matlab
function dydt=Sp(t,y)
%m=1
g = -9.81;
dydt=[y(2);2*g];
end
```

When there is a bump, the velocity changes. The collision detection is achieved by Vrep built-in function.

```lua
-- check collision
collision,trash=sim.checkCollision(cu,sp)
if (collision==1 and cu_vel>0 and sp_vel<0) or 
    (collision==1 and cu_vel<0 and sp_vel < cu_vel) or
    (collision==1 and cu_vel>0 and sp_vel < cu_vel) then
    bump=1
else
    bump=0
end
```

<p align="center" width="100%">
  <img src=".\image\bump.png"  />
</p>

It's easy for Vrep to do the collision detection especially in higher dimension and the contact surface is complicated.

<p align="center" width="100%">
  <img src=".\image\demo2.gif"  />
</p>