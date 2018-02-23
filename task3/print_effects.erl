-module(print_effects).
-export([
         print_effects/1, 
         print_effects_data/1
        ]).

print_effects(1) ->
    io:format("Number:~p~n", [1]);
print_effects(Number) ->
    print_effects(Number - 1),
    io:format("Number:~p~n", [Number]).
print_effects_data(Number) ->
    case Number of
        0 -> ok;
        1 -> io:format("Number: ~p~n", [Number]);
        Number when Number rem 2 == 1 -> 
            print_effects_data(Number - 1),
            io:format("Number: ~p~n", [Number]);
        _ -> print_effects_data(Number - 1)
    end.
