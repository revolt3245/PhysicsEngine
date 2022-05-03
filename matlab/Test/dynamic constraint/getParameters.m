function outParam = getParameters(inParam)
arguments
    inParam.l0 (1,1) double=1;
    
    inParam.k (1,1) double=100;
    inParam.b (1,1) double=0.3;
    inParam.m (1,1) double=1;
    inParam.g (1,1) double=9.8;
    
    inParam.iter (1,1) uint64=10;
    
    inParam.dt (1,1) double=1/6000;
    
    inParam.alpha_hat (1,1) double=3.46;
    inParam.beta_hat (1,1) double=3.78;
end
outParam = inParam;

outParam.alpha = inParam.alpha_hat/inParam.dt;
outParam.beta = inParam.beta_hat/(inParam.dt^2);
end