-module(accum).
-export([odds_and_events_acc/1]).

odds_and_events_acc(L)->
odds_and_events_acc(L, [], []).

odds_and_events_acc([H|T], Odds, Events)->
case H rem 2 of
    1->odds_and_events_acc(T, [H|Odds], Events);
    0->odds_and_events_acc(T, Odds, [H|Events])
end;
odds_and_events_acc([], Odds, Events)->
{Odds, Events}.

