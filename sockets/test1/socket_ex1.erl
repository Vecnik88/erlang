-module(socket_ex1).
-compile(export_all).
-import(lists, [reverse/1]).


nano_get_url() ->
    nano_get_url("www.google.com").

nano_get_url(Host) ->
    {ok,Socket} = gen_tcp:connect(Host,80,[binary, {packet, 0}]), %% (1)
    ok = gen_tcp:send(Socket, "GET / HTTP/1.0\r\n\r\n"),  %% (2)
    receive_data(Socket, []).

receive_data(Socket, SoFar) ->
    receive
	{tcp,Socket,Bin} ->    %% (3)
	    receive_data(Socket, [Bin|SoFar]);
	{tcp_closed,Socket} -> %% (4)
	    list_to_binary(reverse(SoFar)) %% (5)
    end.

