include('control.p').

fof(no2Trains, conjecture, (![T1, T2, X]: ((at(X,T1,s1) & (T1 != T2)) => (~at(X, T2,s1))))).