function medre = MedRE(theta, X, y)
    y_pred = pred(X, theta);
    r = y_pred - y;
    medre = median(abs(r) ./ y);
end