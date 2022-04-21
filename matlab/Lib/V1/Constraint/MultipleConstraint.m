classdef MultipleConstraint < Constraint
    properties(Access = private)
        Constraints
    end
    methods
        function self = MultipleConstraint(Constraints, varargin)
            self@Constraint(varargin{:});
            
            self.Constraints = Constraints;
        end
    end
    
    methods
        function V = ConstraintVector(self, pos)
            V = [];
            for c=self.Constraints
                V = cat(1, V, c.ConstraintVector(pos));
            end
        end
        
        function J = Jacobian(self, pos)
            J = [];
            for c=self.Constraints
                J = cat(1, J, c.Jacobian(pos));
            end
        end
        
        function H = Hessian(self, pos)
            H = zeros(6,6,0);
            for c = self.Constraints
                H = cat(3, H, c.Hessian(pos));
            end
        end
    end
end