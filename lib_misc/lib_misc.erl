-module(lib_misc).
-export([for/3, sum/1, map/2, total/1, map_clone/2]).

for(Max, Max, F)->[F(Max)];
for(I, Max, F)->[F(I) | for(I+1, Max, F)].

sum([H | T])->H + sum(T);
sum([])-> 0.

map(_, [])->[];
map(F, [H | T])->[F(H) | map(F, T)].

cost(apples)->2;
cost(tomato)->6;
cost(pears)->10;
cost(milk)->4;
cost(_)->0.

total(L)->
	sum(map(fun({What, N})->cost(What) * N end, L)).

map_clone(F, L)->
	[F(X) || X<-L].

