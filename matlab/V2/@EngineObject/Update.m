function Update(self)
pData = self.TRSMatrix * [self.Data; ones(1, size(self.Data, 2))];
            
self.Shape.XData = pData(1,:);
self.Shape.YData = pData(2,:);
end