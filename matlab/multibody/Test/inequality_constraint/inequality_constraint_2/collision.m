function [dx_after, cond] = collision(x_before, dx_before, Param)
%% Parameter

e = Param.e_ineq;
mu = Param.mu_ineq;

[C, G, T] = getPhi(x_before, Param);

Cdot = G * dx_before;

cond = C <= 0 && Cdot <= 0;

if cond
    M = eye(2);
    Q = dx_before;

    Qaug = [-e * Cdot 0]';

    Msys = [M G' T'; G 0 0; T 0 0];
    Qsys = [Q; Qaug];

    dx_sys = Msys\Qsys;

    lambda_g = dx_sys(3);
    lambda_t = dx_sys(4);
    
    if abs(lambda_t) > mu * abs(lambda_g)
        Gp = G + sign(lambda_t * lambda_g) * mu * T;
        Msys = [M Gp'; G 0];
        Qsys = Qsys(1:3,:);
        
        dx_sys = Msys\Qsys;
    end

    dx_after = dx_sys(1:2,:);
else
    dx_after = dx_before;
end
end