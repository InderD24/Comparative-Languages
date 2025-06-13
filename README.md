# Comparative-Languages

This repository contains small programs written in a variety of programming
languages. Each file explores common programming tasks—such as rational number
manipulation or simple algorithms—in a different language.

## Contents

| File | Language | Description |
| --- | --- | --- |
| `RationalGolang.go` | Go | Implementation of a `Rational` type with arithmetic, sorting, and timing experiments. Running `go run RationalGolang.go` executes the demonstrations. |
| `RationalHaskell.hs` | Haskell | Defines `MyRational` along with insertion sort and utilities for generating random data. Intended to be run with `runhaskell`. |
| `RationalRuby.rb` | Ruby | Equivalent functionality in Ruby, including an insertion sort implementation and simple benchmarks. Run with `ruby RationalRuby.rb`. |
| `RationalRacket.rkt` | Racket | Racket variant showing rational arithmetic and sort timings. Execute with `racket RationalRacket.rkt`. |
| `PrologStuff.pl` | Prolog | Collection of predicate examples (fill, minmax, etc.) for SWI‑Prolog. |

## Running the examples

The Go and Ruby examples can be executed with the standard tooling available in
most environments:

```bash
# Go
go run RationalGolang.go

# Ruby
ruby RationalRuby.rb
```

The Haskell, Racket and Prolog programs rely on external interpreters or
compilers (`runhaskell`, `racket`, `swipl`). If those are installed, the files
can be run respectively with:

```bash
runhaskell RationalHaskell.hs   # requires GHC
racket RationalRacket.rkt       # requires Racket
swipl -q -s PrologStuff.pl      # requires SWI-Prolog
```

Each program prints demonstration output to the console and, for the insertion
sort implementations, measures approximate running times for several list sizes.
