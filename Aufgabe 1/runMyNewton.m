function runMyNewton
%runMyNewton - runs the myNewton.m file with default Values
%
% Syntax:  runMyNewton
%
% Outputs:
%    output is the myNewton function with given parameters
%
% Example: 
%    myNewton('function', @myPoly, 'livePlot', 'on');
% 
% Other m-files required: myNewton, myPoly
% Subfunctions: myNewton
% MAT-files required: none
%
% See also: myNewton, myPoly

% Author: Niklas Elsaesser
% email: inf20184@lehre.dhbw-stuttgart.de
% Website: https://github.com/NiklasElsaesser
% May 2022; Last revision: 30.03.2022
 myNewton('function', @myPoly, 'livePlot', 'on');
end