#import "@preview/touying:0.7.4": *
#import "@preview/board-n-pieces:0.9.0": *
#import "@preview/truthfy:0.6.0": *
#import themes.dewdrop: *

== 8-Queens revisited <touying:unoutlined>
- We have seen that that MiniZinc gives us a solution fairly quickly. #pause
  - But how does it find it? #pause
  - Just tries out solutions and verifies them


#let make-board-string(n, queens) = {
  range(n).map(row => {
    range(n)
      .map(col => {
        if queens.contains((row, col)) { "Q" } else { "." }
      })
      .join()
  })
}

#let make-board(n, queens) = board(position(..make-board-string(n, queens)))

#slide[
#align(center + horizon)[
  #alternatives[
    *Start with one queen*
    #make-board(8, ((1, 1),))
  ][
    *Add more queens*
    #make-board(8, ((1, 1), (6, 2)))
  ][
    *Check if our constraints are fulfilled*
    #make-board(8, ((1, 1), (6, 2), (6, 6)))
  ][
    *If not, go back*
    #board(
      position(..make-board-string(8, ((1, 1), (6, 2), (6, 6)))),

      marked-squares: (
        "g2": marks.cross(paint: red),
      ),
    )
  ][
    *And try another position*
    #make-board(8, ((1, 1), (6, 2), (5, 6)))
  ][
    *Until we find a solution*
    #make-board(8, ((1, 1), (6, 2), (5, 6), (7, 5), (2, 7), (0, 4), (3, 0), (4,3)))
  ]
]
]

== Going from Chess to Booleans <touying:unoutlined>
- The computer doesn't place actual queens on a (virtual) chessboard #pause
- Instead, it translates our constraints into a series of *logical formulas*: #pause
  - The goal is then to find an *assignment* of logical variables such that the formula is *satifised*

#v(5%)
#align(center)[
  #text(size: 24pt)[$(x_1 or not x_2 or x_3) and (not x_1 or x_2 or x_3) and (x_1 or x_2 or not x_3)$ #footnote[This style of logical formular is called *Conjunctive Normal Form*]\
  \ Which value should $x_1,x_2$ and $x_3$ have to get 1? \ \
]
]

#slide[
- You might have thought a solution up in your head and verified it #pause // By for instance looking at the formular and deducing which variables can be eliminated
- But the way a computer would usually do it is with a *truth table*:
#align(center)[
  // TODO: I would like to have a column with checkmarks / crosses for the assignments that satisfy the formular, but truthfy doesn't seem to support that
  #truth-table($x_1 or not x_2 or x_3$, $not x_1 or x_2 or x_3$, $x_1 or x_2 or not x_3$)
]
]

