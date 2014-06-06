include('station.p').

% logic that assure us changing of the input points in time

fof(clockOrderin2, axiom, (![X]: ((succ(X) != X) => ((clockOrder(X) = in2) <=> (clockOrder(succ(X)) = in1))))).
fof(clockOrderin1, axiom, (![X]: ((succ(X) != X) => ((clockOrder(X) = in1) <=> (clockOrder(succ(X)) = in2))))).
fof(clockPossibilities, axiom, (![X]: ((clockOrder(X) = in2) | (clockOrder(X) = in1)))).

% formulation of all the possible routes by the switches configuration

fof(switchesConfiguration0, axiom, (![X]: (configuration(X, path0) <=> ((switch(X, s3) = out2) & (switch(X, s1) = s3))))).
fof(switchesConfiguration1, axiom, (![X]: (configuration(X, path1) <=> ((switch(X, s3) = out2) & (switch(X, s2) = s3))))).
fof(switchesConfiguration2, axiom, (![X]: (configuration(X, path2) <=> ((switch(X, s4) = out2) & (switch(X, s1) = s4))))).
fof(switchesConfiguration3, axiom, (![X]: (configuration(X, path3) <=> ((switch(X, s4) = out2) & (switch(X, s2) = s4))))).
fof(switchesConfiguration4, axiom, (![X]: (configuration(X, path4) <=> ((switch(X, s3) = out1) & (switch(X, s1) = s3))))).
fof(switchesConfiguration5, axiom, (![X]: (configuration(X, path5) <=> ((switch(X, s3) = out1) & (switch(X, s2) = s3))))).
fof(switchesConfiguration6, axiom, (![X]: (configuration(X, path6) <=> ((switch(X, s4) = out1) & (switch(X, s1) = s4))))).
fof(switchesConfiguration7, axiom, (![X]: (configuration(X, path7) <=> ((switch(X, s4) = out1) & (switch(X, s2) = s4))))).

% formulation of what it means that the route is free

fof(freeRoute0, axiom, (![X, T]: (free(X, path0) <=> ((~at(X, T, s3)) & (~at(X, T, s1)))))).
fof(freeRoute1, axiom, (![X, T]: (free(X, path1) <=> ((~at(X, T, s3)) & (~at(X, T, s2)))))).
fof(freeRoute2, axiom, (![X, T]: (free(X, path2) <=> ((~at(X, T, s4)) & (~at(X, T, s1)))))).
fof(freeRoute3, axiom, (![X, T]: (free(X, path3) <=> ((~at(X, T, s4)) & (~at(X, T, s2)))))).
fof(freeRoute4, axiom, (![X, T]: (free(X, path4) <=> ((~at(X, T, s3)) & (~at(X, T, s1)))))).
fof(freeRoute5, axiom, (![X, T]: (free(X, path5) <=> ((~at(X, T, s3)) & (~at(X, T, s2)))))).
fof(freeRoute6, axiom, (![X, T]: (free(X, path6) <=> ((~at(X, T, s4)) & (~at(X, T, s1)))))).
fof(freeRoute7, axiom, (![X, T]: (free(X, path7) <=> ((~at(X, T, s4)) & (~at(X, T, s2)))))).

% formulation of which routes are conflicting

fof(nonconflicting0, axiom, (![X]: (nonconflicting(X, path0) <=> ((free(X, path0)) & (free(X, path1)) & (free(X, path2)) & (free(X, path3)) & (free(X, path4)) & (free(X, path5)) & (free(X, path6)))))).
fof(nonconflicting1, axiom, (![X]: (nonconflicting(X, path1) <=> ((free(X, path1)) & (free(X, path0)) & (free(X, path2)) & (free(X, path3)) & (free(X, path4)) & (free(X, path5)) & (free(X, path7)))))).
fof(nonconflicting2, axiom, (![X]: (nonconflicting(X, path2) <=> ((free(X, path2)) & (free(X, path0)) & (free(X, path1)) & (free(X, path3)) & (free(X, path4)) & (free(X, path6)) & (free(X, path7)))))).
fof(nonconflicting3, axiom, (![X]: (nonconflicting(X, path3) <=> ((free(X, path3)) & (free(X, path0)) & (free(X, path1)) & (free(X, path2)) & (free(X, path5)) & (free(X, path6)) & (free(X, path7)))))).
fof(nonconflicting4, axiom, (![X]: (nonconflicting(X, path4) <=> ((free(X, path4)) & (free(X, path0)) & (free(X, path1)) & (free(X, path2)) & (free(X, path5)) & (free(X, path6)) & (free(X, path7)))))).
fof(nonconflicting5, axiom, (![X]: (nonconflicting(X, path5) <=> ((free(X, path5)) & (free(X, path0)) & (free(X, path1)) & (free(X, path3)) & (free(X, path4)) & (free(X, path6)) & (free(X, path7)))))).
fof(nonconflicting6, axiom, (![X]: (nonconflicting(X, path6) <=> ((free(X, path6)) & (free(X, path0)) & (free(X, path2)) & (free(X, path3)) & (free(X, path4)) & (free(X, path5)) & (free(X, path7)))))).
fof(nonconflicting7, axiom, (![X]: (nonconflicting(X, path7) <=> ((free(X, path7)) & (free(X, path1)) & (free(X, path2)) & (free(X, path3)) & (free(X, path4)) & (free(X, path5)) & (free(X, path6)))))).

