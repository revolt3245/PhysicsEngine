classdef (Abstract) Element < matlab.mixin.Heterogeneous
    methods(Access = public)
        function self = Element(mapping)
            self.mapping = mapping;

            self.dx = zeros(size(mapping, 2), 1);
            self.lambda = 0;
            self.lambda_temp = 0;
        end
    end
    
    methods(Access = public)
        Gamma = getGamma(self, C, G, H, dX, Param);

        self = initialize(self, X, dX, Param);
        self = updateTemp(self, Diff);
        self = updateLambda(self, Param);

        d2x = getError(self, Diff);
    end

    methods(Abstract, Access = public)
        [C, G, H] = getPhi(self, X);
        [Q, dQ] = getDynamics(self, X, dX);
    end

    properties(Access = public)
        mapping

        dx
        lambda

        Grad
    end

    properties(Access = protected)
        lambda_temp

        dQ
        Gamma
    end
end