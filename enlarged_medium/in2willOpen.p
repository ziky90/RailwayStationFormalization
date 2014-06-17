include('control.p').

fof(willOpenin2, conjecture, (?[X,Y]: ((at(X,T,in2) & less(X,Y)) => open(Y,in2)))).