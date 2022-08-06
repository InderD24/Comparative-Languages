#lang racket

;1
(define (make-rational . args)
 (cond
    [(= (length args) 2) (list 'rational (list-ref args 0) (list-ref args 1))]
    [(=  (length args) 1) (list 'rational (list-ref args 0) 1)]))

(make-rational 5 )

;2
(define (r-numerator x)
  (list-ref x 1))

(r-numerator (make-rational 1 2))

;3
(define (r-denominator x)
  (list-ref x 2))

(r-denominator (make-rational 1 2))

;4
(define (num-denom x)
  (list (list-ref x 1) (list-ref x 2)))

(num-denom(make-rational 1 2))

;5
(define (to-string x)
  (string-append  (~s (list-ref x 1)) "/" (~s (list-ref x 2))))

(to-string (make-rational 1 2))

;6
(define (to-float x)
  (define num (exact->inexact (list-ref x 1)))
  (define denom (exact->inexact (list-ref x 2)))
  (/ num denom))

(to-float (make-rational 1 3))

;7
(define (r= x y)
  (define x1 (to-float x))
  (define y1 (to-float y))
  (= x1 y1))

(r= (make-rational 1 4)(make-rational 3 9))

;8
(define (r< x y)
  (define x1 (to-float x))
  (define y1 (to-float y))
  (< x1 y1))

(r< (make-rational 1 10)(make-rational 3 9))

;9
(define(is-int? x)
  (define res(modulo(list-ref x 1)(list-ref x 2)))
  (and (= res 0)))
(is-int? (make-rational 12 4))

;10

(define (r+ x y)
  (define numer(* (list-ref x 1)(list-ref y 2)))
  (define denom(* (list-ref x 2)(list-ref y 2)))
  (define a(* (list-ref x 2)(list-ref y 1)))
  (define b(+ a numer))
  (make-rational b denom))

(r+ (make-rational 1 2)(make-rational 1 2))

;11
(define (r* x y)
  (define top(* (list-ref x 1)(list-ref y 1)))
  (define bottom (* (list-ref x 2)(list-ref y 2)))
  (make-rational top bottom))

(r* (make-rational 1 2)(make-rational 1 2))

;12
(define (r/ x y)
  (define top(* (list-ref x 1)(list-ref y 2)))
  (define bottom(* (list-ref x 2)(list-ref y 1)))
  (make-rational top bottom))

  (r/ (make-rational 4 6)(make-rational 3 5))

;13
(define (invert x)
  (define top(list-ref x 2))
  (define bottom(list-ref x 1))
  (make-rational top bottom))

  (invert (make-rational 12 4))

;14
(define (to-lowest-terms x)
  (define xtra (gcd(list-ref x 1)(list-ref x 2)))
  (define top(list-ref x 1))
  (define new-top(/ top xtra))
  (define bottom(list-ref x 2))
  (define new-bottom(/ bottom xtra))
  (make-rational new-top new-bottom))

(to-lowest-terms (make-rational 4 6 ))
 

;15
(define (harmonic-sum x)
  (if (<= x 1)
      (make-rational 1)
      (r+ (make-rational 1 x)(harmonic-sum (- x 1)))))

(harmonic-sum 2)

(println "PART 2 IS NEXT")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;P2;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;making array of n
(define (create-number-list n)
  (if (<= n 0)
      '()
      (cons (random 1 100) (create-number-list (- n 1)))))

;(create-number-list 10)

;making string array of n
(define (create-string-list n)
  (if (<= n 0)
      '()
      (cons (~s (random 1 100)) (create-string-list (- n 1)))))

;(create-string-list 10)

;making rational array of n
(define (create-rational-list n)
  (if (<= n 0)
      '()
      (cons (make-rational (random 0 100) (random 1 100)) (create-rational-list (- n 1)))))

;(create-rational-list 10)


;InsertionSort
(define (insertionSort l)
  (define (insert x zs)
    (match zs
      [(list) (list x)]
      [(cons z rst) (cond
                      [(number? x) (cond [(< x z) (cons x zs)]
                                          [else (cons z (insert x rst))])]

                       [(string? x) (cond [(< (string->number x) (string->number z)) (cons x zs)]
                                          [else (cons z (insert x rst))])]

                       [(list? x) (cond [(r< x z) (cons x zs)]
                                          [else (cons z (insert x rst))])])]))

                     
(foldl insert '() l))

(insertionSort(create-number-list 10))
(insertionSort(create-string-list 10))
(insertionSort(create-rational-list 10))

 
;running experiment for numbers
(define (simulation-numbers size trials)
 (cond
   [(= trials 0) 0]
   [else
    (+ (* 1000 (cadr (call-with-values (thunk (time-apply  (lambda () (insertionSort (create-number-list size))) '())) list)))
      (simulation-numbers size (sub1 trials)))]))

;running experiment for strings
(define (simulation-strings size trials)
  (cond
    [(= trials 0) 0]
    [else
     (+ (* 1000 (cadr (call-with-values (thunk (time-apply  (lambda () (insertionSort (create-string-list size))) '())) list)))
        (simulation-strings size (sub1 trials)))]))

;running experiment for rationals
(define (simulation-rationals size trials)
  (cond
    [(= trials 0) 0]
    [else
     (+ (* 1000 (cadr (call-with-values (thunk (time-apply  (lambda () (insertionSort (create-rational-list size))) '())) list)))
        (simulation-rationals size (sub1 trials)))]))

;dividing by 10 for average of 10 trials
(define (avg-time c_time trials)
  (/ c_time trials))

(println "testing size 1000 for 10 trials for numbers/strings/rationals in microseconds")
(avg-time (simulation-numbers 1000 10) 10)
(avg-time (simulation-strings 1000 10) 10)
(avg-time (simulation-rationals 1000 10) 10)

(println "testing size 2000 for 10 trials for numbers/strings/rationals in microseconds")
(avg-time (simulation-numbers 2000 10) 10)
(avg-time (simulation-strings 2000 10) 10)
(avg-time (simulation-rationals 1000 10) 10)

(println "testing size 3000 for 10 trials for numbers/strings/rationals in microseconds")
(avg-time (simulation-numbers 3000 10) 10)
(avg-time (simulation-strings 3000 10) 10)
(avg-time (simulation-rationals 3000 10) 10)

(println "testing size 4000 for 10 trials for numbers/strings/rationals in microseconds")
(avg-time (simulation-numbers 4000 10) 10)
(avg-time (simulation-strings 4000 10) 10)
(avg-time (simulation-rationals 4000 10) 10)

(println "testing size 5000 for 10 trials for numbers/strings/rationals in microseconds0")
(avg-time (simulation-numbers 5000 10) 10)
(avg-time (simulation-strings 5000 10) 10)
(avg-time (simulation-rationals 5000 10) 10)

(println "testing size 6000 for 10 trials for numbers/strings/rationals in microseconds")
(avg-time (simulation-numbers 6000 10) 10)
(avg-time (simulation-strings 6000 10) 10)
(avg-time (simulation-rationals 6000 10) 10)

(println "testing size 7000 for 10 trials numbers/strings/rationals in microseconds")
(avg-time (simulation-numbers 7000 10) 10)
(avg-time (simulation-strings 7000 10) 10)
(avg-time (simulation-rationals 7000 10) 10)

(println "testing size 8000 for 10 trials for numbers/strings/rationals in microseconds")
(avg-time (simulation-numbers 8000 10) 10)
(avg-time (simulation-strings 8000 10) 10)
(avg-time (simulation-rationals 8000 10) 10)

(println "testing size 9000 for 10 trials for numbers/strings/rationals in microseconds")
(avg-time (simulation-numbers 9000 10) 10)
(avg-time (simulation-strings 9000 10) 10)
(avg-time (simulation-rationals 9000 10) 10)

(println "testing size 10000 for 10 trials for numbers/strings/rationals in microseconds")
(avg-time (simulation-numbers 10000 10) 10)
(avg-time (simulation-strings 10000 10) 10)
(avg-time (simulation-rationals 10000 10) 10)
