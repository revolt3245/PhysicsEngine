function [C, G, H] = getPhi(~, X)
X(1) = 0;

C = sum(X);
G = ones(1, size(X, 1));
G(1) = 0;
H = zeros(size(X, 1));
end