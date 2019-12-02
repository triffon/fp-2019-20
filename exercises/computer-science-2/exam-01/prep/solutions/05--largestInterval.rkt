(define (foldr op nv l)
  (if (null? l)
      nv
      (op (car l) (foldr op nv (cdr l)))))

(define (from-to a b)
  (if (> a b)
      '()
      (cons a (from-to (+ a 1) b))))

(define (zip L M)
  (if (or (null? L) (null? M))
      '()
      (cons (cons (car L) (car M))
            (zip (cdr L) (cdr M)))))

(define (maximum-by max* l)
  (if (null? (cdr l))
      (car l)
      (max* (car l) (maximum-by max* (cdr l)))))

(define (largestInterval f g a b)
  (define (eq-for? x)
    (= (f x) (g x)))
  (let ((a-to-b (from-to a b))
        (eq-interval? (lambda (nm)
                        (and (eq-for? (car nm))
                             (eq-for? (cdr nm)))))
        (concat-head-interval (lambda (nm rec)
                                (if (and (not (null? rec))
                                         (= (cdr nm) (caar rec)))
                                    (cons (cons (car nm) (cdar rec))
                                          (cdr rec))
                                    (cons nm rec)))))
    (foldr concat-head-interval
           '()
           (filter eq-interval?
                   (zip a-to-b (cdr a-to-b))))))


