classdef GND < Elements.Element
    methods
        function self = GND(mapping)
            arguments
                mapping (1,2) uint64
            end

            self@Elements.Element(mapping);
        end
    end

    methods
        [C, G, H] = getPhi(self, X);
        [Q, dQ] = getDynamics(self, X, dX);
    end
end