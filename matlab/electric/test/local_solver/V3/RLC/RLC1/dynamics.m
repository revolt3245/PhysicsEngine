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
    %% temporal lambda update
    for j=1:size_c
        circuit_cur = circuit(j);

        %Grad_cur = circuit_cur.Grad;
        %lambda_cur = circuit_cur.lambda;

        %mapping_cur = circuit_cur.mapping;

        %{
        Glambda = Grad_cur' * lambda_cur(end);
        Diff_local = Diff;
        Diff_local(mapping_cur) = Diff_local(mapping_cur) - Glambda;
        %}
        circuit(j) = circuit_cur.updateTemp(Diff);
    end

    %% gauss seidel update
    for j=1:size_c
        circuit(j) = circuit(j).updateLambda(Param);
    end

    %% global solution update
    Diff = zeros(size(X, 1), 1);

    for j=1:size_c
        circuit_cur = circuit(j);

        Grad_cur = circuit_cur.Grad;
        lambda_cur = circuit_cur.lambda;

        mapping_cur = circuit_cur.mapping;

        Diff(mapping_cur) = Diff(mapping_cur) + Grad_cur' * lambda_cur;
    end
end
d2X = -Diff;

for i=1:size_c
    circuit_cur = circuit(i);
    mapping_cur = circuit_cur.mapping;

    error_cur = circuit_cur.getError(Diff);
    d2X(mapping_cur) = d2X(mapping_cur) + error_cur/size_c;
end
end