%% Здесь все функции с ошибкой, чтобы посмотреть на работу исключений %%

-module(errors).
-export([function_clause/1,
         case_clause/1,
         if_clause/1
        ]).

function_clause(N) when N > 0 ->
    N * function_clause(N - 1);
function_clause(0) -> 1.

case_clause(N) ->
    case N of
        -1 -> false;
        1  -> true
    end.

if_clause(N) ->
    if
        N < 0 -> false;
        N > 0 -> true
    end.
