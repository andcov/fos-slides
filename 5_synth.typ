#import "@preview/touying:0.7.4": *
#import themes.dewdrop: *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#let diagram = touying-reducer.with(
  reduce: fletcher.diagram, cover: fletcher.hide
)

== What is Program Synthesis? <touying:unoutlined>
- Similar to the Constraint Programming problems, but instead of getting a list of values, we get a *program* #pause
  - We give a set of operations (For Arithmetic, Strings, Bits, ...)#pause
  - Program needs to fulfill a *specification* #pause
  - "Generate me a program that, when given 3, returns 9" #pause
    - *Result:* $f(x) = x^2$
  - Resulting program is *correct by construction*

== Applications <touying:unoutlined>
#align(center)[#text(size: 28pt)[*Excel (FlashFill)*]]

#alternatives[
  #figure(image("assets/flash-fill-01.png", width: 80%))
][
  #figure(image("assets/flash-fill-02.png", width: 80%))
][
  #figure(image("assets/flash-fill-03.png", width: 80%))
]

#place(center + bottom)[#text(size: 16pt)[Images taken from: https://www.dialog-mail.com/email-blog/2023/20230928_flash-fill.php]]

#pagebreak()
#align(center)[#text(size: 28pt)[*Compiler Backends*]]

#v(10%)

#align(center)[
#diagram(
  node((0,0), image("assets/cpp_logo.png"), height: 5cm), pause,
  edge("-|>"), 
  node((1.5,0), text(size: 28pt)[Intermediate \ Representation], stroke: 1pt), pause,
  edge("-|>", align(center)[*Instruction \ Selector*]),
  node((3.5,0), image("assets/gears.png"), height: 5cm), pause
)
]

#v(10%)

#text(size: 24pt)[$=>$ Generate the instruction selection rules automatically]#footnote(numbering: "*")[What I'm writing my bachelor thesis about :)]

#pagebreak()
- Let's go back to FlashFill... #pause \
  $=>$ We are given E-Mail addresses and want to extract the first and lastname
#set table(
  stroke: none,
  gutter: 0.2em,
  fill: (x, y) =>
    if y == 0 { blue },
  inset: (right: 1.5em),
)

#show table.cell: it => {
  if it.y == 0 {
    set text(white)
    it
  } else {
    it
  }
}

#pause
#align(center)[
  #table(columns: 2,
  [E-Mail], [Expected Result],

  [leia.organa\@rebellion.net], [leia,organa],
  [paul.atreides\@arrakis.org], [paul,atreides],
  [ellen.ripley\@nostromo.us], [ellen,ripley],
  [ryland.grace\@hail-mary.space], [ryland,grace],
)
]
#pause
- All of them have different E-Mail addresses #pause
- Could write a function ourselves... #pause
  - but why don't we let the computer generate one? #pause

#align(center)[#text(size: 28pt)[Enough to give one example]]

== FlashFill Example <touying:unoutlined>
#pagebreak()

- But beforehand, we do need to also give the "allowed" operations

#align(center)[#text(size: 24pt)[*What functions might we need?*]]
#v(1%)
- `replace(".", ",")` #pause
- `indexOf(x, character)` #pause
- `substr(x, start, end)` #pause
#v(1%)
#align(center)[#text(size: 24pt)[*And what is our specification?*]

`f("leia.organa@rebellion.net") = "leia,organa"`]

