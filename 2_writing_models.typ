#import "@preview/touying:0.7.4": *
#import "@preview/cades:0.3.1": qr-code
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

#pinit-point-from((1, 2), offset-dx: 5pt, offset-dy: 100pt, body-dx: -100pt)[#align(
  center,
)[_symbolic_ relation between \ output and input]]

#pause

#pinit-point-from((3, 4), pin-dy: 40pt, offset-dx: 5pt, offset-dy: 150pt, body-dx: -100pt)[#align(
  center,
)[which we _mimic_ using a \ function]]

#pause
#place(
  bottom + left,
  dy: -2em,
  dx: 1em,
  [*Is there a difference? \ $" "$ Do we lose something?*],
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
#align(center + horizon)[
  #speaker-note[
    + Can you see any problems with
  ]

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
