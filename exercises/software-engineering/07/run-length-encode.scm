(define (take-while p l)
  (if (or (null? l)
          (not (p (car l))))
      '()
      (cons (car l)
            (take-while p (cdr l)))))

(define (drop-while p l)
  (if (or (null? l)
          (not (p (car l))))
      l
      (drop-while p (cdr l))))

(define (run-length-encode l)
  (define (take-first-equals l)
    (take-while (lambda (x)
                  (= x (car l)))
                l))

  (define (drop-first-equals l)
    (drop-while (lambda (x)
                  (= x (car l)))
                l))

  (if (null? l)
      '()
      (cons (cons (car l)
                  (length (take-first-equals l)))
            (run-length-encode (drop-first-equals l)))))
