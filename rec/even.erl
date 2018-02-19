-module(even).
-export([even/1]).

even([]) -> [];
even([Head | Tail]) when Head rem 2 =:= 0 -> [Head | even(Tail)];
even([_Head | Tail]) -> even(Tail).
