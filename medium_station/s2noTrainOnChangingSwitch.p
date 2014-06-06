include('control.p').

fof(changeOnlyWithoutTrain, conjecture, (![X,T]: ((at(X,T,s2) & at(succ(X),T,s2)) => (switch(X,s2) = switch(succ(X),s2))))).