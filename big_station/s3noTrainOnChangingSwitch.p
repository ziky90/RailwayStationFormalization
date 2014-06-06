include('control.p').

fof(changeOnlyWithoutTrain, conjecture, (![X,T]: ((at(X,T,s3) & at(succ(X),T,s3)) => (switch(X,s3) = switch(succ(X),s3))))).