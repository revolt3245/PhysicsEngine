classdef R < Elements.Element
    methods
        function self = R(mapping, Param)
            arguments
                mapping (1,4) uint64
                Param.R0 (1,1) double = 1
            end

            self@Elements.Element(mapping);

            self.R0 = Param.R0;
        end
    end

    methods(Access = public)
        [C, G, H] = getPhi(self, X);
        [Q, dQ] = getDynamics(self, X, dX);
    end

    properties(Access = private)
        R0
    end
end