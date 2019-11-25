(load "./association-list.scm")

(define (count-occurrencies x l)
  (length (filter (lambda (y)
                    (equal? y x))
                  l)))

(define (histogram l)
  (if (null? l)
      '()
      (cons (cons (car l)
                  (count-occurrencies (car l) l))
            (histogram (filter (lambda (y)
                                 (not (equal? y (car l))))
                               l)))))

(define (unique l)
  (if (null? l)
      '()
      (cons (car l)
            (unique (filter (lambda (x)
                              (not (equal? x (car l))))
                            l)))))

; Друго решение: използваме make-alist конструктора
(define (histogram l)
  (make-alist (lambda (key)
                (count-occurrencies key l))
              (unique l)))
