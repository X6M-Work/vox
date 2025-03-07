%writecontforc writes the contact forc of each vocalis folds in seperate matics
%considering vocalis, mucosa, x-direction and z-Direction
%Here are also the matrics time and massaxis computed, which are used for
%displaying 3D grafics in displaycontforc.m


for s = 1:MAXM
       fcxv_left(n, s) = fcxv(1, s); %fcxv_left is a (nxMAXM) matric with the contforc values for vocalis, left side and x-direction. The n for the rows comes from siggi
       fcxm_left(n, s) = fcxm(1, s);
       
       fcxv_right(n, s) = fcxv(2, s);
       fcxm_right(n, s) = fcxm(2, s);
       
       fczv_left(n, s) = fczv(1, s);
       fczm_left(n, s) = fczm(1, s);
       
       fczv_right(n, s) = fczv(2, s);
       fczm_right(n, s) = fczm(2, s);
       
       time(n, s) = n/Fs;
       timeA(n, s) = n/Fs;
       massaxis(n, s)= s;
    end
