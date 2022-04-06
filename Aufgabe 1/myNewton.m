function [xZero, abortFlag, iters] = myNewton(varargin)
%myNewton - applies the Newton-Raphson-Method on a function
%
% Syntax:  [xZero, abortFlag, iters] = myNewton(varargin)f
%
% Inputs:
%    function   - the Polynomial function to be calculated
%    derivative - the derivation of the previous function 
%    startValue - the start Value by default = 0
%    maxIter    - the maximal amount of iterations, by default = 50
%    feps       - the condition to terminate, when function closer to zero than feps, by default 1^-6
%    xeps       - the condition to terminate, when old and new x value
%                  closer to each other than xeps, by default 1^-6
%    livePlot   - plots live during calculation, by default = off
%
% Outputs:
%    xZero      - result Value of the Zero-Point calculation
%    abortFlag  - terminates the Programm
%    iters      - number of the steps to iterate
%
% Example: 
%    myNewton('function', @myPoly, 'livePlot', 'on')
%
% Other m-files required: dmyPoly, myPoly, numDiff
% Subfunctions: numDiff
% MAT-files required: none
%
% See also: runMyNewton

% Author: Niklas Elsaesser
% email: inf20184@lehre.dhbw-stuttgart.de
% Website: https://github.com/NiklasElsaesser
% May 2022; Last revision: 30.03.2022

%% do the varargin
for i = 1:nargin
    if strcmp(varargin{i},'function')
        func = varargin{i+1};
    elseif strcmp(varargin{i},'derivative')
        dfunc = varargin{i+1};
    elseif strcmp(varargin{i},'startValue')
        x0 = varargin{i+1};
    elseif strcmp(varargin{i},'maxIter')
        maxIter = varargin{i+1};
    elseif strcmp(varargin{i},'feps')
        feps = varargin{i+1};
    elseif strcmp(varargin{i},'xeps')
        xeps = varargin{i+1};
    elseif strcmp(varargin{i},'livePlot')
        livePlot = varargin{i+1};   
    end
end

%% check for necessary parameters
if ~exist('func','var')
    error('No valid function');
end
    
if ~exist('x0','var')
    x0 = 0;
    disp(['Using default startvalue: x0 = ', num2str(x0)]);
end

if ~exist('dfunc','var')
    Method = questdlg('Which differentation u want to do?', ...
        'forward difference', ...
        'forward difference','backwards difference','central difference','central difference');
    dfunc = @(x) numDiff(func, x, Method);
    disp(['using numerical derivation: x0 = ', num2str(x0)]);
end

if ~exist('maxIter','var')
    maxIter = 50;
    disp(['Using default maximum iterations: maxIter = ',num2str(maxIter)]);
end

if ~exist('feps','var')
    feps = 1e-6;
    disp(['Using default Feps: feps = ',num2str(feps)]);
end

if ~exist('xeps','var')
    xeps = 1e-6;
    disp(['Using default Xeps: xeps = ',num2str(xeps)]);
end

if ~exist('livePlot','var')
    livePlot = 'off';
    disp(['Using default live Plot: livePlot = ','off']);
end

%% start of algorithm
if strcmp(livePlot,'on')
    %h= figure('Name','Newton visualization using: ')
   h = figure('Name',['Newton visualization using: ',Method]);
   ax1 = subplot(2,1,1);
   plot(ax1,0,x0,'bo');
   ylabel('xValue');
   hold on;
   grid on;
   xlim('auto')
   ylim('auto')
   ax2 = subplot(2,1,2);
   semilogy(ax2,0,func(x0),'rx');
   xlabel('Number of iterations')
   ylabel('Function value');
   hold on;
   grid on;
   xlim('auto')
   ylim('auto')

end
xOld = x0;
abortFlag = 'maxIter';
for i = 1:maxIter
    f = func(xOld);
    if f < feps
        abortFlag = 'feps';
        break;
    end
    df = dfunc(xOld);
    if df == 0
        abortFlag = 'df = 0';
        break;
    end
    xNew = xOld - f/df; 
    if abs(xNew-xOld) < xeps
        abortFlag = 'xeps';
        break;
    end
    xOld = xNew;
    if strcmp(livePlot,'on')
       plot(ax1,i,xNew,'bo');
       semilogy(ax2,i,func(xNew),'rx');
       pause(0.05);
    end
end
iters = i;
xZero = xNew;
title(ax1,['y-intercept: ',num2str(xZero)]);
end