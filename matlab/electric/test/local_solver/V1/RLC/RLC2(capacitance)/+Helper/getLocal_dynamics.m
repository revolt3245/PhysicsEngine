function LD = getLocal_dynamics(M, Q, mapping, G, Gamma)
Mlocal = M(mapping, mapping);
Qlocal = Q(mapping);

LD.Msys = [Mlocal G'; G 0];
LD.Qsys = [Qlocal; Gamma];
end