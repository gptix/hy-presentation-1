;;#!/usr/bin/python -Wall


;;################################################################################
;;#
;;# Lambda Expressions, and closures
;;#
;;################################################################################


;;# example of a simple anonymous function in python


;;add2 = lambda x: x + 2
;;print(add2(2))

;; Hy is s Lisp-1, which means that anything 'f' in '(f x)' will be a
;; function 'f' applied to x.
((fn [x] (+ 2 x)) 3)
;; returns 5

(setv add2 (fn [x] (+ 2 x)))
(print (add2 2))
;; prints 4
 
;;#
;;# another way of generating functions with a function
;;# notice this will create a closure and bind the lambda around a which is
;;# scoped and bound in the outer function before the lambda is constructed.
;;#

;;def create_adder(a):
;;    return lambda b: a + b         
         

;;add4 = create_adder(4)
;;add3 = create_adder(3)

;;print(add4(4))
;;print(add3(4))


(defn adder [a]
  (fn [b] (+ a b)))

(setv add3 (adder 3))
(setv add4 (adder 4))

(print (add4 4)) ; prints 8
(print (add3 3)) ; prints 6
       
# another way of creating closures (without lambdas)


;;def create_adder_old_way(a):
;;    def adder(b):
;;        return a + b
;;    return adder

;;add5 = create_adder_old_way(5)

;;print(add5(6))

(defn create-adder-old-way [a]
  (defn adder [b]
    (+ a b))
  adder)

(setv add5 (create-adder-old-way 5))

(add5 6)


;;# example of function that creates functions


;;def create_greeter():
;;    """
;;    Example of creating a function that creates function with
;;    inner(scoped) function definitions
;;    """
;;    def greeter(x):
;;        print(x)
;;
;;    return greeter

;;a = create_greeter()
;;b = create_greeter()

;;a('a is called')
;;b('b is called')

(defn create-greeter []
  (defn greeter [x]
    (print x))
  greeter)

(setv a (create-greeter))
(setv b (create-greeter))

(a "Bob")
;; returns "Bob"

(b "Sue")
;; returns "Sue"


;;# Gotcha about closures - Python binds variables in closures by "name" not by "value"
;;# which causes the following code not to behave as intended
;;adders = []
;;for x in range(5):
;;    adders.append(lambda y: x + y)

;;alist = [adder(10) for adder in adders]
;;blist = [adder(20) for adder in adders]

;;# simple fix: use actual inner functions instead of anonymous functions

(setv adders [])

(for x [(range 5)]
  (.append adders (fn [y] (+ x y))))
  
(setv alist (lfor adr adders (adr 10)))
(setv blist (lfor adr adders (adr 20)))

;;# simple fix: use actual inner functions instead of anonymous functions

;;def make_adder(x):
;;    def add(y):
;;        return x + y
;;    return add

;;badders = []
;;for x in range(5):
;;    badders.append(make_adder(x))

;;alist = [adder(10) for adder in badders]
;;blist = [adder(20) for adder in badders]

(defn make-adder [x]
  (defn add [y]
    (+ x y))
  add)

(setv badders [])

(lfor [x (range 5)]
  (.append badders (make-adder x)))

(setv alist (lfor adder badders (adder 10)))
(setv blist (lfor adder badders (adder 20)))
