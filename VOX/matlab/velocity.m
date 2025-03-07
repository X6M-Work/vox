function [ velocity_vx, velocity_vz, velocity_mx, velocity_mz ] = velocity( T, xv, xm, zv, zm, x_1, z_1 )
%the velocity function calculates the velocity of the left and right
%vocal folds for the x- and z-direction and returns these as output parameters

global velocity_vx
global velocity_vz

global velocity_mx
global velocity_mz



velocity_vx = [(xv(1,:) - x_1(1,1:length(x_1)/2)) .* T; (xv(2,:) - x_1(2,1:length(x_1)/2)).* T]; %velocity_vx is an (2xMAXM) matric including the velocity of each mass

velocity_vz = [(zv(1,:) - z_1(1,1:length(z_1)/2)) .* T; (zv(2,:) - z_1(2,1:length(z_1)/2)).* T];


velocity_mx = [(xm(1,:) - x_1(1,length(x_1)/2+1:length(x_1))) .* T; (xm(2,:) - x_1(2,length(x_1)/2+1:length(x_1))) .* T];

velocity_mz = [(zm(1,:) - z_1(1,length(z_1)/2+1:length(z_1))) .* T; (zm(2,:) - z_1(2,length(z_1)/2+1:length(z_1))) .* T];


return

