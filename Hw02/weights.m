function B = weights(C)
    R = response()
    B = R^(-1) * C'
end
