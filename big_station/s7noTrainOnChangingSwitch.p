include('control.p').

fof(changeOnlyWithoutTrain, conjecture, (![X,T]: ((at(X,T,s7) & at(succ(X),T,s7)) => (switch(X,s7) = switch(succ(X),s7))))).