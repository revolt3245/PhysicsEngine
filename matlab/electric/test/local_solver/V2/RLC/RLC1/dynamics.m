function [dX, d2X] = dynamics(circuit, X, dX, Param)
%% parameter
n_iter = Param.n_iter;

size_c = size(circuit,1);

%% initialize
for i=1:size_c
    circuit(i) = circuit(i).initialize(X, dX, Param);
end

%% iteration
Diff = zeros(size(X, 1), 1);

for i=1:n_iter
    for j=1:size_c
        circuit_cur = circuit(j);

        Grad_cur = circuit_cur.Grad;
        d2x_cur = circuit_cur.d2x;

        mapping_cur = circuit_cur.mapping;

        Glambda = Grad_cur' * d2x_cur(end);
        Diff_local = Diff;
        Diff_local(mapping_cur) = Diff_local(mapping_cur) - Glambda;
        circuit(j) = circuit_cur.updateTemp(Diff_local);
    end

    for j=1:size_c
        circuit(j) = circuit(j).updateD2x(Param);
    end

    Diff = zeros(size(X, 1), 1);

    for j=1:size_c
        circuit_cur = circuit(j);

        Grad_cur = circuit_cur.Grad;
        d2x_cur = circuit_cur.d2x;

        mapping_cur = circuit_cur.mapping;

        Diff(mapping_cur) = Diff(mapping_cur) + Grad_cur' * d2x_cur(end);
    end
end
d2X = -Diff;
for i=1:size_c
    circuit_cur = circuit(i);
    
    d2x_cur = circuit_cur.d2x;
    
    mapping_cur = circuit_cur.mapping;

    d2X(mapping_cur) = d2X(mapping_cur) + (d2x_cur(1:end-1) + Diff(mapping_cur))/size_c;
end
end