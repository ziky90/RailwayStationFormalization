include('station.p').

% logic that assure us changing of the input points in time

fof(clockOrderin2, axiom, (![X]: ((succ(X) != X) => ((clockOrder(X) = in2) <=> (clockOrder(succ(X)) = in3))))).
fof(clockOrderin1, axiom, (![X]: ((succ(X) != X) => ((clockOrder(X) = in1) <=> (clockOrder(succ(X)) = in2))))).
fof(clockOrderin3, axiom, (![X]: ((succ(X) != X) => ((clockOrder(X) = in3) <=> (clockOrder(succ(X)) = in1))))).
fof(clockPossibilities, axiom, (![X]: ((clockOrder(X) = in2) | (clockOrder(X) = in1) | (clockOrder(X) = in3)))).

% formulation of all the possible routes by the switches configuration

fof(switchesConfiguration0, axiom, (![X]: (configuration(X, path0) <=> ((switch(X, s3) = out3) & (switch(X, s7) = s3))))).
fof(switchesConfiguration1, axiom, (![X]: (configuration(X, path1) <=> ((switch(X, s3) = out3) & (switch(X, s4) = s3))))).
fof(switchesConfiguration2, axiom, (![X]: (configuration(X, path2) <=> ((switch(X, s3) = out3) & (switch(X, s5) = s3))))).
fof(switchesConfiguration3, axiom, (![X]: (configuration(X, path3) <=> ((switch(X, s4) = out2))))).
fof(switchesConfiguration4, axiom, (![X]: (configuration(X, path4) <=> ((switch(X, s5) = out2))))).
fof(switchesConfiguration5, axiom, (![X]: (configuration(X, path5) <=> ((switch(X, s3) = out2) & (switch(X, s7) = s3))))).
fof(switchesConfiguration6, axiom, (![X]: (configuration(X, path6) <=> ((switch(X, s3) = out2) & (switch(X, s4) = s3))))).
fof(switchesConfiguration7, axiom, (![X]: (configuration(X, path7) <=> ((switch(X, s3) = out2) & (switch(X, s5) = s3))))).
fof(switchesConfiguration8, axiom, (![X]: (configuration(X, path8) <=> ((switch(X, s2) = out1) & (switch(X, s7) = s2))))).
fof(switchesConfiguration9, axiom, (![X]: (configuration(X, path9) <=> ((switch(X, s2) = out1) & (switch(X, s4) = s2))))).
fof(switchesConfiguration10, axiom, (![X]: (configuration(X, path10) <=> ((switch(X, s2) = out1) & (switch(X, s5) = s2))))).
fof(switchesConfiguration11, axiom, (![X]: (configuration(X, path11) <=> ((switch(X, s3) = out1) & (switch(X, s7) = s3))))).
fof(switchesConfiguration12, axiom, (![X]: (configuration(X, path12) <=> ((switch(X, s3) = out1) & (switch(X, s4) = s3))))).
fof(switchesConfiguration13, axiom, (![X]: (configuration(X, path13) <=> ((switch(X, s3) = out1) & (switch(X, s5) = s3))))).

% formulation of what it means that the route is free

