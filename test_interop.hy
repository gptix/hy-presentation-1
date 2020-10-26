;;; Hy can import Python modules and their functions
(import [math :as m])

(defn foo [x]
  (m.sin x))

;; This macro will expand later in hy code to assign a value.
(defmacro goo [x]
  `(do
     (setv hoo (m.sin ~x))
     hoo))

(goo 5) ; this will set hoo to (m.sin 5), and hoo
        ; will be available to Python that includes it.

(setv hoo2 hoo) ; this will save that value to hoo2,
                ; which will also be available from Python

;; This is a function that can be called from Python, and
;; when it runs, it will invoke the defmacro, which will return
;; the value given to hoo.
;; AFAICT, this will NOT update the value bound to hoo in
;; Python.
(defn moo [z]
  (goo z))
  

;;; One goal of mine is to remove boilerplate from code such as
;;; defining classes.

;; Simple example:
;; This macro will define a new function each time called with parameters.
;; backtick ` quasi-quotes a form
;; tilde ~ un-quotes a form, within a quasiquoted form
(defmacro newfun [fname multby]
  `(defn ~fname [x] ;; fname expands into the form passed
     (* ~multby x))) ;; multby will be expanded into the form (hopefully a num)

;; This will create a function named koo, callable from Python.
(newfun koo 2)

;; This will create a function named loo, callable from Python.
(newfun loo 10)



