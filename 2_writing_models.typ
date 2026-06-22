#import "@preview/touying:0.7.4": *
#import "@preview/pinit:0.2.2": *
#import themes.dewdrop: *

== "maths" to Python <touying:unoutlined>
#v(1em)

#grid(
  columns: (1fr, 2fr),
  [
    What we have in mind: \
    $"      "#pin(1)arrow(x)' = arrow(x) + Delta arrow(x)#pin(2)$
    #pause
  ],
  [
    What we have to write:
    #pin(3)```python
    def model(position, movement):
      return tuple(p + m for (p,m) in zip(position, movement))
    ```#pin(4)
    #pause
  ],
)

#pinit-point-from((1, 2), offset-dx: 5pt, offset-dy: 100pt, body-dx: -100pt)[
  #align(center)[_symbolic_ relation between \ positions & movement]
]

#speaker-note[
  + symbolic relation:
    - we do not have concrete values in mind
    - we model the relation between variables
]

#pause

#pinit-point-from((3, 4), pin-dy: 40pt, offset-dx: 5pt, offset-dy: 150pt, body-dx: -130pt)[
  #align(center)[_computational_ relation between \ positions & movement]
]

#pause
#place(
  bottom + right,
  dy: -8em,
  dx: -3em,
  align(center)[Is there a difference? \ Do we lose something? \ #pause *How would you test this?*],
)

== Breaking the fourth wall <touying:unoutlined>

#let check_code = ```python
def check(self, model):
        for i in range(100):
            pos = np.random.randint(-1000, 1000, self.dim)
            move = np.random.randint(-1000, 1000, self.dim)
            pos_prime = nparr_to_tuple(pos + move)
            pos_model = model(nparr_to_tuple(pos), nparr_to_tuple(move))
            if pos_prime != pos_model:
                return False
        return True
```

#speaker-note[
  + Can you see any problems with this?
]
#align(center + horizon)[

  #alternatives[
    #check_code
  ][
    #show raw.line: it => {
      if it.number in (2, 3, 4) {
        it
      } else {
        text(fill: luma(170), it.text)
      }
    }
    #check_code
  ]
]

== Is there a difference? YES! <touying:unoutlined>
#v(1em)

#speaker-note[
  + function behaves like a black box
  + makes it very hard to test if it behaves correctly
]

#align(center)[
  ```python
  def model(position, movement):
    return tuple(p + m for (p,m) in zip(position, movement))
  ```

  #v(2em)

  ```python
  def model(position, movement):
    if position[0] > 1000: return position
    else: return tuple(p + m for (p,m) in zip(position, movement))
  ```
]

#pause
#v(1em)

#align(center)[ *INDISTINGUISHABLE!* (to our stupid test) ]

#speaker-note[
  + Can we fix our test? Extend range, increase number of tests... but no!
]

== What do we want? <touying:unoutlined>
#slide(repeat: 8, self => [
  #let normal_text = "initial position, movement, and final position"
  #let mod_text = if self.subslide < 8 [
    #normal_text
  ] else [
    #strike(normal_text) *variables*
  ]

  + some way (a programming language???) to express relationships between #mod_text
  #pause
  + some way to check the relationship is correct
    #pause
    $
      arrow(x)' & = arrow(x) + Delta arrow(x)                        &      checkmark.heavy \
      arrow(x)' & = 3 dot arrow(x) + Delta arrow(x) - 2 dot arrow(x) & "   "checkmark.heavy \
      arrow(x)' & = cases(
                    arrow(x) + Delta arrow(x) & " , if" x_0 < 1000,
                    arrow(x) & " , else"
                  )                                                  &      crossmark.heavy \
    $
    #pause
    (and ideally don't try _every_ possible position)
    #pause
  + "solving" models for position/movement would be nice too
  #{
    set math.cases(reverse: true)
    $
      cases(
        x' & = x + Delta x,
        x' & = 10\, Delta x = 1
      ) => x = 9
    $
  }

  #pause

  #only("6")[
    #place(
      top + left,
      dx: 60pt,
      dy: 150pt,
      rotate(-15deg, text(size: 5em)[*THINK BIG*]),
    )
  ]

  #only("8")[
    #place(
      top + right,
      dx: -20pt,
      dy: 250pt,
      rotate(-15deg, align(center)[*check if the model \ is _satisfiable_*]),
    )
  ]
])
