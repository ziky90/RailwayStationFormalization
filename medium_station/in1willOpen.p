include('control.p').

fof(willOpenin1, conjecture, (?[X,Y]: (less(X,Y) <=> open(Y,in1)))).