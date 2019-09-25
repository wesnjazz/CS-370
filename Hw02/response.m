function R = response()
    F1 = [ 0.00, 0.01, 0.01, 0.02, 0.01, 0.02, 0.07, 0.29, 0.35, 0.12 ];
    F2 = [ 0.00, 0.01, 0.02, 0.11, 0.20, 0.25, 0.21, 0.10, 0.01, 0.00 ];
    F3 = [ 0.03, 0.10, 0.25, 0.27, 0.13, 0.02, 0.01, 0.01, 0.00, 0.00 ];
    Sr = [ 0.16, 0.26, 0.28, 0.15, 0.10, 0.03, 0.02, 0.00, 0.00, 0.00 ];
    Sg = [ 0.00, 0.00, 0.04, 0.23, 0.34, 0.23, 0.15, 0.01, 0.00, 0.00 ];
    Sb = [ 0.00, 0.00, 0.00, 0.00, 0.01, 0.04, 0.08, 0.23, 0.35, 0.29 ];

    St = [Sr; Sg; Sb];
    Ft = [F1; F2; F3];
    R = St * Ft';
end