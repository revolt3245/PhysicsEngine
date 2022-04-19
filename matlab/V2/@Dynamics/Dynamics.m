classdef Dynamics
    %% constructor
    methods
        function self=Dynamics(paramStates)
            arguments
                paramStates.dimension uint64=1
                
                paramStates.M function_handle{mustBeLengthOfArgumentList}=@(x,dx)1
                paramStates.Q function_handle{mustBeLengthOfArgumentList}=@(x,dx)0
            end
            self.paramStates = paramStates;
        end
    end
    
    %% getter methods
    methods
        function dimension = get.dimension(self)
            dimension = self.paramStates.dimension;
        end
        
        function M = get.M(self)
            M = self.paramStates.M;
        end
        
        function Q = get.Q(self)
            Q = self.paramStates.Q;
        end
    end
    
    %% setter methods
    methods
        function self = set.dimension(self, dimension)
            self.paramStates.dimension = dimension;
        end
        
        function self = set.M(self, M)
            mustBeLengthOfArgumentList(M);
            
            self.paramStates.M = M;
        end
        
        function self = set.Q(self, Q)
            mustBeLengthOfArgumentList(Q);
            
            self.paramStates.Q = Q;
        end
    end
    
    %% public properties
    properties(Dependent, Access = public)
        dimension
        
        M
        Q
    end
    
    %% private properties
    properties(Access = private)
        paramStates
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