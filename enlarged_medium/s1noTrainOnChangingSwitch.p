include('control.p').

fof(changeOnlyWithoutTrain, conjecture, (![X,T]: ((at(X,T,s1) & at(succ(X),T,s1)) => (switch(X,s1) = switch(succ(X),s1))))).