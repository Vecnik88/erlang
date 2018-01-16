%% simple example with qsort on erlang %%

-module(qsort).
-export([qsort/1, pithag/1, perms/1]).

qsort([])->[];
qsort([Pivot | T])->
	qsort([X || X <- T, X < Pivot])
	++[Pivot]++
	qsort([X || X <- T, X >= Pivot]).

pithag(N)->
	[{A, B, C} || A<-lists:seq(1, N),
		      B<-lists:seq(1, N),
		      C<-lists:seq(1, N),
		      A + B + C =< N,
		      A * A + B * B =:= C*C].
perms([])->[[]];
perms(L)->[[H | T] || H<-L, T <-perms(L--[H])].

