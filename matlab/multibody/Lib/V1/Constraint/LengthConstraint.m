classdef LengthConstraint < Constraint
    properties(Access = private)
        x0
        x1
    end
    properties(Dependent, Access = private)
        l
    end
    methods
        function self = LengthConstraint(x0, x1, varargin)
            self@Constraint(varargin{:});
            
            self.x0 = x0;
            self.x1 = x1;
        end
    end
    
    methods
        function l = get.l(self)
            l = norm(self.x1-self.x0);
        end
        
        function self = set.x0(self, x0)
            self.x0 = x0;
        end
        
        function self = set.x1(self, x1)
            self.x1 = x1;
        end
    end
    methods
        function V = ConstraintVector(self, pos)
            V = (pos(1) - pos(4))^2 + (pos(2)-pos(5))^2 - self.l^2;
        end
        
        function J = Jacobian(self, pos)
            J = 2*[pos(1)-pos(4) pos(2)-pos(5) 0 pos(4)-pos(1) pos(5)-pos(2) 0];
        end
        
        function H = Hessian(self, pos)
            H = [2 0 0 -2 0 0; 0 2 0 0 -2 0; 0 0 0 0 0 0; -2 0 0 2 0 0; 0 -2 0 0 2 0; 0 0 0 0 0 0];
            H = reshape(H, 6, 6, 1);
        end
    end
end