classdef PostureConstraint < Constraint
    properties(Access = private)
        phi0
        phi1
    end
    properties(Dependent, Access = private)
        dphi
    end
    methods
        function self = PostureConstraint(phi0, phi1, varargin)
            self@Constraint(varargin{:});
            self.phi0 = phi0;
            self.phi1 = phi1;
        end
    end
    
    methods
        function dphi = get.dphi(self)
            dphi = self.phi0 - self.phi1;
        end
        
        function self = set.phi0(self, phi0)
            self.phi0 = phi0;
        end
        
        function self = set.phi1(self, phi1)
            self.phi1 = phi1;
        end
    end
    
    methods
        function V = ConstraintVector(self, pos)
            V = (pos(1) - pos(4)) * sin(pos(3) - pos(6) - self.dphi) - (pos(2) - pos(5)) * cos(pos(3) - pos(6) - self.dphi);
        end
        
        function J = Jacobian(self, pos)
            J = zeros(1,6);
            J(1) = sin(pos(3) - pos(6) - self.dphi);
            J(2) = -cos(pos(3) - pos(6) - self.dphi);
            J(3) = (pos(1) - pos(4)) * cos(pos(3) - pos(6) - self.dphi) + (pos(2) - pos(5)) * sin(pos(3) - pos(6) - self.dphi);
            J(4) = -sin(pos(3) - pos(6) - self.dphi);
            J(5) = cos(pos(3) - pos(6) - self.dphi);
            J(6) = (pos(4) - pos(1)) * cos(pos(3) - pos(6) - self.dphi) + (pos(5) - pos(2)) * sin(pos(3) - pos(6) - self.dphi);
        end
        
        function H = Hessian(self, pos)
            H = zeros(6,6,1);
            H(1,3,1) = cos(pos(3) - pos(6) - self.dphi);
            H(1,6,1) = -H(1,3,1);
            H(2,3,1) = sin(pos(3) - pos(6) - self.dphi);
            H(2,6,1) = -H(2,3,1);
            
            H(4,3,1) = -H(1,3,1);
            H(4,6,1) = H(1,3,1);
            H(5,3,1) = -H(2,3,1);
            H(5,6,1) = H(2,3,1);
            
            H(3,1,1) = H(1,3,1);
            H(3,2,1) = H(2,3,1);
            H(3,4,1) = H(4,3,1);
            H(3,5,1) = H(5,3,1);
            H(3,3,1) = -(pos(1) - pos(4)) * sin(pos(3) - pos(6) - self.dphi) + (pos(2) - pos(5)) * cos(pos(3) - pos(6) - self.dphi);
            H(3,6,1) = -H(3,3,1);
            
            H(6,1,1) = H(1,6,1);
            H(6,2,1) = H(2,6,1);
            H(6,4,1) = H(4,6,1);
            H(6,5,1) = H(5,6,1);
            H(6,3,1) = H(3,6,1);
            H(6,6,1) = -H(6,3,1);
        end
    end
end