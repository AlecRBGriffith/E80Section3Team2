function [ z, y, z ] = six_dof(ax,ay,az,gx,gy,gz,dt)
%
% This function takes acceleration and angular velocity data and produces
% x,y,z cartesian coordinates
%
% NOTE: This function asigns a starting position of (0,0,0) and initial 
%       orientation along the x-axis
%
% INPUTS:
%     - ax: acceleration along the x-axis in the local frame, in m/s^2
%     - ay: acceleration along the y-axis in the local frame, in m/s^2
%     - az: acceleration along the z-axis in the local frame, in m/s^2
%
%     - gx: angular acceleration about the x-axis, in radians per second
%     - gy: angular acceleration about the y-axis, in radians per second
%     - gz: angular acceleration about the z-axis, in radians per second
%
%     - dt: timestep for all of the input vectors
%
% OUTPUTS:
%     - x: x coordinate in the global frame
%     - y: y coordinate in the global frame
%     - z: z coordinate in the global frame
%

% Generate angular positions by using a cumulative integration of angular
% velocities
theta_x = cumtrapz(gx)*dt;
theta_y = cumtrapz(gy)*dt;
theta_z = cumtrapz(gz)*dt;

% Loop through every point in time and generate rotation matrices to
% convert the accelerations from the local fram to the global frame
for i = 1:length(theta_x)
    % Generate rotation matrices
    Rx = [ 1,                0,                0;
           0,  cos(theta_x(i)), -sin(theta_x(i));
           0,  sin(theta_x(i)),  cos(theta_x(i)) ];

    Ry = [  cos(theta_y(i)), 0, sin(theta_y(i));
    	                  0, 1,               0;
           -sin(theta_y(i)), 0, cos(theta_y(i)) ];

    Rz = [ 1,                0,                0;
           0,  cos(theta_z(i)), -sin(theta_z(i));
           0,  sin(theta_z(i)),  cos(theta_z(i)) ];

    % This is the acceleration vector in the local frame
    a = [ax(i);
         ay(i);
         az(i) ];
     
    % Use the rotation matrices to take the acceleration from the local
    % frame to the global frame
    global_a = Rx*Ry*Rz*a;
    
    % overwrite the local frame accelerations with the calculated
    % accelerations in the global frame
    ax(i) = global_a(1);
    ay(i) = global_a(2);
    az(i) = global_a(3);

end

% Integrate the accelerations in the global frame to get the x,y,z
% coordinates in the global frame
x = cumtrapz(cumtrapz(ax)*dt)*dt;
y = cumtrapz(cumtrapz(ay)*dt)*dt;
z = cumtrapz(cumtrapz(ay)*dt)*dt;

end

