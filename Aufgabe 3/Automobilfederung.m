%function [output1,output2] = function_name(input1,input2,input3)
%FUNCTION_NAME - Calculates Carsuspension with Matrix Mulitplications and
%                 Displays the result
%
% Outputs:
%    tsimout - x-Axis Values
%    ysimout - y-Axis Values
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: runScript.m

% Author:   Jannik Wiessler; Niklas Elsaesser
% email:    jannik.wiessler@daimler.com; inf20184@lehre.dhbw-stuttgart.de
% Website:  https://github.com/NiklasElsaesser/IN_Elsaesser_Niklas_4842156
% May 2022;

%------------- BEGIN CODE --------------
classdef Automobilfederung < handle
    properties
        c1 {mustBeNumeric}
        c2 {mustBeNumeric}
        d2 {mustBeNumeric}
        m1 {mustBeNumeric}
        m2 {mustBeNumeric}
        u
        A {mustBeNumeric}
        B {mustBeNumeric}
        tsimout {mustBeNumeric}
        ysimout {mustBeNumeric}
    end
    methods (Access = public)
        function obj = Automobilfederung(varargin)
            for i = 1:2:nargin
                if strcmp(varargin{i},'c1')
                    obj.c1 = varargin{i+1};
                elseif strcmp(varargin{i},'c2')
                    obj.c2 = varargin{i+1};
                elseif strcmp(varargin{i},'d2')
                    obj.d2 = varargin{i+1};
                elseif strcmp(varargin{i},'m1')
                    obj.m1 = varargin{i+1};
                elseif strcmp(varargin{i},'m2')
                    obj.m2 = varargin{i+1};
                elseif strcmp(varargin{i},'u')
                    if isa(varargin{i+1},'function_handle')
                        obj.u = varargin{i+1};
                    else
                        error("u seems not to be a function handle");
                    end
                else
                    warning("Invalid property: "+varargin{i});
                end
            end
            obj.calcSystemMartixA();
            obj.calcInputMatixB();
        end
        function sim(obj, varargin)
            t = 0;
            tfinal = 10;
            h = 0.01;
            y = [0; 0; 0; 0];
            for i = 1:2:nargin-1
                % ========= YOUR CODE HERE =========
                % perform the varargin: overwrite the defaults
                if strcmp(varargin{i}, 't0')
                    t = varargin{i + 1};
                elseif strcmp(varargin{i}, 'tfinal')
                    tfinal = varargin{i + 1};
                elseif strcmp(varargin{i}, 'stepsize')
                    h = varargin{i + 1};
                elseif strcmp(varargin{i}, 'y0')
                    y = varargin{i + 1};    % no y=y(:) operation, every matrix is transposed
                else
                    warning("Invalid property: "+varargin{i});
                end
            end
            tout = zeros(ceil((tfinal-t)/h)+1,1);
            yout = zeros(ceil((tfinal-t)/h)+1,length(y));
            tout(1) = t;
            yout(1,:) = y';
            step = 1;
            while (t < tfinal)
                step = step + 1;
                if t + h > tfinal
                    h = tfinal - t; % calculating h
                end

                k1 = rhs(obj,t,y);  % calculating the slopes
                k2 = rhs(obj,t + (0.5*h), y+ ((h/2) * k1') );
                k3 = rhs(obj,t + (0.5*h), y+ (0.5*h*k2') );
                k4 = rhs(obj,t + h, y+ (h*k3'));
                
                ynew = y + (((k1'/6) + (k2'/3) + (k3'/3) + (k4'/6)) * h);   % calculate the ynew
                
                t = t + h;
                y = ynew;
                tout(step) = t;
                yout(step,:) = y';
                obj.tsimout = tout;
                obj.ysimout = yout;
            end
        end
        function fig = visualizeResults(obj)
            fig = figure('Name','Ergebnisse der Simulation');
            subplot(2,1,1);
            plot(obj.tsimout,obj.ysimout(:,1),'s-',...
                 obj.tsimout,obj.ysimout(:,3),'x-')
            grid on;
            ylabel('Höhe in m');
            legend('Karosserie','Rad');
            title("Position der Zustände | stepsize = "+num2str(obj.tsimout(2)-obj.tsimout(1)))
            subplot(2,1,2);
            plot(obj.tsimout,obj.ysimout(:,2),'s-',...
                 obj.tsimout,obj.ysimout(:,4),'x-')
            grid on;
            ylabel('Geschwindigkeit in m/s');
            xlabel('Simulationszeit in s');
            legend('Karosserie','Rad');
            title("Geschwindigkeit der Zustände | stepsize = "+num2str(obj.tsimout(2)-obj.tsimout(1)))
        end
    end
    methods (Access = private)
        function calcInputMatixB(obj)
            % ========= YOUR CODE HERE =========
            obj.B = [0; 0; 0; obj.c1/obj.m1];
        end
        function calcSystemMartixA(obj)
            % ========= YOUR CODE HERE =========
            obj.A = [0, 1, 0, 0;...
                    -obj.c2/obj.m2, -obj.d2/obj.m2, obj.c2/obj.m2, obj.d2/obj.m2;...
                    0, 0, 0, 1;...
                    obj.c2/obj.m1, obj.d2/obj.m1,-(obj.c1+obj.c2)/obj.m1, -obj.d2/obj.m1];
        end
        function xdot = rhs(obj, t, x)
            x = x(:);
            xdot = obj.A*x + obj.B*obj.u(t);
        end
    end
end