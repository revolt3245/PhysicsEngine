classdef PinpointConstraint
    properties
        anchor
        length
    end
    methods
        function self = PinpointConstraint(anchor, length)
            self.anchor = anchor;
            self.length = length;
        end
        
        function c_vec = constraintVector(self, pos)
            c_vec(1) = (pos(1) - self.anchor(1))^2 + (pos(2) - self.anchor(2))^2 - self.length^2;
            c_vec(2) = (pos(1) - self.anchor(1))*sin(pos(3)) - (pos(2) - self.anchor(2))*cos(pos(3));
            
            c_vec = reshape(c_vec, 2,1);
        end
        
        function j = jacobianMatrix(self, pos)
            j(1,1) = 2*pos(1) - 2*self.anchor(1);
            j(1,2) = 2*pos(2) - 2*self.anchor(2);
            j(1,3) = 0;
            j(2,1) = sin(pos(3));
            j(2,2) = -cos(pos(3));
            j(2,3) = (pos(1) - self.anchor(1))*cos(pos(3)) + (pos(2) - self.anchor(2))*sin(pos(3));
        end
        
        function h = hessianTensor(self, pos)
            h(1:3,1:3,1) = 2*eye(3);
            h(3,3,1) = 0;
            h(1:3,1:3,2) = zeros(3,3);
            h(1,3,2) = cos(pos(3));
            h(2,3,2) = sin(pos(3));
            h(3,3,2) = -(pos(1) - self.anchor(1))*sin(pos(3)) + (pos(2) - self.anchor(2)) * cos(pos(3));
            h(3,1,2) = h(1,3,2);
            h(3,2,2) = h(2,3,2);
        end
    end
end