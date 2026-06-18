int: n_jobs = 7;
int: n_tasks = 6;

set of int : jobs = 1..n_jobs;
set of int : tasks = 1..n_tasks;

array [jobs, tasks] of int: d = 
[| 2, 4, 1,  4,  1, 7
 | 1, 6, 1,  1, 12, 3
 | 3, 8, 2, 85,  1, 5
 | 1, 5, 3,  4,  1, 3 
 | 1, 6, 1,  1, 12, 3
 | 3, 8, 2, 85,  1, 5
 | 1, 5, 3,  4,  1, 3 |];

int: total = sum([d[i, j] | i in jobs, j in tasks]);
array [jobs, tasks] of var 0..total: s;

constraint forall(t in tasks, i, j in jobs where i != j)(
    s[i, t] + d[i, t] < s[j, t] \/ s[j, t] + d[j, t] < s[i, t]
);

constraint forall(i in jobs, t, p in tasks where t < p)(
    s[i, t] + d[i, t] < s[i, p]
);

var int: end = max([s[i, t] + d[i, t] | i in jobs, t in tasks]);
solve minimize end;

output "\(end)\n" ++ "\(s)";