function [ impulse_vx, impulse_vz, impulse_mx, impulse_mz ] = impuls( lmv, lmm, rmv, rmm, velocity_vx, velocity_vz, velocity_mx, velocity_mz )
%the impuls fuction calculates the impuls for the left and right vocalis
%fold in x- and z-direction

    
    global impulse_vx
    global impulse_vz
    
    global impulse_mx
    global impulse_mz
    

    impulse_vx =[ lmv .* velocity_vx(1,:); rmv .* velocity_vx(2,:)]; %impulse_vx is a 2xMAXM matric with the impuls values for each vocalis mass in x direction
    impulse_vz =[ lmv .* velocity_vz(1,:); rmv .* velocity_vz(2,:)];
    
    impulse_mx =[ lmm .* velocity_mx(1,:); rmm .* velocity_mx(2,:)];
    impulse_mz =[ lmm .* velocity_mz(1,:); rmm .* velocity_mz(2,:)];

end

