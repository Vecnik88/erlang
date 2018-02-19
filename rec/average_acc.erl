-module(average_acc).
-export([average_acc/1]).

average_acc(List) -> average_acc(List, 0, 0).
average_acc([], Sum, Length) -> Sum/Length;
average_acc([Head | Tail], Sum, Length) -> average_acc(Tail, Sum+Head, Length+1).
