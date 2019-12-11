(load "./stream.scm")

(define (integers-from n)
  (cons-stream n (integers-from (+ n 1))))

(define (take-stream n s)
  (if (or (= n 0)
          (empty-stream? s))
      empty-stream
      (cons-stream (head s)
            (take-stream (- n 1) (tail s)))))

(define (range-stream from to)
  (take-stream (+ to (- from) 1)
               (integers-from from)))

(define (map-stream f s)
  (if (empty-stream? s)
      empty-stream
      (cons-stream (f (head s))
                   (map-stream f (tail s)))))

(define (filter-stream p s)
  (cond ((empty-stream? s) empty-stream)
        ((p (head s)) (cons-stream (head s)
                                   (filter-stream p (tail s))))
        (else (filter-stream p (tail s)))))

(define (append-stream s1 s2)
  (if (empty-stream? s1)
      s2
      (cons-stream (head s1)
                   (append-stream (tail s1) s2))))

(define (concat-streams ss)
  (cond ((empty-stream? ss) empty-stream)
        ((empty-stream? (head ss)) (concat-streams (tail ss)))
        (else (cons-stream (head (head ss))
                           (append-stream (tail (head ss))
                                          (concat-streams (tail ss)))))))

(define (flatmap-stream f s)
  (concat-streams (map-stream f s)))

(define triples
  (flatmap-stream (lambda (c)
                    (flatmap-stream (lambda (b)
                                      (map-stream (lambda (a)
                                                    (list a b c))
                                                  (range-stream 1 b)))
                                    (range-stream 1 c)))
                  (integers-from 1)))

(define (square x)
  (* x x))

(define pythagorean-triples
  (filter-stream (lambda (triple)
                   (= (+ (square (car triple))
                         (square (cadr triple)))
                      (square (caddr triple))))
                 triples))

(load "../testing/check.scm")

(check (stream->list (take-stream 5 pythagorean-triples))
       => '((3 4 5) (6 8 10) (5 12 13) (9 12 15) (8 15 17)))

(check-report)
(check-reset!)
