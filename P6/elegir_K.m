function [k] = elegir_K(matrix_eigenvalues, threshold)
    % Choose appropriate K value to reach a suficient threshold
    if nargin < 2
        % Default threshold if not given
        threshold = 0.99;
    end
    k = 0;
    err_reproyection = 0;
    while err_reproyection <= threshold
        k = k + 1;
        err_reproyection = error_reproyeccion(matrix_eigenvalues, k);
    end
end

