function rmse = RMSE(theta, X, y)
    N = size(X, 1);
    y_pred = X * theta;
    r = y_pred - y;
    rmse = sqrt(1 / N * (r') * r);
end