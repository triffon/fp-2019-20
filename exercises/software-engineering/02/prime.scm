(load "./count-divisors.scm")

; Едно число е просто, ако има точно 2 делителя.
(define (prime? n)
  (= (count-divisors n) 2))

; Друг начин да дефинираме prime?: числото n е просто, ако не е 1 и няма нито
; един делител в интервала [2, n - 1].
(define (prime?-iter n)
  (define (iter k)
    (or (= k n)
        (and (not (divides? k n))
             (iter (+ k 1)))))

  (and (not (= n 1)) (iter 2)))

(load "../testing/check.scm")

(check (prime? 3) => #t)
(check (prime? 19) => #t)
(check (prime? 599) => #t)
(check (prime? 661) => #t)
(check (prime? 2221) => #t)
(check (prime? 7879) => #t)

(check (prime? 1) => #f)
(check (prime? 12) => #f)
(check (prime? 15) => #f)
(check (prime? 42) => #f)
(check (prime? 666) => #f)
(check (prime? 1337) => #f)
(check (prime? 65515) => #f)
(check (prime? 1234567) => #f)

(check (prime?-iter 3) => #t)
(check (prime?-iter 19) => #t)
(check (prime?-iter 599) => #t)
(check (prime?-iter 661) => #t)
(check (prime?-iter 2221) => #t)
(check (prime?-iter 7879) => #t)

(check (prime?-iter 1) => #f)
(check (prime?-iter 12) => #f)
(check (prime?-iter 15) => #f)
(check (prime?-iter 42) => #f)
(check (prime?-iter 666) => #f)
(check (prime?-iter 1337) => #f)
(check (prime?-iter 65515) => #f)
(check (prime?-iter 1234567) => #f)

(check-report)
(check-reset!)
