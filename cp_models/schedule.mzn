% minizinc --solver gecode schedule.mzn --intermediate

enum Task = {A, B, C, D, E, F, G, H, I};
set of int: machines = 1..2;

array[Task] of var 0..100: s;
array[Task] of var machines: m;

% array[Task] of int: d = [15, 15, 20, 15, 20, 20, 20, 5, 10];
array[Task] of int: d = [5, 10, 15, 10, 15, 10, 20, 5, 5];

array[int, 1..2] of Task: deps =
   [| A, B
    | A, C
    | B, H
    | C, F
    | C, G
    | F, H
    | D, E
    | D, F
    | G, I
    | E, I
    | E, F
    | E, G |];

constraint forall(i in index_set_1of2(deps))(s[deps[i,2]] >= s[deps[i,1]] + d[deps[i,1]]);
constraint forall(t1, t2 in Task where t1 != t2)((m[t1] == m[t2]) -> ((s[t1] + d[t1] <= s[t2]) \/ (s[t2] + d[t2] <= s[t1])));

var int: end;
end = max(t in Task)(s[t] + d[t]);

solve minimize end;

output [
  show(mv - 1) ++ ": " ++
  concat([
    if exists(t in Task)(fix(m[t]) == mv /\ fix(s[t]) <= slot * 5 /\ fix(s[t]) + d[t] > slot * 5)
    then show(min([t | t in Task where fix(m[t]) == mv /\ fix(s[t]) <= slot * 5 /\ fix(s[t]) + d[t] > slot * 5]))
    else "-"
    endif
    | slot in 0..24
  ]) ++ "\n"
  | mv in machines
] ++ ["\nduration: \(end)"];


