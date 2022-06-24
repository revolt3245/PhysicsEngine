classdef V < Elements.Element
    methods
        function self = V(mapping, Param)
            arguments
                mapping (1,3) uint64
                Param.Vt
            end
            self@Elements.Element(mapping);

            self.Vt = Param.Vt;
        end
    end

    methods(Access = public)
        [C, G, H] = getPhi(self, X);
        [Q, dQ] = getDynamics(self, X, dX);
    end

    properties(Access = private)
        Vt
    end
end