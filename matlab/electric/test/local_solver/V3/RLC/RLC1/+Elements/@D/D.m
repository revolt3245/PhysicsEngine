classdef D < Elements.Element
    methods(Access = public)
        function self = D(mapping, Param)
            arguments
                mapping (1,4) uint64
                Param.Rd (1,1) double = 1e-12;
                Param.Vd (1,1) double = 0.7;
            end
            self@Elements.Element(mapping);

            self.Rd = Param.Rd;
            self.Vd = Param.Vd;

            self.cond = false;
        end
    end

    methods(Access = public)
        [C, G, H] = getPhi(self, X);
        [Q, dQ] = getDynamics(self, X, dX);
    end

    methods(Access = public)
        self = changeCondition(self, X);
    end

    properties
        Rd
        Vd
        cond
    end
end