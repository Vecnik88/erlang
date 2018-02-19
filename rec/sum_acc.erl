-module(sum_acc).
-export([sum_acc/1]).

sum_acc(List) -> sum_acc(List, 0).
sum_acc([], Acc) -> Acc;
sum_acc([Head | Tail], Acc) -> sum_acc(Tail, Acc+Head).
