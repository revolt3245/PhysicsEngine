classdef EngineSingleObject
    %% constructor
    methods
        function self = EngineSingleObject(ax, paramData, paramTransform)
            arguments
                ax
                
                paramData.Data (2,:) double=[1 1 -1 -1 1; 1 -1 -1 1 1]
                paramData.Color (1,3) double=[0 0 0];
                
                paramTransform.Translate (1,2) double=[0 0];
                paramTransform.Rotation (1,1) double=0;
                paramTransform.Scale (1,2) double=[1 1];
            end
            self.paramData = paramData;
            
            self.Shape = plot(ax, paramData.Data(1,:), paramData.Data(2,:), 'LineWidth', 2.0, 'Color', paramData.Color);
            
            self.paramTransform = paramTransform;
        end
    end
    
    %% getter
    methods
        function Data = get.Data(self)
            Data = self.paramData.Data;
        end
        
        function Color = get.Color(self)
            Color = self.paramData.Color;
        end
        
        function Translation = get.Translation(self)
            Translation = self.paramTransform.Translation;
        end
        
        function Rotation = get.Rotation(self)
            Rotation = self.paramTransform.Rotation;
        end
        
        function Scale = get.Scale(self)
            Scale = self.paramTransform.Scale;
        end
        
        function TRSMatrix = get.TRSMatrix(self)
            S = diag([self.Scale, 1]);
            R = [cos(self.Rotation) -sin(self.Rotation) 0; sin(self.Rotation) cos(self.Rotation) 0; 0 0 1];
            T = [eye(2) self.Translation'; zeros(1,2) 1];
            
            TRSMatrix = T*R*S;
        end
    end
    
    %% setter
    methods
        function self = set.Data(self, Data)
            arguments
                self
                
                Data (2,:) double
            end
            
            self.paramData.Data = Data;
            
            self.Update;
        end
        
        function self = set.Color(self, Color)
            arguments
                self
                
                Color (1,3) double
            end
            
            self.paramData.Color = Color;
            
            self.Shape.Color = Color;
        end
        
        function self = set.Translation(self, Translation)
            arguments
                self
                
                Translation (1,2) double
            end
            
            self.paramTransform.Translation = Translation;
        end
        
        function self = set.Rotation(self, Rotation)
            arguments
                self
                
                Rotation (1,1) double
            end
            
            self.paramTransform.Rotation = Rotation;
        end
        
        function self = set.Scale(self, Scale)
            arguments
                self
                
                Scale (1,2) double
            end
            
            self.paramTransform.Scale = Scale;
        end
    end
    
    %% public properties
    properties(Dependent, Access = public)
        Data
        Color
        
        Translation
        Rotation
        Scale
    end
    
    properties(Dependent, Access = private)
        TRSMatrix
    end
    
    %% private properties
    properties(Access = private)
        paramData
        Shape
        
        paramTransform
    end
end