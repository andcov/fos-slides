#import "@preview/touying:0.7.4": *
#import "@preview/numbly:0.1.0": numbly
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/cades:0.3.1": qr-code
#import themes.dewdrop: *


#show: dewdrop-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  navigation: "mini-slides",
  mini-slides: (height: 2em, x: 3em, display-section: false, display-subsection: false, short-heading: true),
  config-info(
    title: [Foundations of Science:\
      Modelling the world through experiments],

    author: [Leo Hector & Andrei Covaci],
  ),
  // config-common(show-notes-on-second-screen: right)
)

#set heading(numbering: numbly("{1}.", default: "1.1"))

#title-slide()

= Foundations of Science
#include "1_fos_game.typ"

= Writing a model
#include "2_writing_models.typ"
