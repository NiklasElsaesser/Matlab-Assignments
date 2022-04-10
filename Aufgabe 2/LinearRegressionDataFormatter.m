classdef LinearRegressionDataFormatter < matlab.mixin.SetGet
    %DATAPRERPERATOR Class to model the training data for lineare
    %regression model object
   
    properties (Access = public)
        feature
        featureName
        commandVar
        commandVarName
        numOfSamples
    end
    
    properties (Access = private)
        data
    end
    
    methods (Access = public)
        function obj = LinearRegressionDataFormatter(varargin)
            %DATAPRERPERATOR Construct an instance of this class
            
            % ========= YOUR CODE HERE =========
            % perform the varargin
            for i = 1:nargin
                if strcmp(varargin{i},'Data')
                    obj.data = importdata(varargin{i+1});
                elseif strcmp(varargin{i},'Feature')
                    obj.featureName = varargin{i+1};
                elseif strcmp(varargin{i},'CommandVar')
                    obj.commandVarName = varargin{i+1};
                end
            end
%             if ~exist('obj.data','var')
%                 error('Error obj.data');
%             end
%             if ~exist('obj.featureName','var')
%                 error('Error obj.featureName');
%             end
%             if ~exist('obj.commandVarName','var')
%                 error('Error obj.commandVar');
%             end
            obj.mapFeature();
            obj.mapCommandVar();
            obj.mapNumOfSamples();
           
%             if ~exist('obj.feature','var')
%                 error('Error obj.feature');
%             end      
%             if ~exist('obj.commandVar','var')
%                 error('Error obj.commandVarName');
%             end
%             if ~exist('obj.numOfSamples','var')
%                 error('Error obj.numOfSamples');
%             end
        end
    end
    
    methods (Access = private)
        function mapFeature(obj)
            obj.feature = obj.data.(obj.featureName);
        end
        
        function mapCommandVar(obj)
            obj.commandVar = obj.data.(obj.commandVarName);
        end
        
        function mapNumOfSamples(obj)
           obj.numOfSamples = length(obj.feature); 
        end
    end

    
end