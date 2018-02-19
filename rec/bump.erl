-module(bump).
-export([bump/1]).

bump([]) -> [];
bump([Head | Tail]) -> [Head + 1 | bump(Tail)].
