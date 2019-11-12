(define (make-alist f keys)
  (map (lambda (k) (cons k (f k))) keys))

(define (keys al) (map car al))
(define (values al) (map cdr al))

(define al (make-alist (lambda (x) (* x x)) '(1 3 5)))

(define (del-assoc key al)
  (if (equal? key (caar al)) (cdr al)
      (cons (car al) (del-assoc key (cdr al)))))

(define (filter p? l)
  (cond ((null? l) l)
        ((p? (car l)) (cons (car l) (filter p? (cdr l))))
        (else (filter p? (cdr l)))))

(define (del-assoc key al)
  (filter (lambda (kv) (not (equal? (car kv) key))) al))

(define (add-assoc key value al)
  (cons (cons key value) (del-assoc key al)))

(define (search p l)
  (and (not (null? l))
       (or (p (car l)) (search p (cdr l)))))

(define (exists? p? l)
  (not (null? (filter p? l))))

(define (all? p? l)
  (not (search (lambda (x) (not (p? x))) l)))