include('order.p').
%include('consistencyAxioms.p').

% formalism of the go rule

fof(go, axiom, (![X,T]: (train(T) => (?[X2]:(less(X,X2) & go(X2,T)))))).

% formalism for each of the nodes

fof(out2ax1, axiom, (![X,T]: ((train(T) & go(X,T) & ( (switch(X,s3) = out2 & at(X,T,s3)) | (switch(X,s4) = out2 & at(X,T,s4)) )) <=> at(succ(X),T,out2)))).
fof(out1ax1, axiom, (![X,T]: ((train(T) & go(X,T) & ( (switch(X,s3) = out1 & at(X,T,s3)) | (switch(X,s4) = out1 & at(X,T,s4)) )) <=> at(succ(X),T,out1)))).
fof(s3ax1, axiom, (![X,T]: ((train(T) & go(X,T) & ( (switch(X,s1) = s3 & at(X,T,s1)) | (switch(X,s2) = s3 & at(X,T,s2)) )) <=> at(succ(X),T,s3)))).
fof(s4ax1, axiom, (![X,T]: ((train(T) & go(X,T) & ( (switch(X,s1) = s4 & at(X,T,s1)) | (switch(X,s2) = s4 & at(X,T,s2)) )) <=> at(succ(X),T,s4)))).
fof(s2ax1, axiom, (![X,T]: ((train(T) & go(X,T) & ( (open(X,in2) & at(X,T,in2)) )) <=> at(succ(X),T,s2)))).
fof(s1ax1, axiom, (![X,T]: ((train(T) & go(X,T) & ( (open(X,in1) & at(X,T,in1)) )) <=> at(succ(X),T,s1)))).

% all the nodes are different

fof(nodesExclusivity, axiom, ((in2 != in1) & (in2 != s2) & (in2 != s1) & (in2 != out2) & (in2 != out1) & (in2 != s3) & (in2 != s4) & (in1 != s2) & (in1 != s1) & (in1 != out2) & (in1 != out1) & (in1 != s3) & (in1 != s4) & (s2 != s1) & (s2 != out2) & (s2 != out1) & (s2 != s3) & (s2 != s4) & (s1 != out2) & (s1 != out1) & (s1 != s3) & (s1 != s4) & (out2 != out1) & (out2 != s3) & (out2 != s4) & (out1 != s3) & (out1 != s4) & (s3 != s4))).

% trains are disapearing in the outputs

fof(disappearout2, axiom, (![X,T]: (at(X,T,out2) => (~at(succ(X),T,out2))))).
fof(disappearout1, axiom, (![X,T]: (at(X,T,out1) => (~at(succ(X),T,out1))))).

% train can be only at ane node at time

fof(positionInOneNodeAtTime, axiom, (![X,T,N1,N2]: ((at(X,T,N1) & at(X,T,N2)) => (N1=N2)))).

% there can be only one train at the input at time

fof(onlyOneTrainin2, axiom, (![X,T1,T2]: ((at(X,T1,in2) & (T1!=T2)) => (~at(X,T2,in2))))).
fof(onlyOneTrainin1, axiom, (![X,T1,T2]: ((at(X,T1,in1) & (T1!=T2)) => (~at(X,T2,in1))))).

% axioms describing the way how the trains are entering the station

fof(appearin2, axiom, (![X,T]: (at(succ(X),T,in2) <=> (appear(X,T,in2) | (at(X,T,in2) & (~go(X,T) | ~open(X,in2))))))).
fof(appearin1, axiom, (![X,T]: (at(succ(X),T,in1) <=> (appear(X,T,in1) | (at(X,T,in1) & (~go(X,T) | ~open(X,in1))))))).

% axiom that the train has goal in one of outputs

fof(trainGoals, axiom, (![T]: ((goal(T)=out2) | (goal(T)=out1)))).