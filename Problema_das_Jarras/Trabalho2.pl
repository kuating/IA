% a)
objetivo((2, J2)):- J2=0;J2=1;J2=2;J2=3.

% b)
valido((J1, J2)):- J1 >= 0, J1 =< 4, J2 >= 0, J2 =< 3.

acao((J1, J2), encher1, (4,J2)):- J1<4, valido((J1, J2)).
acao((J1, J2), encher2, (J1, 3)):- J2<3, valido((J1, J2)).

acao((J1, J2), esvaziar1, (0, J2)):- J1>0, valido((J1, J2)).
acao((J1, J2), esvaziar2, (J1, 0)):- J2>0, valido((J1, J2)).

acao((J1, J2), passar12, (0, J1eJ2)):- J1>0, J2<3, valido((J1, J2)), J1eJ2 is J1+J2, J1eJ2=<3.
acao((J1, J2), passar12, (J1resto, 3)):- J1>0, J2<3, valido((J1, J2)), J1+J2>=4, J1resto is J1-(3-J2), J1resto > 0.
acao((J1, J2), passar21, (J1eJ2, 0)):- J1<4, J2>0, valido((J1, J2)), J1eJ2 is J1+J2, J1eJ2=<4.
acao((J1, J2), passar21, (4, J2resto)):- J1<4, J2>0, valido((J1, J2)), J1+J2>3, J2resto is J2-(4-J1), J2resto > 0.

% c)
vizinho(N, FilhosN):- findall((Resultado), acao(N, _, Resultado), FilhosN).

% d), e), f)
% BFS usa uma Queue - novos elementos entram no final da lista
add_to_frontier_breadth(NN, F1, F2):-append(F1, NN, F2).

member(X, [X|_]) :- !.
member(X, [_|T]) :- member(X, T).

dif([], _, []) :- !.
dif(L, [], L) :- !.
dif(L, L, []) :- !.
dif([H1|T1], L2, L3) :- member(H1, L2), !, dif(T1, L2, L3), !.
dif([H1|T1], L2, [H1|T2]) :- dif(T1, L2, T2).

%NS = Neighbors Sequence
%NNS = New Neighbors Sequence (Neighbors not in frontier or visited)
bfs(E) :- bsearch([E],[E]).
bsearch([Node | _], _) :- objetivo(Node).
bsearch([Node | F1], NS) :- vizinho(Node, NN),
                       dif(NN, NS, NNN),
                       append(NNN, NS, NNS),
    				   
    				   write("Node: "), write($Node),nl,write("NNN: "), write($NNN),nl,
                       write("F1: "), write($F1),nl,nl,
                       
    				   add_to_frontier_breadth(NNN, F1, F2),
                       bsearch(F2,NNS).

% g)

% DFS usa uma Stack - novos elementos entram no inicio da lista
add_to_frontier_depth(NN, F1, F2):-append(NN, F1, F2).

dfs(E) :- dsearch([E],[E]).
dsearch([Node | _], _) :- objetivo(Node).
dsearch([Node | F1], NS) :- vizinho(Node, NN),
    				   
    				   dif(NN, NS, NNN),
                       append(NNN, NS, NNS),
                       
    				   write("Node: "), write($Node),nl,write("NNN: "), write($NNN),nl,
                       write("F1: "), write($F1),nl,nl,
                       write("NNS: "), write($NNS),nl,nl,
    
    				   % diferenca aqui
    				   add_to_frontier_depth(NNN, F1, F2),
                       dsearch(F2,NNS).
