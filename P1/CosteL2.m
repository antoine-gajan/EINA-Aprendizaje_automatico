function [J, grad, Hess] = CosteL2(theta, X, y)
    N = size(X, 1);
    ypred = X * theta;
    r = ypred - y;
    J = 1/(2*N) .* ((r') * r);
    if nargout > 1
        grad = (1/N) .* ((X') * r);
    end
    if nargout > 2
        Hess = (1/N) .* ((X') * X);
    end
end
