(load "./count.scm")
(load "../02/reverse-digits.scm")

(define (count-palindromes a b)
  (define (palindrome? n)
    (= n (reverse-digits n)))

  (count palindrome? a b))

(load "../testing/check.scm")

(check (count-palindromes 1 5) => 5)
(check (count-palindromes 0 10) => 10)
(check (count-palindromes 11 100) => 9)
(check (count-palindromes 101 1000) => 90)

(check-report)
(check-reset!)
