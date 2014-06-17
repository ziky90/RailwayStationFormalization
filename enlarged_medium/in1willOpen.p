include('control.p').

fof(willOpenin1, conjecture, (?[X,Y]: ((at(X,T,in1) & less(X,Y)) => open(Y,in1)))).