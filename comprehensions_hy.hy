#!/usr/bin/python -Wall

;###############################################################################;##
;#
;# Comprehensions
;#
;###############################################################################

;; Hy has four variants of `for` that act as comprehensions.
;; These are built-in.

;; lfor generates list comprehensions
;; dfor - dicts
;; sfor - sets
;; gfor - generators

;; import itertools - not required

;# list comprehensions example
;evens = [x for x in range(0, 11) if x % 2 == 0]
;print(evens)
(setv evens (lfor x (range 11) :if (zero? (% x 2)) x))
(print evens)

;;# example of dictionary comprehensions
;;ordinals = {(65+i):chr(65+i) for i in range(6)}
;;print(ordinals)
(setv ordinals (dfor x (range 6) [(+ 65 x)  (chr (+ 65 x))]))
(print ordinals)

;# example of set comprehensions
;;aset = {i for i in ['A', 'B', 'C', 'D', 'E', 'F', 'F', 'G']}
;;print(aset)
(setv aset (sfor i ["A" "B" "C" "D" "E" "F" "F" "G"] i))
(print aset)

;;# Generator comprehensions
;;#
;;# Generator comprehensions look like List comprehensions, but do not need square
;;# brackets around them (in some contexts though parentheses are required)
;;# Generator comprehensions lend

;;# example: reading in some data
;;f = open('demo-data.txt', 'r')
(setv f (open "demo-data.txt" "r"))

;;# the following does not evaluate, rather the syntax tells Python to create a
;;# generator based on the comprehension expression that follows, which in this case
;;# just delays reading the file. The returned object is iterable and is lazily-evaluated.
;;data = (line for line in f)
(setv data (gfor x (count) :do (.append lines (.readline f)) x))


;;# you can now iterate through the collection
;;first_5_lines = [line for _, line in zip(range(5), data)]
(setv first_five_lines (list (take 5 data)))




