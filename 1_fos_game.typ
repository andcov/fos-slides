#import "@preview/touying:0.7.4": *
#import "@preview/cades:0.3.1": qr-code
#import themes.dewdrop: *

#focus-slide[
  What is science?
]

== You know, I'm something of a scientist myself <touying:unoutlined>
#pause

#place(
  top + left,
  dx: 30%,
  dy: 28%,
  image("assets/image-2.png", width: 20%),
)

#pause

#place(
  top + left,
  dx: 56%,
  dy: 18%,
  image("assets/image-3.png", width: 40%),
)

#pause

#place(
  top + left,
  dx: 0%,
  dy: 10%,
  image("assets/image-1.png", width: 30%),
)

#pause
#place(
  top + left,
  dx: 45%,
  dy: 40%,
  image("assets/image-4.png", width: 40%),
)

#pause
#place(
  top + left,
  dx: 0%,
  dy: 35%,
  figure(
    image("assets/image.png"),
    numbering: none,
    caption: [*"rapid unscheduled disassembly"*],
  ),
)

#pause
#place(
  top + left,
  dx: 45%,
  dy: 30%,
  image("assets/image-7.png", width: 40%),
)


#pause
#place(
  top + left,
  dy: 7%,
  dx: 5%,
  image("assets/image-8.png", width: 90%),
)





== What is science? <touying:unoutlined>

#pause

#figure(
  [
    #image("assets/image-5.png", width: 90%)
    #place(
      bottom + right,
      dy: -10pt,
      [_& computer science_],
    )
  ],
  numbering: none,
  caption: [xkcd 435],
)

#speaker-note[
  + what makes science... science?
  + can you give me examples of what is _not_ science?
  + what makes them not science? are you sure it does not apply to other fields?

  + fundamentally, we are interested in how we obtain information about the world, and then how we structure it to make predictions?
]

== Let's do some science! <touying:unoutlined>
#let fos_game_link = "https://jon011235.github.io/foundation-of-science-game/"
#align(center + horizon)[
  #qr-code(fos_game_link, width: 30%)
  #v(1em)
  _ #fos_game_link _
]

#focus-slide[
  #text(luma(60%), "part of") science is #text(luma(60%), "sometime") modelling
]
