% minizinc --solver gecode --all-solutions n_queens.mzn
% minizinc --solver gecode n_queens.mzn

include "alldifferent.mzn";

int: n_queens = 10;











































% array[1..n_queens] of var int: rows;
% array[1..n_queens] of var int: cols;

% constraint forall(i, j in 1..n_queens where i != j)(rows[i] != rows[j]);
% constraint forall(i, j in 1..n_queens where i != j)(cols[i] != cols[j]);

% output ["(\(rows[i]), \(cols[i]))\n" | i in 1..n_queens]



























% =====================================================

% array[1..n_queens] of var int: rows;
% array[1..n_queens] of var int: cols;

% constraint forall(i in 1..n_queens) (rows[i] >= 1 /\ rows[i] <= n_queens);
% constraint forall(i in 1..n_queens) (cols[i] >= 1 /\ cols[i] <= n_queens);

% constraint forall(i, j in 1..n_queens where i != j)(rows[i] != rows[j]);
% constraint forall(i, j in 1..n_queens where i != j)(cols[i] != cols[j]);

% output ["(\(rows[i]), \(cols[i]))\n" | i in 1..n_queens]


























% =====================================================

% array[1..n_queens] of var 1..n_queens: rows;
% array[1..n_queens] of var 1..n_queens: cols;

% constraint alldifferent(rows);
% constraint alldifferent(cols);

% output
%     ["+" ++ concat(["---+" | _ in 1..n_queens]) ++ "\n"] ++
%     [
%         if col = 1 then "| " else "" endif ++
%         if fix(exists(i in 1..n_queens)(rows[i] = row /\ cols[i] = col)) then "Q | " else ". | " endif ++
%         if col = n_queens then "\n+" ++ concat(["---+" | _ in 1..n_queens]) ++ "\n" else "" endif
%         | row in 1..n_queens, col in 1..n_queens
%     ];

























% =====================================================

% array[1..n_queens] of var 1..n_queens: rows;
% array[1..n_queens] of var 1..n_queens: cols;

% constraint alldifferent(rows);
% constraint alldifferent(cols);

% constraint alldifferent([rows[i] - cols[i] | i in 1..n_queens]);
% constraint alldifferent([rows[i] + cols[i] | i in 1..n_queens]);

% output
%     ["+" ++ concat(["---+" | _ in 1..n_queens]) ++ "\n"] ++
%     [
%         if col = 1 then "| " else "" endif ++
%         if fix(exists(i in 1..n_queens)(rows[i] = row /\ cols[i] = col)) then "Q | " else ". | " endif ++
%         if col = n_queens then "\n+" ++ concat(["---+" | _ in 1..n_queens]) ++ "\n" else "" endif
%         | row in 1..n_queens, col in 1..n_queens
%     ];
































% =====================================================

% array[1..n_queens] of var 1..n_queens: cols;

% constraint alldifferent(cols);

% constraint alldifferent([i - cols[i] | i in 1..n_queens]);
% constraint alldifferent([i + cols[i] | i in 1..n_queens]);

% output
%     ["+" ++ concat(["---+" | _ in 1..n_queens]) ++ "\n"] ++
%     [
%         if col = 1 then "| " else "" endif ++
%         if fix(cols[row] = col) then "Q | " else ". | " endif ++
%         if col = n_queens then "\n+" ++ concat(["---+" | _ in 1..n_queens]) ++ "\n" else "" endif
%         | row in 1..n_queens, col in 1..n_queens
%     ];
