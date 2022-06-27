function A = trigonalMatrix(size)
A = zeros(size);
init = zeros(1, size);
init(1:2) = [2 -1];

for i=1:size
    A(i,:) = init;

    if i == 1
        init = [-1 init(1:end-1)];
    else
        init = [0 init(1:end-1)];
    end
end
end