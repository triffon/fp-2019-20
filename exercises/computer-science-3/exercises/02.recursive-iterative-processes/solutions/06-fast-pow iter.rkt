; тук конкретно нямаме нужда от две функции (една "бърза" и една обикновена).

;(define (pow x n)
;  (define (pow1 x n result)
;    (if (= n 0) result
;        (pow1 x (- n 1) (* x result))
;     )
;   )
;  (pow1 x n 1)
;  )
       
;(define (fast-pow x n)
;  (define (square y) (* y y))
;  (define (fast-pow2 x n result)
;    (cond
;      ((= n 0) result)
;      ((odd? n) (fast-pow2 x (- n 1) (* x result)))
;      (else (* result (square (pow x (quotient n 2)))))
;      )
;    )
;  (fast-pow2 x n 1)
; )

(define (fast-pow x n)
  (define (iter x n result)
    (cond
      ((= n 0) result)
      ((odd? n) (iter x (- n 1) (* result x)))
      (else (iter (* x x) (quotient n 2) result))))
  (iter x n 1))

(fast-pow 2 0)
(fast-pow 2 2)
(fast-pow 4 4)
(fast-pow 3 4)
(fast-pow 2 1)
(fast-pow 2 10)
(fast-pow 2 5)
(fast-pow 2 3)
(fast-pow 3 5)
        