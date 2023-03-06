function medae = MedAE(theta, X, y)
    y_pred = pred(X, theta);
    r = y_pred - y;
    medae = median(abs(r));
end