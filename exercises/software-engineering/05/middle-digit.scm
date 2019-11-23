(define (last-digit n)
  (remainder n 10))

(define (without-last-digit n)
  (quotient n 10))

(define (count-digits n)
  (if (< n 10)
      1
      (+ 1
         (count-digits (without-last-digit n)))))

(define (middle-digit n)
  (define (kth-digit-from-last k n)
    (if (= k 0)
        (last-digit n)
        (kth-digit-from-last (- k 1) (without-last-digit n))))

  (define digit-count (count-digits n))

  (if (even? digit-count)
      -1
      (kth-digit-from-last (quotient digit-count 2) n)))

; Друг начин за решаване на задачата:
; представяме числото чрез списък от цифрите му и
; използваме познатите ни процедури за работа със списъци.
(define (number->list n)
  (define (number->list-reversed n)
    (if (< n 10)
        (list n)
        (cons (last-digit n)
              (number->list-reversed (without-last-digit n)))))

  (reverse (number->list-reversed n)))

(define (middle-digit n)
  (define digits-list (number->list n))
  (define digits-count (length digits-list))

  (if (even? digits-count)
      -1
      (list-ref digits-list (quotient digits-count 2))))

(load "../testing/check.scm")

(check (middle-digit 0) => 0)
(check (middle-digit 1) => 1)
(check (middle-digit 42) => -1)
(check (middle-digit 452) => 5)
(check (middle-digit 4712) => -1)
(check (middle-digit 47124) => 1)
(check (middle-digit 1892364) => 2)
(check (middle-digit 38912734) => -1)

(check-report)
(check-reset!)
