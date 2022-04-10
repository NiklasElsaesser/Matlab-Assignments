classdef LinearRegressionModel < matlab.mixin.SetGet
    %LINEARREGRESSIONMODEL 
    % Class representing an implementation of linear regression model
    
    properties (Access = public)
        optimizer
        trainingData
        theta
        thetaOptimum
    end
    
    methods (Access = public)
        function obj = LinearRegressionModel(varargin)
             %LINEARREGRESSIONMODEL Construct an instance of this class
            
            % ========= YOUR CODE HERE =========
            % perform the varargin
            for i = 1:nargin
                if strcmp(varargin{i},'Data')
                    obj.trainingData = varargin{i+1};
                elseif strcmp(varargin{i},'Optimizer')
                    obj.optimizer = varargin{i+1};  
                end
            end
            
            obj.initializeTheta();
        end
        
        function J = costFunction(obj)
            m = obj.trainingData.numOfSamples; 
            
            % ========= YOUR CODE HERE =========
            % compute the costs
            % therefore use the hypothesis function as well
            % this calculation can be done by one line of code
            % returns the cost value J
            %J = @(k) (1/(2*m)) + sum((hypothesis(obj.trainingData.feature(k))-obj.trainingData.commandVar(k))^2);
            %J = (1/(2*m))*symsum(hypothesis(obj.trainingData.feature(k)-obj.trainingData.commandVar(k))^2,k,1,m);
            J = 1/(2*m)*sum((obj.hypothesis()-[ones(obj.trainingData.numOfSamples,0) obj.trainingData.commandVar]).^2);
        end
        
        function hValue = hypothesis(obj)
            X = [ones(obj.trainingData.numOfSamples,0) obj.trainingData.feature];
            
            % ========= YOUR CODE HERE =========
            % compute the hypothesis values for each sample
            % therefore compute the matrix multiplication with X
            % this calculation can be done by one line of code
            hValue = obj.theta(1) + obj.theta(2) * X;
            
        end
        
        function h = showOptimumInContour(obj)              
            h = figure('Name','Optimum');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);
            
            % ========= YOUR CODE HERE =========
            % compute the costs for each theta_vals tuple
            % plot the costs with the contour command
            % add x and y label
            % add the optimum theta value to the plot (red X, MarkerSize:
            % 10, LineWidth: 2)
            [X,Y]=meshgrid(theta0_vals,theta1_vals);
            Z = zeros(height(theta1_vals),length(theta0_vals));
            for x = 1:length(X)
                for y = 1:height(Y)
                    obj.setTheta(X(1,x), Y(y,1));
                    Z(y,x) = obj.costFunction();
                end
            end

            hold on
            contour(X,Y,Z)
            xlabel('theta_0');
            ylabel('theta_1');
            plot(obj.thetaOptimum(1), obj.thetaOptimum(2), 'rx', 'MarkerSize', 10, 'LineWidth', 2)
            
        end
        
        function h = showCostFunctionArea(obj)
            h = figure('Name','Cost Function Area');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);
            
            % ========= YOUR CODE HERE =========
            % compute the costs for each theta_vals tuple
            % plot the costs with the surf command
            % add x and y label
            [X,Y]=meshgrid(theta0_vals,theta1_vals);
            Z = zeros(height(theta1_vals),length(theta0_vals));
            for x = 1:length(X)
                for y = 1:height(Y)
                    obj.setTheta(X(1,x), Y(y,1));
                    Z(y,x) = obj.costFunction();
                end
            end
            surf(X,Y,Z); 

        end
        
        function h = showTrainingData(obj)
           h = figure('Name','Linear Regression Model');
           plot(obj.trainingData.feature,obj.trainingData.commandVar,'rx')
           grid on;
           xlabel(obj.trainingData.featureName + " in Kelvin");
           ylabel(obj.trainingData.commandVarName + " in Kelvin");
           legend('Training Data')
        end
        
        function h = showModel(obj)
           h = obj.showTrainingData();
           
          hold on
          plot(obj.trainingData.feature, obj.thetaOptimum(1) + obj.thetaOptimum(2) * obj.trainingData.feature, 'b-', 'DisplayName','Linear Regression Model')
           
        end
        
        function setTheta(obj,theta0,theta1)
            obj.theta = [theta0;theta1];
        end
        
        function setThetaOptimum(obj,theta0,theta1)
            obj.thetaOptimum = [theta0;theta1];
        end
    end
    
    methods (Access = private)
        
        function initializeTheta(obj)
            obj.setTheta(0,0);
        end
   
    end
end

