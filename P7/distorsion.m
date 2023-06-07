function [disto] = distorsion(D, c, mu)
    K = size(mu, 1);
    m = size(D, 1);
    disto = 0;
    for i = 1:m
        mu_i = mu(c(i), :);
        disto = disto + norm(D(i,:) - mu_i)^2;
    end
    disto = 1/m * disto;
end

