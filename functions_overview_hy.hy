;;# simple example of a function
;;def hello():
;;    '''
;;    just prints hello
;;    :return: nothing
;;    '''
;;    print("hello")

(defn hello []
  "Just proints hello
   :return: None"
  (print "hello"))


;;# Functions are just normal objects, and as such they can be inspected
;;type(hello)
(type hello)
;;funcs = dir(hello)
(setv funcs (dir hello))

;;# higher-order functions
;;fruits = ['fig', 'cherry', 'apple', 'blueberry']
;;sorted(fruits, key=len)

;;def firstletter(word):
;;    return word[0]

;;sorted(fruits, key=firstletter)

(defn firstletter [word]
  (get word 0))

(sorted fruits :key firstletter)

;;a = map(lambda x: 2*x, range(6))

;;type(a)
;;dir(a)

(setv a (map (fn [x] (* 2 x)) (range 6)))
(type a)
(dir a)

;;for x in a:
;;    print(x)

(for [x a]
  (print x))

;;# Lambda Expressions
;;# example of a simple anonymous function in python
;;add2 = lambda x: x + 2

(setv add2 (fn [x] (+ 2 x)))

;;print(add2(2))

(print (add2 2))
;;#
;;# another way of generating functions with a function
;;# notice this will create a closure and bind the lambda around a which is
;;# scoped and bound in the outer function before the lambda is constructed.
;;#
;;def create_adder(a):
;;  return lambda b: a + b

(defn create-adder [a]
  (fn [b] (+ a b)))


;;add4 = create_adder(4)
;;add3 = create_adder(3)

(setv add4 (create-adder 4))
(setv add3 (create-adder 3))

;;print(add4(4))
;;print(add3(4))

(print (add4 4))
(print (add3 3))

# old way of creating closures without lambdas
;;def create_adder_old_way(a):
;;    def adder(b):
;;        return a + b
;;   return adder

(defn create-adder-old-way [a]
  (defn adder [b] (+ a b))
  adder)

;;add5 = create_adder_old_way(5)

(setv add5 (create-adder-old-way 5))

;;print(add5(6))

(print (add5 6))

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

(defn create-greeter []
  "Example of creating a function that creates function with inner(scoped) function definitions"
  (defn greeter [x]
    (print x))
  greeter)

;;a = create_greeter()
;;b = create_greeter()

(setv a (create-greeter))
(setv b (create-greeter))


;;a('a is called')
;;b('b is called')

(a)
(b)

# Gotcha about closures - Python binds variables in closures by "name" not by "value"
# which causes the following code not to behave as intended
;;adders = []
;;for x in range(5):
;;    adders.append(lambda y: x + y)

;;alist = [adder(10) for adder in adders]
;;blist = [adder(20) for adder in adders]

;;def make_adder(x):
;;    return lambda y: x + y


(setv adders [])
(for [x (range 5)]
  (.append adders
           (fn [y] (x+y))))

(setv alist (lfor adr adders (adr 10)))
(setv blist (lfor adr adders (adr 20)))

(defn make-adder [x]
  (fn [y] (+ x y)))


# Exercise: implement the higher-order function map
