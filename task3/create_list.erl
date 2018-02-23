-module(create_list).
-export([create_list/1]).

create_list(SizeList) when is_integer(SizeList) ->
    create_list(SizeList, []);
create_list(_SizeList) ->
    error.
create_list(0, Acc) ->
    Acc;
create_list(SizeList, Acc) ->
    create_list(SizeList - 1, [SizeList | Acc]).