fof(freeRoute0, axiom, (![X, T]: (free(X, path0) <=> ((~at(X, T, s3)) & (~at(X, T, s7)))))).
fof(freeRoute1, axiom, (![X, T]: (free(X, path1) <=> ((~at(X, T, s3)) & (~at(X, T, s4)))))).
fof(freeRoute2, axiom, (![X, T]: (free(X, path2) <=> ((~at(X, T, s3)) & (~at(X, T, s5)))))).
fof(freeRoute3, axiom, (![X, T]: (free(X, path3) <=> ((~at(X, T, s4)))))).
fof(freeRoute4, axiom, (![X, T]: (free(X, path4) <=> ((~at(X, T, s5)))))).
fof(freeRoute5, axiom, (![X, T]: (free(X, path5) <=> ((~at(X, T, s3)) & (~at(X, T, s7)))))).
fof(freeRoute6, axiom, (![X, T]: (free(X, path6) <=> ((~at(X, T, s3)) & (~at(X, T, s4)))))).
fof(freeRoute7, axiom, (![X, T]: (free(X, path7) <=> ((~at(X, T, s3)) & (~at(X, T, s5)))))).
fof(freeRoute8, axiom, (![X, T]: (free(X, path8) <=> ((~at(X, T, s2)) & (~at(X, T, s7)))))).
fof(freeRoute9, axiom, (![X, T]: (free(X, path9) <=> ((~at(X, T, s2)) & (~at(X, T, s4)))))).
fof(freeRoute10, axiom, (![X, T]: (free(X, path10) <=> ((~at(X, T, s2)) & (~at(X, T, s5)))))).
fof(freeRoute11, axiom, (![X, T]: (free(X, path11) <=> ((~at(X, T, s3)) & (~at(X, T, s7)))))).
fof(freeRoute12, axiom, (![X, T]: (free(X, path12) <=> ((~at(X, T, s3)) & (~at(X, T, s4)))))).
fof(freeRoute13, axiom, (![X, T]: (free(X, path13) <=> ((~at(X, T, s3)) & (~at(X, T, s5)))))).

% formulation of which routes are conflicting

fof(nonconflicting0, axiom, (![X]: (nonconflicting(X, path0) <=> ((free(X, path0)) & (free(X, path1)) & (free(X, path2)) & (free(X, path5)) & (free(X, path6)) & (free(X, path7)) & (free(X, path8)) & (free(X, path11)) & (free(X, path12)) & (free(X, path13)))))).
fof(nonconflicting1, axiom, (![X]: (nonconflicting(X, path1) <=> ((free(X, path1)) & (free(X, path0)) & (free(X, path2)) & (free(X, path3)) & (free(X, path5)) & (free(X, path6)) & (free(X, path7)) & (free(X, path9)) & (free(X, path11)) & (free(X, path12)) & (free(X, path13)))))).
fof(nonconflicting2, axiom, (![X]: (nonconflicting(X, path2) <=> ((free(X, path2)) & (free(X, path0)) & (free(X, path1)) & (free(X, path4)) & (free(X, path5)) & (free(X, path6)) & (free(X, path7)) & (free(X, path10)) & (free(X, path11)) & (free(X, path12)) & (free(X, path13)))))).
fof(nonconflicting3, axiom, (![X]: (nonconflicting(X, path3) <=> ((free(X, path3)) & (free(X, path1)) & (free(X, path4)) & (free(X, path5)) & (free(X, path6)) & (free(X, path7)) & (free(X, path9)) & (free(X, path12)))))).
fof(nonconflicting4, axiom, (![X]: (nonconflicting(X, path4) <=> ((free(X, path4)) & (free(X, path2)) & (free(X, path3)) & (free(X, path5)) & (free(X, path6)) & (free(X, path7)) & (free(X, path10)) & (free(X, path13)))))).
fof(nonconflicting5, axiom, (![X]: (nonconflicting(X, path5) <=> ((free(X, path5)) & (free(X, path0)) & (free(X, path1)) & (free(X, path2)) & (free(X, path3)) & (free(X, path4)) & (free(X, path6)) & (free(X, path7)) & (free(X, path8)) & (free(X, path11)) & (free(X, path12)) & (free(X, path13)))))).
fof(nonconflicting6, axiom, (![X]: (nonconflicting(X, path6) <=> ((free(X, path6)) & (free(X, path0)) & (free(X, path1)) & (free(X, path2)) & (free(X, path3)) & (free(X, path4)) & (free(X, path5)) & (free(X, path7)) & (free(X, path9)) & (free(X, path11)) & (free(X, path12)) & (free(X, path13)))))).
fof(nonconflicting7, axiom, (![X]: (nonconflicting(X, path7) <=> ((free(X, path7)) & (free(X, path0)) & (free(X, path1)) & (free(X, path2)) & (free(X, path3)) & (free(X, path4)) & (free(X, path5)) & (free(X, path6)) & (free(X, path10)) & (free(X, path11)) & (free(X, path12)) & (free(X, path13)))))).
fof(nonconflicting8, axiom, (![X]: (nonconflicting(X, path8) <=> ((free(X, path8)) & (free(X, path0)) & (free(X, path5)) & (free(X, path9)) & (free(X, path10)) & (free(X, path11)) & (free(X, path12)) & (free(X, path13)))))).
fof(nonconflicting9, axiom, (![X]: (nonconflicting(X, path9) <=> ((free(X, path9)) & (free(X, path1)) & (free(X, path3)) & (free(X, path6)) & (free(X, path8)) & (free(X, path10)) & (free(X, path11)) & (free(X, path12)) & (free(X, path13)))))).
fof(nonconflicting10, axiom, (![X]: (nonconflicting(X, path10) <=> ((free(X, path10)) & (free(X, path2)) & (free(X, path4)) & (free(X, path7)) & (free(X, path8)) & (free(X, path9)) & (free(X, path11)) & (free(X, path12)) & (free(X, path13)))))).
fof(nonconflicting11, axiom, (![X]: (nonconflicting(X, path11) <=> ((free(X, path11)) & (free(X, path0)) & (free(X, path1)) & (free(X, path2)) & (free(X, path5)) & (free(X, path6)) & (free(X, path7)) & (free(X, path8)) & (free(X, path9)) & (free(X, path10)) & (free(X, path12)) & (free(X, path13)))))).
fof(nonconflicting12, axiom, (![X]: (nonconflicting(X, path12) <=> ((free(X, path12)) & (free(X, path0)) & (free(X, path1)) & (free(X, path2)) & (free(X, path3)) & (free(X, path5)) & (free(X, path6)) & (free(X, path7)) & (free(X, path8)) & (free(X, path9)) & (free(X, path10)) & (free(X, path11)) & (free(X, path13)))))).
fof(nonconflicting13, axiom, (![X]: (nonconflicting(X, path13) <=> ((free(X, path13)) & (free(X, path0)) & (free(X, path1)) & (free(X, path2)) & (free(X, path4)) & (free(X, path5)) & (free(X, path6)) & (free(X, path7)) & (free(X, path8)) & (free(X, path9)) & (free(X, path10)) & (free(X, path11)) & (free(X, path12)))))).

