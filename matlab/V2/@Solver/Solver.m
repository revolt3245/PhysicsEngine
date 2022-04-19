classdef Solver
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
    properties(Access = public)
        paramConstraint
        paramSolver
    end
end