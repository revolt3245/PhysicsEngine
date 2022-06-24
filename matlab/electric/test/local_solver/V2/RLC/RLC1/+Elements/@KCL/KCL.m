classdef KCL < Elements.Element
    methods
        function self = KCL(mapping)
            self@Elements.Element(mapping);
        end
    end

    methods(Access = public)
        [C, G, H] = getPhi(self, X);
        [Q, dQ] = getDynamics(self, X, dX);
    end

    properties
    end
end