% axiom that assure us that all the routes are different

fof(routesExclusivity, axiom, ((path0 != path1) & (path0 != path2) & (path0 != path3) & (path0 != path4) & (path0 != path5) & (path0 != path6) & (path0 != path7) & (path0 != path8) & (path0 != path9) & (path0 != path10) & (path0 != path11) & (path0 != path12) & (path0 != path13) & (path1 != path2) & (path1 != path3) & (path1 != path4) & (path1 != path5) & (path1 != path6) & (path1 != path7) & (path1 != path8) & (path1 != path9) & (path1 != path10) & (path1 != path11) & (path1 != path12) & (path1 != path13) & (path2 != path3) & (path2 != path4) & (path2 != path5) & (path2 != path6) & (path2 != path7) & (path2 != path8) & (path2 != path9) & (path2 != path10) & (path2 != path11) & (path2 != path12) & (path2 != path13) & (path3 != path4) & (path3 != path5) & (path3 != path6) & (path3 != path7) & (path3 != path8) & (path3 != path9) & (path3 != path10) & (path3 != path11) & (path3 != path12) & (path3 != path13) & (path4 != path5) & (path4 != path6) & (path4 != path7) & (path4 != path8) & (path4 != path9) & (path4 != path10) & (path4 != path11) & (path4 != path12) & (path4 != path13) & (path5 != path6) & (path5 != path7) & (path5 != path8) & (path5 != path9) & (path5 != path10) & (path5 != path11) & (path5 != path12) & (path5 != path13) & (path6 != path7) & (path6 != path8) & (path6 != path9) & (path6 != path10) & (path6 != path11) & (path6 != path12) & (path6 != path13) & (path7 != path8) & (path7 != path9) & (path7 != path10) & (path7 != path11) & (path7 != path12) & (path7 != path13) & (path8 != path9) & (path8 != path10) & (path8 != path11) & (path8 != path12) & (path8 != path13) & (path9 != path10) & (path9 != path11) & (path9 != path12) & (path9 != path13) & (path10 != path11) & (path10 != path12) & (path10 != path13) & (path11 != path12) & (path11 != path13) & (path12 != path13))).

