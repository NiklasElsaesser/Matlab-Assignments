function y = numDiff(func, x, Method)
%numDiff - asking the user which differentation to peform, executing the according function 
%
% Syntax:  [y] = numDiff(func, x, Method)
%
% Inputs:
%    func   - Variable for f in the Functions
%    x      - Variable for x in the Functions
%    Method - switch Case, to determine which differentation is executed.
%
% Outputs:
%    y - forwarding the chosen function to myNewton
%
% Example: 
%    numDiff(@myPoly, 0, "forward difference")
%
% Other m-files required: myNewton
% Subfunctions: none
% MAT-files required: none
%
% See also: myNewton

% Author: Niklas Elsaesser
% email: inf20184@lehre.dhbw-stuttgart.de
% Website: https://github.com/NiklasElsaesser
% May 2022; Last revision: 30.03.2022

% Handle response
    switch Method
        case 'forward difference'
            h = 10^-8;
            y = (func(x+h)-func(x))/h;
        case 'backwards difference'
            h = 10^-8;
            y = (func(x)-func(x-h))/h;
        case 'central difference'
            h = 10^-6;
            y = (func(x+h)-func(x-h))/(2*h);
    end

end