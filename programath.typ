// Basic configuration
#set page(
  paper: "a4",
)

#set text(font: "cmu serif")
#set par(justify: true)

#import "@preview/physica:0.9.3": *
// #import "@preview/zebraw:0.6.3": *
// #show: body => zebraw(body, numbering: none)

// Math shortcuts
#let im = math.op("Im")
#let re = math.op("Re")
#let img = math.op("Img")

#let R = $RR$
#let C = $CC$
#let N = $NN$
#let Z = $ZZ$
#let Q = $QQ$

#let cotan = math.op("cotan")
#let Aff = math.op("Aff")
#let sh = math.op("sh")
#let ch = math.op("ch")
#let th = math.op("th")
#let id = math.op("id")

#let vect(x) = $overrightarrow(#x)$
#let point(x, y) = $("(" #x ";" #y ")")$

#let converges(a, b) = $xrightarrow(#a "→" #b)$
#let convergedby(a, b) = $xleftarrow(#a "→" #b)$

// Helper for side-by-side comparisons
#let comparison(code, maths) = table(
  columns: (1fr, 1fr),
  stroke: .5pt,
  inset: 8pt,
  [#code], [#maths],
)

#show heading.where(level: 1): set text(size: 1.4em)

#align(center)[
  #v(6em)

  #text(size: 2.2em)[
    $
      "progra" cancel("mmation") "maths"
    $
  ]

  #v(1em)

  Rapprocher les deux

  #v(10em)

  #text(size: .8em)[
    https://gwen.works/programath
  ]
]

#pagebreak()

= `=` vs `==`

En maths, on note indifféremment le = de la *déclaration*
et le = de l’*hypothèse*.

- Ce que j'appelle le _= de la déclaration_,
  c'est celui qu'on utilise pour poser une variable :
  "Soit $a = 45$".

- Ce que j'appelle le _= de l'hypothèse_,
  c'est le = dont on n'est pas sûr,
  celui que l'on veut prouver ou réfuter :
  "Supposons $b = c + d$".

En programmation, ce que l'on dit est interprété par une machine,
qui ne peut pas déduire cette différence cruciale toute seule.

On est donc obligé de noter les "deux =" différemment :

#table(
  columns: (1fr, 1fr),
  stroke: .5pt,
  inset: 8pt,

  [*Python*], [*Math*],

  ```python
  a = 45
  ```,
  [Soit $a = 45$],

  ```python
  a == 45
  ```,
  [$a = 45$],

  ```python
  P = a == 45
  ```,
  [Soit $P$ la propriété "$a = 45$"],

  ```python
  def P(n):
    return n == 2*n
  ```,
  [Soit $P(n) = (n = 2n)$],
)

Comme en programmation on pose (ie on déclare)
plus que l'on ne teste,
le "=" tout simple sert de "= de la déclaration".

#text(size: .8em)[
  D'ailleurs, les propriétés c'est comme les relations,
  c'est des fonctions à valeurs dans $BB$ mais shhhh…
]

= Syntaxe de base

+, $times$ et tout ça.

#table(
  columns: (1fr, 1fr),
  stroke: .5pt,
  inset: 8pt,

  ```python
  (1 + 2) * 3 - 4**6
  ```,
  $(1 + 2) * 3 - 4^6$,

  ```python
  a//b + a/b
  ```,
  $floor(a / b) + a / b$,

  ```python
  r = a%b
  ```,
  [
    Posons $r$ tel que
    $a = floor(a / b) b + r$
  ],

  ```python
  from math import sqrt
  sqrt(5)
  ```,
  $sqrt(5)$,
)

= Ensembles, intervalles

Attention, je parle dans cette partie des _ensembles_,
et pas des listes en Python.

Les ensembles ça existe aussi en Python,
et c'est très similaire aux ensembles en maths :

- Ça se note `{1, 2, 3}` (au lieu de `[1, 2, 3]`)
- Il n'y a aucun doublon dans l'ensemble
- Il n'y a pas de notion d'ordre des éléments

Bien sûr, tout s'adapte aux listes,
c'est juste qu'avec des ensembles
c'est plus simple pour faire des parallèles avec les maths.

#table(
  columns: (1fr, 1fr),
  stroke: .5pt,
  inset: 8pt,

  ```python
  range(a, b)
  ```,
  $[| a, b |]$,

  ```python
  len(A)
  ```,
  $\#A$,

  ```python
  { 2*a for a in A }
  ```,
  $ {2a, a in A} $,

  ```python
  { a for a in A if a**2 == a/2 }
  ```,
  $ {a in A, a^2 = a/2} $,

  ```python
  { f(a) for a in A if P(a) }
  ```,
  [
    $ {f(a), a in A, P(a)} $

    #(
      text(size: .8em)[
        (pas vraiment légal mais on l'a utilisé une fois)
      ]
    )
  ],
)

= Opérateurs sur les ensembles

#table(
  columns: (1fr, 1fr),
  stroke: .5pt,
  inset: 8pt,

  ```python
  A | B
  ```,
  $A union B$,

  ```python
  A & B
  ```,
  $A inter B$,

  ```python
  A ^ B
  ```,
  $A Delta B$,

  ```python
  A - B
  ```,
  $A \\ B$,

  ```python
  A < B <= C > D >= E
  ```,
  $A subset B subset.eq C supset D supset.eq E$,

  ```python
  b in B
  ```,
  $b in B$,

  ```python
  sum(A)
  ```,
  $sum A$,

  ```py
  prod(A)
  ```,
  $product A$,
)

= Fonctions

#table(
  columns: (1fr, 1fr),
  stroke: .5pt,
  inset: 8pt,

  ```python
  def f(x):
    return 2 * x**2 + 5
  ```,
  [Soit $f = x mapsto 2x^2 + 5$],

  ```python
  def f(x, y):
    return 2 * x**2 + 5/y
  ```,
  [
    Soit
    $f = (x, y) mapsto 2x^2 + 5/y$
  ],

  ```python
  def f(x: int, y: float) -> float:
    return 2 * x**2 + 5/y
  ```,
  [
    $
      f = cases(
        Z times R -> R,
        (x, y) mapsto 2x^2 + 5/y
      )
    $
  ],
)

= Variables liées et libres

Vous vous rappelez le truc chelou de la marmite,
et le fait qu'on n'a pas accès aux variables déclarées
dans des fonctions en dehors de celles-ci ?

Et bah y'a tout pareil en maths en fait.

```python

a = 5

def f(x, y):
  return a + x*y

```

Ici, en dehors de `f`,
impossible d'accéder à `x` ou `y`,
ils n'existent pas.

Par contre,
on peut accéder à `a` dans `f`,
ou en dehors bien sûr.

Et bah en maths aussi c'est pareil :

#box(
  inset: 12pt,
  stroke: .5pt,
  width: 100%,
)[
  Soit $a = 5$.

  Notons
  $f = (x, y) mapsto a + x y$.

  *Ainsi $x = 666$*
]

Dans la définition de $f$,
on utilise $a$ sans problème,
par contre dans la ligne d'après…

#align(center)[
  #text(size: 2em)[*WHAT‽*]

  #text(size: 1.4em)[
    Mais _qui_ est $x$ ?
  ]
]

Pas de raison que ce soit différent en programmation.

`x` et `y` sont des variables _liées_ par :

```py
def f(x, y):
```

de la même manière que $x$ et $y$
sont liées par :

$ (x, y) mapsto $
