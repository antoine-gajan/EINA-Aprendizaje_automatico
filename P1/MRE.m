function mre = MRE(theta, X, y)
    N = size(X, 1);
    y_pred = pred(X, theta);
    r = y_pred - y;
    mre = 1 / N * sum(abs(r) ./ y);
end