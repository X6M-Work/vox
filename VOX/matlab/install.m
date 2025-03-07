function install

% this function creats a file named: "voxpath.mat" in the vox-directory
% in this file the location of vox is specified

[fname,voxpath] = uigetfile('vox*.m','Please show me your "vox.m" !');
% edit [fname,voxpath] = uigetfile('vox*.m','Please show me your "vox.m" !');
if voxpath ~= 0
   cd(voxpath);
   if voxpath(end) == '\'
      voxpath = voxpath(1:end-1);
   end
   save('voxpath','voxpath');
   addpath(voxpath);
   answer = questdlg(['the Matlabpath was set to: ',voxpath,'   ...start vox? '],'install note','yes','no ','yes');
   if answer == 'yes'
      vox;
   end
end