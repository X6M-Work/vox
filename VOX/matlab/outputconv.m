function [input_plus, y_minus_aux] ...
   = outputconv(ldis, A, B, y_minus_aux, output_minus, C_minus, input_plus);
% application of matrices at the discontinuity of the exit
% convoluciosortida := Block[{i=Length[Discontinuitats]}
maxdim = size(B(ldis).value,1);
y_minus_aux(ldis,1:maxdim) = (A(ldis).value * y_minus_aux(ldis,1:maxdim)')' ...
   + (B(ldis).value *     output_minus(ldis-1,:)')';
input_plus(ldis-1) =   (C_minus(ldis).value * y_minus_aux(ldis,1:maxdim)')';
% corrected