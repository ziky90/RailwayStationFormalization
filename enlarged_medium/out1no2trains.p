include('control.p').

fof(no2Trains, conjecture, (![T1, T2, X]: ((at(X,T1,out1) & (T1 != T2)) => (~at(X, T2,out1))))).