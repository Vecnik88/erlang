-module(echo_process).
-export([
         go/0, 
         loop/0
        ]).
go() ->
    Pid = spawn(echo_process, loop, []),
    Pid ! {self(), hello},
    receive
        {Pid, Msg} ->
            io:format("~w~n", [Msg])
    end,
    Pid ! stop.
loop() ->
    receive
        {From, Msg} ->
            From ! {self(), Msg},
            loop();
        stop ->
            true
    end.
