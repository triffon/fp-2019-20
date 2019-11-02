(require rackunit rackunit/text-ui)

; Решение 1
(define (remove-duplicates l)
  (if (null? l)
      '()
      (cons (car l)
            (remove-duplicates (filter (lambda (x)
                                         (not (eq? x (car l))))
                                       (cdr l))))))

; Решение 2
(define (without x l)
  (filter (lambda (y)
            (not (eq? y x)))
          l))

(define (remove-duplicates l)
  (if (null? l)
      '()
      (cons (car l)
            (remove-duplicates (without (car l) (cdr l))))))

; Решение 3
(define (remove-duplicates l)
  (define (deduplicate remaining seen-once)
    (cond ((null? remaining) seen-once)
          ((member (car remaining) seen-once)
            (deduplicate (cdr remaining) seen-once))
          (else
            (deduplicate (cdr remaining)
                         (cons (car remaining) seen-once)))))
  (reverse (deduplicate l '())))

; Решение 4
; Забележете, че при foldl трябва да обърнем редът на получения списък.
; Ако ползвахме foldr, нямаше да има нужда от reverse,
; но тогава заради обхождането отдясно-наляво щяха да останат
; най-десните срещания на повтарящите се елементи.
(define (remove-duplicates l)
  (define (reduce-unique item already-seen)
    (if (member item already-seen)
        already-seen
        (cons item already-seen)))
  (reverse (foldl reduce-unique '() l)))

(define remove-duplicates-tests
  (test-suite
    "Tests for remove-duplicates"

    (check-equal? (remove-duplicates '(42)) '(42))
    (check-equal? (remove-duplicates '(6 6 6)) '(6))
    (check-equal? (remove-duplicates '(1 2 3 4 5 6)) '(1 2 3 4 5 6))
    (check-equal? (remove-duplicates '(4 3 3 2 5 2)) '(4 3 2 5))
    (check-equal? (remove-duplicates '(10 10 8 2 2 2 9 9)) '(10 8 2 9))))

(run-tests remove-duplicates-tests)
