-module(holdl).
-export([get_stat/1,
         get_users/0,
         get_males/1,
         get_females/1,
         split_by_age/1]).

get_users() ->
    [{user, 1, "Bob", male, 22},
     {user, 2, "Helen", female, 14},
     {user, 3, "Bill", male, 11},
     {user, 4, "Kate", female, 18}].

get_females(Users) ->
    F = fun({user, _, _, male, _}) -> false;
           ({user, _, _, female, _}) -> true
        end,
    lists:filter(F, Users).

get_males(Users) ->
    F = fun({user, _, _, male, _}) -> true;
           ({user, _, _, female, _}) -> false
        end,
    lists:filter(F, Users).

get_stat(Users) ->
    F = fun({user, _, _, Gender, Age}, {Males, Females, TotalUsers, TotalAge}) ->
            case Gender of
                male -> {Males + 1, Females, TotalUsers + 1, TotalAge + Age};
                female -> {Males, Females + 1, TotalUsers + 1, TotalAge + Age}
            end
        end,
    lists:foldl(F, {0, 0, 0, 0}, Users).

split_by_age(Users) ->
    lists:foldl(fun(User, {Acc1, Acc2}) ->
                    {user, _, _, _, Age} = User,
                    if 
                        Age > 18 -> {[User | Acc1], Acc2};
                        true -> {Acc1, [User | Acc2]}
                    end
                end,
                {[], []},
                Users).
