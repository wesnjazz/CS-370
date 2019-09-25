function B = weights(C)
    C = [0.8567, 0.6874, 0.1408]
    R = response();
    B = R^(-1) * C'
end
