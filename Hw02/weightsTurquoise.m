function B = weights(C)
    C = [0.2896, 0.8862, 0.7471]
    R = response();
    B = R^(-1) * C'
end
