-module(frequency).
-export([
         start/0,
         stop/0,
         allocate/0,
         deallocate/1
        ]).
-export([init/0]).

%% Функции инициализации и запуска процесса сервера %%
%% Инциализация сервера %%
start() ->
    register(frequency, spawn(frequency, init, [])).

init() ->
    process_flag(trap_exit, true),
    Frequencies = {get_frequencies(), []},
    loop(Frequencies).
%% Список частот %%
get_frequencies() -> [10, 11, 12, 13, 14, 15].
%% Клиентские функции %%
stop()           -> call(stop).
allocate()       -> call(allocate).
deallocate(Freq) -> call({deallocate, Freq}).
%% Передача сообщений %%
call(Message) ->
    frequency ! {request, self(), Message},
    receive
        {reply, Reply} -> Reply
    end.
reply(Pid, Message) ->
    Pid ! {reply, Message}.
loop(Frequencies) ->
    receive
        {request, Pid, allocate}           ->
            {NewFrequencies, Reply} = allocate(Frequencies, Pid),
            reply(Pid, Reply),
            loop(NewFrequencies);
        {request, Pid, {deallocate, Freq}} ->
            NewFrequencies = deallocate(Frequencies, Freq),
            reply(Pid, ok),
            loop(NewFrequencies);
        {'EXIT', Pid, _Reason}             ->
            NewFrequencies = exited(Frequencies, Pid),
            loop(NewFrequencies);
        {request, Pid, stop}               ->
            reply(Pid, ok)
    end.
allocate({[], Allocated}, _Pid) ->
    {{[], Allocated}, {error, no_frequencies}};
allocate({[Freq | Frequencies], Allocated}, Pid) ->
    link(Pid),
    {{Frequencies, [{Freq, Pid} | Allocated]}, {ok, Freq}}.
deallocate({Free, Allocated}, Freq) ->
    {value, {Freq, Pid}} = lists:keysearch(Freq, 1, Allocated),
    unlink(Pid),
    NewAllocated = lists:keydelete(Freq, 1, Allocated),
    {[Freq | Free], NewAllocated}.
exited({Free, Allocated}, Pid) ->
    case lists:keysearch(Pid, 2, Allocated) of
        {value, {Freq, Pid}} ->
            NewAllocated = lists:keydelete(Freq, 1, Allocated),
            {[Freq | Free], NewAllocated};
    false ->
        {Free, Allocated}
    end.
