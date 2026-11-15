
:- use_module(clpfd).


container(aa, 2, 2).
container(ab, 3, 2).
container(ac, 5, 5).
container(ba, 6, 2).
container(bb, 1, 2).
container(bc, 3, 3).
container(ca, 3, 2).
container(cb, 5, 2).
container(cc, 2, 3).

on(aa, ba).
on(ab, ba).
on(ab, bb).
on(ac, ba).
on(ac, bb).
on(ac, bc).
on(ba, ca).
on(ba, cb).
on(bb, cb).
on(bc, cb).
on(bc, cc).


% schedule(Workers, EndTime, Cost)
% Finds a schedule that minimizes the total cost
% of unloading all containers.

schedule(Workers, EndTime, Cost) :-
    findall(container(Id, People, Duration),
            container(Id, People, Duration),
            Containers),

    Containers = [_|_],

    sum_resources(Containers, MaxWorkers, MaxTime),

    containers_tasks(Containers, Tasks,
                     StartTimes, EndTimes),

    StartTimes ins 0..MaxTime,
    EndTimes ins 0..MaxTime,

    Workers in 1..MaxWorkers,
    EndTime in 1..MaxTime,

    precedence_constraints(Tasks),

    finish_before_end(EndTimes, EndTime),

    cumulative(Tasks, [limit(Workers)]),

    Cost #= Workers * EndTime,

    labeling([min(Cost)],
             [Cost, Workers, EndTime|StartTimes]).


% sum_resources(Containers, Workers, Duration)
% Computes the total worker requirement and
% total duration as upper bounds.

sum_resources([], 0, 0).

sum_resources(
    [container(_, People, Duration)|Rest],
    TotalPeople,
    TotalDuration
) :-
    sum_resources(Rest, OtherPeople, OtherDuration),
    TotalPeople is People + OtherPeople,
    TotalDuration is Duration + OtherDuration.


% containers_tasks(Containers, Tasks, Starts, Ends)
% Creates a CLP(FD) task for each container.

containers_tasks([], [], [], []).

containers_tasks(
    [container(Id, People, Duration)|Rest],
    [task(Start, Duration, End, People, Id)|Tasks],
    [Start|Starts],
    [End|Ends]
) :-
    End #= Start + Duration,

    containers_tasks(Rest, Tasks, Starts, Ends).


% precedence_constraints(Tasks)
% Applies unloading dependencies.

precedence_constraints(Tasks) :-
    findall(Above-Below,
            on(Above, Below),
            Relations),

    constrain_relations(Relations, Tasks).


% constrain_relations(Relations, Tasks)
% A container above another must finish
% before the lower container starts.

constrain_relations([], _).

constrain_relations([Above-Below|Relations], Tasks) :-
    member(task(_, _, EndAbove, _, Above), Tasks),
    member(task(StartBelow, _, _, _, Below), Tasks),

    EndAbove #=< StartBelow,

    constrain_relations(Relations, Tasks).


% finish_before_end(EndTimes, EndTime)
% All containers must be unloaded by EndTime.

finish_before_end([], _).

finish_before_end([End|Rest], EndTime) :-
    End #=< EndTime,

    finish_before_end(Rest, EndTime).
