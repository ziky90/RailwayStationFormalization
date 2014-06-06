include('control.p').

fof(changeOnlyWithoutTrain, conjecture, (![X,T]: ((at(X,T,s4) & at(succ(X),T,s4)) => (switch(X,s4) = switch(succ(X),s4))))).