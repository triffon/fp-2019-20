(require rackunit rackunit/text-ui)

(define (accumulate combiner null-value term a next b)
  (define (iter acc a)
    (if (> a b)
        acc
        (iter (combiner (term a) acc) (next a))))

  (iter null-value a))

(define (count predicate a b)
  (accumulate + 0
              (lambda (x) (if (predicate x) 1 0))
              a (lambda (x) (+ x 1)) b))

(define (reverse-number n)
  (define (append-digit n d)
    (+ (* 10 n) d))

  (define (last-digit n)
    (remainder n 10))

  (define (cut-last-digit n)
    (quotient n 10))

  (define (iter acc n)
    (if (zero? n)
        acc
        (iter (append-digit acc (last-digit n)) (cut-last-digit n))))

  (iter 0 n))

(define (palindrome? n)
  (= (reverse-number n) n))

(define (count-palindromes a b)
  (count palindrome? a b))

(define count-palindromes-tests
  (test-suite
    "Tests for count-palindromes"

    (check = (count-palindromes 1 5) 5)
    (check = (count-palindromes 0 10) 10)
    (check = (count-palindromes 11 100) 9)
    (check = (count-palindromes 101 1000) 90)))

(run-tests count-palindromes-tests)
