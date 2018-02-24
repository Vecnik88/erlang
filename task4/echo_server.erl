-module(echo_server).
-export([
         start/0,
         allocate/0,
         deallocate/1,
         stop/0,
         init/0
        ]).
%% Запуск сервера %%
start() ->
    register(echo_server, spawn(echo_server, init, [])).
%% Инициализация сервера %%
init() ->
    Frequencies = {get_frequencies(), []},
    loop(Frequencies).

%% Список частот %%
get_frequencies() -> [10,11,12,13,14,15].

%% Клиентские функции %%
stop()           -> call(stop).
allocate()       -> call(allocate).
deallocate(Freq) -> call({deallocate, Freq}).

call(Msg) ->
    echo_server ! {request, self(), Msg},
    receive
        {reply, Reply} -> Reply
    end.
%% Цикл обработки %%
loop(Frequencies) ->
    receive
        {request, Pid, allocate} ->
            {NewFrequencies, Reply} = allocate(Frequencies, Pid),
            reply(Pid, Reply),
            loop(NewFrequencies);
        {request, Pid, {deallocate, Freq}} ->
            NewFrequencies = deallocate(Frequencies, Freq),
            reply(Pid, ok),
            loop(NewFrequencies);
        {request, Pid, stop} ->
            reply(Pid, ok)
    end.
reply(Pid, Reply) ->
    Pid ! {reply, Reply}.
allocate({[], Allocated}, _Pid) ->
    {{[], Allocated}, {error, no_frequency}};
allocate({[Freq | Free], Allocated}, Pid) ->
    {{Free, [{Freq, Pid} | Allocated]}, {ok, Freq}}.
deallocate({Free, Allocated}, Freq) ->
    NewAllocated=lists:keydelete(Freq, 1, Allocated),
    {[Freq | Free], NewAllocated}.
