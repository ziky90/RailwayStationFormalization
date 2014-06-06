fof(antisymmetry, axiom, (
    ![X,Y]: ((less(X,Y) & less(Y,X)) => (X = Y))
)).
fof(transitivity, axiom, (
    ![X,Y,Z]: ((less(X,Y) & less(Y, Z)) => less(X, Z))
)).
fof(totality, axiom, (
    ![X,Y]: (less(X,Y) | less(Y,X))
)).

fof(succ, axiom, (
    ![X]: (   (less(X,succ(X))) 
            & (![Y]: (less(Y,X) | less(succ(X), Y)))
        )
)).

% Obvykle toto pro dukaz neni potreba.
%fof(succ_neq, axiom, (
%    ![T]: (succ(T) != T)
%)).

% Naopak pro dukazy je casto potreba vedet, ze ke kazdemu stavu existuje nejen
% nasledujici ale i prave jeden predchozi:
fof(pred, axiom, (
    ![X]: ((
        (pred(succ(X)) = X)
      & (succ(pred(X)) = X)
    ))
)).
