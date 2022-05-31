classdef (Abstract) Constraint
    properties(Access = private)
        a_hat = 3.46
        b_hat = 3.78
        step = 1/6000
    end
    
    properties(Dependent, Access = private)
        a
        b
    end
    methods
        function obj = Constraint(varargin)
            if nargin == 0
            elseif nargin == 1
                obj.a_hat = varargin{1};
            elseif nargin == 2
                obj.a_hat = varargin{1};
                obj.b_hat = varargin{2};
            else
                obj.a_hat = varargin{1};
                obj.b_hat = varargin{2};
                obj.step = varargin{3};
            end
        end
        
        function gamma = getGamma(obj, pos, dpos)
            C = obj.ConstraintVector(pos);
            J = obj.Jacobian(pos);
            H = obj.Hessian(pos);
            
            d2 = -reshape(pagemtimes(dpos', pagemtimes(H, dpos)), 1,1);
            d1 = J * dpos;
            d0 = C;
            
            gamma = d2-obj.a*d1-obj.b*d0;
        end
        
        function d2pos = Dynamics(self, pos, dpos, M, Q)
            J = self.Jacobian(pos);
            
            Gamma = self.getGamma(pos, dpos);
            F = [Q;Gamma];
            
            cn = size(J, 1);
            S = [M J';J zeros(cn)];
            
            pl = S\F;
            d2pos = pl(1:6);
        end
        
        function a = get.a(obj)
            a = obj.a_hat/obj.step;
        end
        
        function b = get.b(obj)
            b = obj.b_hat/obj.step^2;
        end
        
        function step = get.step(obj)
            step = obj.step;
        end
        
        function obj = set.a(obj, a_hat)
            obj.a_hat = a_hat;
        end
        
        function obj = set.b(obj, b_hat)
            obj.b_hat = b_hat;
        end
        
        function obj = set.step(obj, step)
            obj.step = step;
        end
    end
    
    methods(Abstract)
        C = ConstraintVector(self, pos)
        J = Jacobian(self, pos)
        H = Hessian(self, pos)
    end
end