% axioms that assure us that path is free and set before train can go

fof(availableRoute0, axiom, (![X]: (available(X, path0) <=> (nonconflicting(X, path0) & configuration(X, path0))))).
fof(availableRoute1, axiom, (![X]: (available(X, path1) <=> (nonconflicting(X, path1) & configuration(X, path1))))).
fof(availableRoute2, axiom, (![X]: (available(X, path2) <=> (nonconflicting(X, path2) & configuration(X, path2))))).
fof(availableRoute3, axiom, (![X]: (available(X, path3) <=> (nonconflicting(X, path3) & configuration(X, path3))))).
fof(availableRoute4, axiom, (![X]: (available(X, path4) <=> (nonconflicting(X, path4) & configuration(X, path4))))).
fof(availableRoute5, axiom, (![X]: (available(X, path5) <=> (nonconflicting(X, path5) & configuration(X, path5))))).
fof(availableRoute6, axiom, (![X]: (available(X, path6) <=> (nonconflicting(X, path6) & configuration(X, path6))))).
fof(availableRoute7, axiom, (![X]: (available(X, path7) <=> (nonconflicting(X, path7) & configuration(X, path7))))).
fof(availableRoute8, axiom, (![X]: (available(X, path8) <=> (nonconflicting(X, path8) & configuration(X, path8))))).
fof(availableRoute9, axiom, (![X]: (available(X, path9) <=> (nonconflicting(X, path9) & configuration(X, path9))))).
fof(availableRoute10, axiom, (![X]: (available(X, path10) <=> (nonconflicting(X, path10) & configuration(X, path10))))).
fof(availableRoute11, axiom, (![X]: (available(X, path11) <=> (nonconflicting(X, path11) & configuration(X, path11))))).
fof(availableRoute12, axiom, (![X]: (available(X, path12) <=> (nonconflicting(X, path12) & configuration(X, path12))))).
fof(availableRoute13, axiom, (![X]: (available(X, path13) <=> (nonconflicting(X, path13) & configuration(X, path13))))).

% axioms that determines where the trains would like to go

fof(wantsToGoin2out3, axiom, (![X]: ?[T]: (wantsToGo(X,in2,out3) <=> (at(X,T,in2) & goal(T)=out3)))).
fof(wantsToGoin2out2, axiom, (![X]: ?[T]: (wantsToGo(X,in2,out2) <=> (at(X,T,in2) & goal(T)=out2)))).
fof(wantsToGoin2out1, axiom, (![X]: ?[T]: (wantsToGo(X,in2,out1) <=> (at(X,T,in2) & goal(T)=out1)))).
fof(wantsToGoin1out3, axiom, (![X]: ?[T]: (wantsToGo(X,in1,out3) <=> (at(X,T,in1) & goal(T)=out3)))).
fof(wantsToGoin1out2, axiom, (![X]: ?[T]: (wantsToGo(X,in1,out2) <=> (at(X,T,in1) & goal(T)=out2)))).
fof(wantsToGoin1out1, axiom, (![X]: ?[T]: (wantsToGo(X,in1,out1) <=> (at(X,T,in1) & goal(T)=out1)))).
fof(wantsToGoin3out3, axiom, (![X]: ?[T]: (wantsToGo(X,in3,out3) <=> (at(X,T,in3) & goal(T)=out3)))).
fof(wantsToGoin3out2, axiom, (![X]: ?[T]: (wantsToGo(X,in3,out2) <=> (at(X,T,in3) & goal(T)=out2)))).
fof(wantsToGoin3out1, axiom, (![X]: ?[T]: (wantsToGo(X,in3,out1) <=> (at(X,T,in3) & goal(T)=out1)))).

