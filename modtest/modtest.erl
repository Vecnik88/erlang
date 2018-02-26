-module(modtest).
-export([
         main/0,
         loop/0,
         a/1,
         do/1
        ]).
main() ->
    register(foo, spawn(modtest, loop, [])).

loop() ->
    receive
        {Sender, N} ->
            Sender ! a(N)
    end,
    loop().

do(M) ->
    foo ! {self(), M},
    receive Y ->
        Y
    end.
a(N) -> N.
