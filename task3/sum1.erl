-module(sum1).
-export([sum1/1]).

sum1(Number) ->
    sum1(Number, 0).
sum1(0, Acc) ->
    Acc;
sum1(Number, Acc) ->
    sum1(Number - 1, Acc + Number).
