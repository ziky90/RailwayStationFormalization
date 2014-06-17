include('control.p').

fof(willOpenin3, conjecture, (?[X,Y]: ((at(X,T,in3) & less(X,Y)) => open(Y,in3)))).