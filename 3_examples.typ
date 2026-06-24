#import "@preview/touying:0.7.4": *
#import themes.dewdrop: *
#import "@preview/board-n-pieces:0.9.0": *
#import "@preview/cades:0.3.1": qr-code

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

#focus-slide[#text(luma(60%), "(apparent)") detour: 8-Queens]

== 8-Queens <touying:unoutlined>
- place 8 queens, such that they do not attack each other

#align(center + horizon)[
  #alternatives[
    #make-board(8, ())
  ][
    #make-board(8, ((1, 1),))
  ][
    #make-board(8, ((1, 1), (3, 2)))
  ][
    #make-board(8, ((1, 1), (3, 2), (6, 6)))
  ][
    #board(
      position(..make-board-string(8, ((1, 1), (3, 2), (6, 6)))),

      marked-squares: (
        "g2": marks.cross(paint: red),
      ),
    )
  ]
]


== 4-Queens <touying:unoutlined>

#align(center + horizon)[
  #alternatives[
    #make-board(4, ())
  ][
    #make-board(4, ((0, 1), (1, 3), (2, 0), (3, 2)))
  ]
]


== Modelling $n$-Queens <touying:unoutlined>
- Try to model this mathematically!

#pause

Variables:
$
  c_1, ..., c_n & in {1, ..., n} \
  r_1, ..., r_n & in {1, ..., n}
$

#pause

Relationships:
- *Unique columns*: $c_i != c_j$
- *Unique rows*: $r_i != r_j$
- *Unique main diagonal*: $r_i - c_i != r_j - c_j$
- *Unique antidiagonal*: $r_i + c_i != r_j + c_j$
(for all $i, j in {1, ..., n}$ with $i != j$)

== Modelling $n$-Queens ... Continued <touying:unoutlined>

#let mzn_link = "https://play.minizinc.dev/"
#align(center + horizon)[
  #qr-code(mzn_link, width: 30%)
  #v(1em)
  _ #mzn_link _
]

== How does CP work? <touying:unoutlined>

#align(center + horizon)[
  #alternatives[
    #make-board(4, ())
  ][
    #make-board(4, ((0, 0),))
  ][
    #make-board(4, ((0, 0), (0, 1)))
  ][
    #board(
      position(..make-board-string(4, ((0, 0), (0, 1)))),

      marked-squares: (
        "b4": marks.cross(paint: red),
      ),
    )
  ][
    #make-board(4, ((0, 0), (0, 2)))
  ][
    #board(
      position(..make-board-string(4, ((0, 0), (0, 2)))),

      marked-squares: (
        "c4": marks.cross(paint: red),
      ),
    )
  ][
    #make-board(4, ((0, 0), (1, 2)))
  ][
    ...
  ][
    #make-board(4, ((0, 1), (1, 3), (2, 0), (3, 2)))
  ][
    *Sooooooo slow!*
    // NOTE: how many options checked, worst case?
  ][
    #make-board(4, ((0, 0),))
    // NOTE: how do you (humans) go about solving this?
  ][
    #board(
      position(..make-board-string(4, ((0, 0),))),

      marked-squares: (
        "b4 c4 d4": marks.cross(paint: red),
        "a3 a2 a1": marks.cross(paint: red),
        "b3 c2 d1": marks.cross(paint: red),
      ),
    )
  ][
    #board(
      position(..make-board-string(4, ((0, 0), (1, 2)))),

      marked-squares: (
        "b4 c4 d4": marks.cross(paint: red),
        "a3 a2 a1": marks.cross(paint: red),
        "b3 c2 d1": marks.cross(paint: red),
      ),
    )
  ][
    #board(
      position(..make-board-string(4, ((0, 0), (1, 2)))),

      marked-squares: (
        "b4 c4 d4": marks.cross(paint: red),
        "a3 a2 a1": marks.cross(paint: red),
        "b3 c2 d1": marks.cross(paint: red),
        "d3 c1 b2 d2": marks.cross(paint: red),
      ),
    )
  ]
]

// == THIS HOW WORK <touying:unoutlined>
// + we have a bunch of possible values for the variables
// + we pick a value
// + we remove values which become impossible (based on constraints)
// + is the model still satisfiable?
//   + yes? go back to step 1
//   + no? backtrack!

// == h
// $
//          & x in {0, ..., 30} \
//          & y in {0, ..., 40} \
//          & x + y >= 50 \
//          \
//   #speaker-note[
//     + What's the most stupid way to find a solution?
//   ]
//   #pause & x = 0, y = 0 #pause \
//          & thick arrow.r.curve 0 + 0 >= 50 #pause thin crossmark.heavy #pause \
//          & x = 1, y = 0 #pause \
//          & thick arrow.r.curve 1 + 0 >= 50 thin crossmark.heavy #pause \
//          & ...#pause \
//          & x = 30, y = 20 \
//          & thick arrow.r.curve 30 + 20 >= 50 thin checkmark.heavy \
// $

// #speaker-note[
//   + WAAAY TOO SLOW!
//   + Is this how
// ]
