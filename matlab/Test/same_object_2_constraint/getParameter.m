function outParam = getParameter(inParam)
arguments
    inParam.m (1,1) double=1
    inParam.l (1,1) double=1
    
    inParam.g (1,1) double=9.8
    inParam.b (1,1) double=1
    
    inParam.r (1,1) double=2
    
    inParam.iter (1,1) uint64=10
    
    inParam.a_hat (1,1) double=3.46
    inParam.b_hat (1,1) double=3.78
    
    inParam.dt (1,1) double=1/6000
end

outParam = inParam;

J = inParam.m*inParam.l^2/6;
outParam.M = diag([inParam.m inParam.m J]);
end