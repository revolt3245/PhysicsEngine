classdef (Abstract) Element < matlab.mixin.Heterogeneous
    methods(Access = public)
        function self = Element(mapping)
            self.mapping = mapping;

            self.dx = zeros(size(mapping, 2), 1);
            self.d2x = zeros(size(mapping, 2), 1);
            self.d2x_temp = zeros(size(mapping, 2), 1);
        end
    end
    
    methods(Access = public)
        Gamma = getGamma(self, C, G, H, dX, Param);

        self = initialize(self, X, dX, Param);
        self = updateTemp(self, Diff);
        self = updateD2x(self, Param);
    end

    methods(Abstract, Access = public)
        [C, G, H] = getPhi(self, X);
        [Q, dQ] = getDynamics(self, X, dX);
    end

    properties(Access = public)
        mapping

        dx
        d2x

        Grad
    end

    properties(Access = protected)
        d2x_temp

        dQ
        Gamma
    end
end