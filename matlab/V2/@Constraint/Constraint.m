classdef Constraint
    %% constructor
    methods
        function self = Constraint(paramConstraint)
            arguments
                paramConstraint.dimension uint64=1
                
                paramConstraint.C function_handle{mustBeLengthOfArgumentList}=@(x, dx)1
                paramConstraint.G function_handle{mustBeLengthOfArgumentList}=@(x, dx)0
                paramConstraint.H function_handle{mustBeLengthOfArgumentList}=@(x, dx)0
            end
            
            self.paramConstraint = paramConstraint;
        end
    end
    
    %% getter
    methods
        function dimension = get.dimension(self)
            dimension = self.paramConstraint.dimension;
        end
        
        function C = get.C(self)
            C = self.paramConstraint.C;
        end
        
        function G = get.G(self)
            G = self.paramConstraint.G;
        end
        
        function H = get.H(self)
            H = self.paramConstraint.H;
        end
    end
    
    %% setter
    methods
        function self = set.dimension(self, dimension)
            self.paramConstraint.dimension = dimension;
        end
        
        function self = set.C(self, C)
            mustBeLengthOfArgumentList(C);
            self.paramConstraint.C = C;
        end
        
        function self = set.G(self, G)
            mustBeLengthOfArgumentList(G);
            self.paramConstraint.G = G;
        end
        
        function self = set.H(self, H)
            mustBeLengthOfArgumentList(H);
            self.paramConstraint.H = H;
        end
    end
    %% public properties
    properties(Dependent, Access = public)
        dimension
        
        C
        G
        H
    end
    
    %% private properties
    properties(Access = private)
        paramConstraint
    end
end

function mustBeLengthOfArgumentList(fcn)
if(nargin(fcn) ~= 2)
    eidType = 'mustBeLengthOfArgumentList2:notInputArg2';
    msgType = 'Input of the function handle must be 2.';
    
    throwAsCaller(MException(eidType, msgType));
end

if(nargout(fcn) ~= -1 && nargout(fcn) ~= 1)
    eidType = 'mustBeLengthOfArgumentList2:notOutputArg1';
    msgType = 'Output of the function handle must be 1.';
    
    throwAsCaller(MException(eidType, msgType));
end
end