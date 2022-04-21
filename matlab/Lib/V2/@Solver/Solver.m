classdef Solver
    %% constructor
    methods
        function self=Solver(paramConstraint, paramSolver)
            arguments
                paramConstraint.a_hat (1,1) double=3.46
                paramConstraint.b_hat (1,1) double=3.78
                
                paramSolver.dt (1,1) double=1/6000
            end
            
            self.paramConstraint = paramConstraint;
            self.paramSolver = paramSolver;
        end
    end
    
    %% getter
    methods
        %% public
        function a_hat = get.a_hat(self)
            a_hat = self.paramConstraint.a_hat;
        end
        
        function b_hat = get.b_hat(self)
            b_hat = self.paramConstraint.b_hat;
        end
        
        function dt = get.dt(self)
            dt = self.paramSolver.dt;
        end
        
        %%private
        function a = get.a(self)
            a = self.a_hat/self.dt;
        end
        
        function b = get.b(self)
            b = self.b_hat/(self.dt^2);
        end
    end
    
    %% setter
    methods
        function self = set.a_hat(self, a_hat)
            self.paramConstraint.a_hat = a_hat;
        end
        
        function self = set.b_hat(self, b_hat)
            self.paramConstraint.b_hat = b_hat;
        end
        
        function self = set.dt(self, dt)
            self.paramSolver.dt = dt;
        end
    end
    
    %% public properties
    properties(Dependent, Access = public)
        a_hat
        b_hat
        
        dt
    end
    
    properties(Dependent, Access = private)
        a
        b
    end
    
    %% private properties
    properties(Access = private)
        paramConstraint
        paramSolver
    end
end