% axioms that determines which path is supposed to be used in which situation

fof(pathToBeUsed0, axiom, (![X]: (toBeUsed(X, path0) <=> (available(X, path0) & clockOrder(X)=in1 & wantsToGo(X,in1,out3))))).
fof(pathToBeUsed1, axiom, (![X]: (toBeUsed(X, path1) <=> (available(X, path1) & clockOrder(X)=in2 & wantsToGo(X,in2,out3))))).
fof(pathToBeUsed2, axiom, (![X]: (toBeUsed(X, path2) <=> (available(X, path2) & clockOrder(X)=in3 & wantsToGo(X,in3,out3))))).
fof(pathToBeUsed3, axiom, (![X]: (toBeUsed(X, path3) <=> (available(X, path3) & clockOrder(X)=in2 & wantsToGo(X,in2,out2))))).
fof(pathToBeUsed4, axiom, (![X]: (toBeUsed(X, path4) <=> (available(X, path4) & clockOrder(X)=in3 & wantsToGo(X,in3,out2))))).
fof(pathToBeUsed5, axiom, (![X]: (toBeUsed(X, path5) <=> (available(X, path5) & clockOrder(X)=in1 & wantsToGo(X,in1,out2))))).
fof(pathToBeUsed6, axiom, (![X]: (toBeUsed(X, path6) <=> (available(X, path6) & clockOrder(X)=in2 & wantsToGo(X,in2,out2))))).
fof(pathToBeUsed7, axiom, (![X]: (toBeUsed(X, path7) <=> (available(X, path7) & clockOrder(X)=in3 & wantsToGo(X,in3,out2))))).
fof(pathToBeUsed8, axiom, (![X]: (toBeUsed(X, path8) <=> (available(X, path8) & clockOrder(X)=in1 & wantsToGo(X,in1,out1))))).
fof(pathToBeUsed9, axiom, (![X]: (toBeUsed(X, path9) <=> (available(X, path9) & clockOrder(X)=in2 & wantsToGo(X,in2,out1))))).
fof(pathToBeUsed10, axiom, (![X]: (toBeUsed(X, path10) <=> (available(X, path10) & clockOrder(X)=in3 & wantsToGo(X,in3,out1))))).
fof(pathToBeUsed11, axiom, (![X]: (toBeUsed(X, path11) <=> (available(X, path11) & clockOrder(X)=in1 & wantsToGo(X,in1,out1))))).
fof(pathToBeUsed12, axiom, (![X]: (toBeUsed(X, path12) <=> (available(X, path12) & clockOrder(X)=in2 & wantsToGo(X,in2,out1))))).
fof(pathToBeUsed13, axiom, (![X]: (toBeUsed(X, path13) <=> (available(X, path13) & clockOrder(X)=in3 & wantsToGo(X,in3,out1))))).

% axiom that set the path in the control system

fof(setPath, axiom, (![X,P]: (configuration(succ(X),P) <=> ((configuration(X,P) & ~free(X,P)) | toBeUsed(X,P))))).

% axiom that describes how the inputs are opened
fof(openGatein2, axiom, (![X]: (open(succ(X),in2) <=> (toBeUsed(X, path1) | toBeUsed(X, path3) | toBeUsed(X, path6) | toBeUsed(X, path9) | toBeUsed(X, path12))))).
fof(openGatein1, axiom, (![X]: (open(succ(X),in1) <=> (toBeUsed(X, path0) | toBeUsed(X, path5) | toBeUsed(X, path8) | toBeUsed(X, path11))))).
fof(openGatein3, axiom, (![X]: (open(succ(X),in3) <=> (toBeUsed(X, path2) | toBeUsed(X, path4) | toBeUsed(X, path7) | toBeUsed(X, path10) | toBeUsed(X, path13))))).