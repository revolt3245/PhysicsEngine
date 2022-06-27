function dx = dynamics(x, Param)
%% parameter
A = Param.A;

A_check = Param.A_check;
A_available = Param.A_available;

size_A = Param.size_A;

alpha_gs = Param.alpha_gs;
n_iter = Param.n_iter;
%% output
dx = zeros(2*size_A, 1);

%% state
x_cur = x(1:size_A,:);
dx_cur = x(size_A+1:size_A*2,:);

%% Gamma
Gamma = getGamma(x_cur, dx_cur, Param);

%% dx
dx(1:size_A,:) = dx_cur(:,:);

%% d2x
d2x_nxt = zeros(size_A+1,size_A);
d2x_temp = zeros(size_A + 1,size_A);
d2x_global = zeros(size_A, 1);
%d2x_global_temp = zeros(size_A, 1);

for i=1:n_iter
    d2x_global_temp = zeros(size_A, 1);
    for j=1:size_A
        check_ind = A_check(j,:);
        av_ind = A_available(j,:);

        lambdas = d2x_nxt(end,check_ind);
        lambdas_n = d2x_nxt(end, ~check_ind);
        diffs = (lambdas * A(check_ind, av_ind))';

        %{
        BAdiff = Gamma(j) + A(j,:)*diffs;

        d2x_temp(1:end-1,j) = pinv(A(j,:))*BAdiff - diffs;
        d2x_temp(end,j) = -(A(j,:)*A(j,:)')\BAdiff;
        %}

        Msys = [eye(size(diffs, 1)) A(j,av_ind)'; A(j,av_ind) 0];
        Qsys = [-diffs; Gamma(j)];

        d2x_temp([av_ind true],j) = Msys\Qsys;

        d2x_global_temp = d2x_global_temp - d2x_temp(end, j) * A(j,:)';

        d2x_temp(~[av_ind true], j) = d2x_global(~av_ind);
    end

    d2x_global = (1-alpha_gs)*d2x_global + alpha_gs*d2x_global_temp;
    d2x_nxt = (1-alpha_gs)*d2x_nxt + alpha_gs*d2x_temp;

    %disp(d2x_nxt)
end

%d2x_nxt = mean(d2x_nxt(1:size_A), 2);
%k = randi(size_A, 1);

%d2x_nxt = Param.A\Gamma;
dx(size_A+1:size_A*2,:) = mean(d2x_nxt(1:size_A, :), 2);
end