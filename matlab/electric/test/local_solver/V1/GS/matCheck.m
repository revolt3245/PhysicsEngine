function A_check = matCheck(A)
A_available = logical(A);
A_size = size(A, 1);

A_check = zeros(A_size, "logical");

for i=1:A_size
    A_ind = A_available(i,:);
    
    A_cross = A_available(:, A_ind);
    A_cross = any(A_cross, 2);
    A_cross(i) = false;

    A_check(i,:) = A_cross';
end
end