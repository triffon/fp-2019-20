; Boolean constants
#t               ; #t
#f               ; #f

; Number constants
42               ; 42
-1               ; -1
3.14             ; 3.14
1/3              ; 1/3

; Character constants
#\a              ; #\a
#\newline        ; #\newline

; String constants
"Scheme is cool" ; "Scheme is cool"

; Symbols
+                ; #[arity-dispatched-procedure 1]
square           ; #[compiled-procedure 2 ("arith" #x114 #x3 #x36ffa])
odd?             ; #[compiled-procedure 3 ("arith" #x116 #x3 #x36fc4])

; Combinations
(+ 1 2)       ; 3
(- 1000 334)  ; 666
(* 2 3)       ; 6
(/ 10 5)      ; 2

; Arbitrary number of operands
(+ 1 2 3 4 5) ; 15
(* 25 4 12)   ; 1200

; Nested combinations
(+ (* 3 (+ (* 2 4) (+ 3 5))) (+ (- 10 7) 6)) ; 57

; Pretty-printing
(+ (* 3
      (+ (* 2 4)
         (+ 3 5)))
   (+ (- 10 7)
      6))

; "define" special form
(define pi 3.14159)                    ; pi
(define radius 100)                    ; radius
(* pi (* radius radius))               ; 31415.899999999998

(define circumference (* 2 pi radius)) ; circumference
circumference                          ; 628.318

; Defining procedures
(define (square x) (* x x))
(square 5)          ; 25
(square (+ 2 5))    ; 49
(square (square 3)) ; 81

(define (sum-of-squares x y)
  (+ (square x) (square y)))
(sum-of-squares 3 4) ; 25

; "cond" special form
(define (abs x)
  (cond ((< x 0) (- x))
        ((= x 0) 0)
        ((> x 0) x)))

(define (abs x)
  (cond ((< x 0) (- x))
        (else x)))

; "if" special form
(define (abs x)
  (if (< x 0)
      (- x)
      x))
