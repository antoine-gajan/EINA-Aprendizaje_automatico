function [error] = error_reproyeccion(matrix_eigenvalues, k)
    % Calculate kind of reproyeccion error in function of k 
    error = sum(diag(matrix_eigenvalues(1:k, 1:k))) / sum(diag(matrix_eigenvalues));
end

