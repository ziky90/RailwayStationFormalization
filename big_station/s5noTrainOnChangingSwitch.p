include('control.p').

fof(changeOnlyWithoutTrain, conjecture, (![X,T]: ((at(X,T,s5) & at(succ(X),T,s5)) => (switch(X,s5) = switch(succ(X),s5))))).