% axiom that assure us that all the routes are different

fof(routesExclusivity, axiom, ((path0 != path1) & (path0 != path2) & (path0 != path3) & (path0 != path4) & (path0 != path5) & (path0 != path6) & (path0 != path7) & (path1 != path2) & (path1 != path3) & (path1 != path4) & (path1 != path5) & (path1 != path6) & (path1 != path7) & (path2 != path3) & (path2 != path4) & (path2 != path5) & (path2 != path6) & (path2 != path7) & (path3 != path4) & (path3 != path5) & (path3 != path6) & (path3 != path7) & (path4 != path5) & (path4 != path6) & (path4 != path7) & (path5 != path6) & (path5 != path7) & (path6 != path7))).

% axioms that assure us that path is free and set before train can go

fof(availableRoute0, axiom, (![X]: (available(X, path0) <=> (nonconflicting(X, path0) & configuration(X, path0))))).
fof(availableRoute1, axiom, (![X]: (available(X, path1) <=> (nonconflicting(X, path1) & configuration(X, path1))))).
fof(availableRoute2, axiom, (![X]: (available(X, path2) <=> (nonconflicting(X, path2) & configuration(X, path2))))).
fof(availableRoute3, axiom, (![X]: (available(X, path3) <=> (nonconflicting(X, path3) & configuration(X, path3))))).
fof(availableRoute4, axiom, (![X]: (available(X, path4) <=> (nonconflicting(X, path4) & configuration(X, path4))))).
fof(availableRoute5, axiom, (![X]: (available(X, path5) <=> (nonconflicting(X, path5) & configuration(X, path5))))).
fof(availableRoute6, axiom, (![X]: (available(X, path6) <=> (nonconflicting(X, path6) & configuration(X, path6))))).
fof(availableRoute7, axiom, (![X]: (available(X, path7) <=> (nonconflicting(X, path7) & configuration(X, path7))))).

% axioms that determines where the trains would like to go

fof(wantsToGoin2out2, axiom, (![X]: ?[T]: (wantsToGo(X,in2,out2) <=> (at(X,T,in2) & goal(T)=out2)))).
fof(wantsToGoin2out1, axiom, (![X]: ?[T]: (wantsToGo(X,in2,out1) <=> (at(X,T,in2) & goal(T)=out1)))).
fof(wantsToGoin1out2, axiom, (![X]: ?[T]: (wantsToGo(X,in1,out2) <=> (at(X,T,in1) & goal(T)=out2)))).
fof(wantsToGoin1out1, axiom, (![X]: ?[T]: (wantsToGo(X,in1,out1) <=> (at(X,T,in1) & goal(T)=out1)))).

% axioms that determines which path is supposed to be used in which situation

fof(pathToBeUsed0, axiom, (![X]: (toBeUsed(X, path0) <=> (available(X, path0) & clockOrder(X)=in1 & wantsToGo(X,in1,out2))))).
fof(pathToBeUsed1, axiom, (![X]: (toBeUsed(X, path1) <=> (available(X, path1) & clockOrder(X)=in2 & wantsToGo(X,in2,out2))))).
fof(pathToBeUsed2, axiom, (![X]: (toBeUsed(X, path2) <=> (available(X, path2) & clockOrder(X)=in1 & wantsToGo(X,in1,out2))))).
fof(pathToBeUsed3, axiom, (![X]: (toBeUsed(X, path3) <=> (available(X, path3) & clockOrder(X)=in2 & wantsToGo(X,in2,out2))))).
fof(pathToBeUsed4, axiom, (![X]: (toBeUsed(X, path4) <=> (available(X, path4) & clockOrder(X)=in1 & wantsToGo(X,in1,out1))))).
fof(pathToBeUsed5, axiom, (![X]: (toBeUsed(X, path5) <=> (available(X, path5) & clockOrder(X)=in2 & wantsToGo(X,in2,out1))))).
fof(pathToBeUsed6, axiom, (![X]: (toBeUsed(X, path6) <=> (available(X, path6) & clockOrder(X)=in1 & wantsToGo(X,in1,out1))))).
fof(pathToBeUsed7, axiom, (![X]: (toBeUsed(X, path7) <=> (available(X, path7) & clockOrder(X)=in2 & wantsToGo(X,in2,out1))))).

% axiom that set the path in the control system

fof(setPath, axiom, (![X,P]: (configuration(succ(X),P) <=> ((configuration(X,P) & ~free(X,P)) | toBeUsed(X,P))))).

% axiom that describes how the inputs are opened
fof(openGatein2, axiom, (![X]: (open(succ(X),in2) <=> (toBeUsed(X, path1) | toBeUsed(X, path3) | toBeUsed(X, path5) | toBeUsed(X, path7))))).
fof(openGatein1, axiom, (![X]: (open(succ(X),in1) <=> (toBeUsed(X, path0) | toBeUsed(X, path2) | toBeUsed(X, path4) | toBeUsed(X, path6))))).