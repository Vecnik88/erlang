-module(average).
-export([average/1]).

average(List) -> sum(List)/len(List).

sum([]) -> 0;
sum([Head | Tail]) -> Head + sum(Tail).

len([]) -> 0;
len([_Head | Tail]) -> 1 + len(Tail).
