-module(example1).
-vsn('$Revision: /main/release/2 $ ').
-export([init/0]).


init() ->
    S = gs:start(),
    Win = gs:create(window, S, [{width, 200}, {height, 100}]),
    Butt = gs:create(button, Win, [{label, {text, "Press Me"}}]),
    gs:config(Win, {map, true}),
    loop(Butt).

loop(Butt) ->
    receive
        {gs, Butt, click, Data, Args} ->
            io:format("Hello There~n", []),
            loop(Butt)
    end.
