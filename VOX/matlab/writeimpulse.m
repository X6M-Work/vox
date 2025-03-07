

%writeimpulse, writes the impulse of each vocalis folds in seperate matics
%considering vocalis, mucosa, x-direction and z-Direction
%Here are also the matrics time and massaxis computed, which are used for
%displaying 3D grafics in displayimpulse.m


%for s = 1:11
for s = 1:MAXM
       impulse_vx_left(n, s) = impulse_vx(1, s); %impulse_vx_left is a (nxMAXM) matric with the impulse values for vocalis, left side and x-direction. The n for the rows comes from siggi
       impulse_mx_left(n, s) = impulse_mx(1, s);
       
       impulse_vx_right(n, s) = impulse_vx(2, s);
       impulse_mx_right(n, s) = impulse_mx(2, s);
       
       
       impulse_vz_left(n, s) = impulse_vz(1, s);
       impulse_mz_left(n, s) = impulse_mz(1, s);
       
       impulse_vz_right(n, s) = impulse_vz(2, s);
       impulse_mz_right(n, s) = impulse_mz(2, s);
       
       time(n, s) = n/Fs;
       massaxis(n, s)= s;
    end










