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


== Modelling N-Queens <touying:unoutlined>

#only(1, align(center + horizon)[#text("Try it yourself!", size: 1.7em)])

#pause

Variables:
$
  c_1, ..., c_n & in {1, ..., n} \
  r_1, ..., r_n & in {1, ..., n}
$

Relationships:
- *Unique columns*: $c_i != c_j$
- *Unique rows*: $r_i != r_j$
- *Unique main diagonal*: $r_i - c_i != r_j - c_j$
- *Unique antidiagonal*: $r_i + c_i != r_j + c_j$
(for all $i, j in {1, ..., n}$ with $i != j$)

== Modelling N-Queens Continued <touying:unoutlined>

#let mzn_link = "https://play.minizinc.dev/"
#align(center + horizon)[
  #qr-code(mzn_link, width: 30%)
  #v(1em)
  _ #mzn_link _
]
