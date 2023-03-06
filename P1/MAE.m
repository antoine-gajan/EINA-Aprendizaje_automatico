function mae = MAE(theta, X, y)
    N = size(X, 1);
    y_pred = pred(X, theta);
    r = y_pred - y;
    mae = 1 / N * sum(abs(r));
end