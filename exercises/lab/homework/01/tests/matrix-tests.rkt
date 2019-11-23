#lang racket

(require quickcheck
         rackunit
         rackunit/quickcheck)

(require (prefix-in solutions. "../solutions/matrix.rkt"))

(define (id x) x)

; didn't find an easier way to check if member returns true
; cAnNoT bE CoErCeD To A GeNeRator
(define (elem x xs)
  (not (null? (member x xs))))

(define min-size 0)
(define max-size 100000)

(define integer-gen (choose-integer min-size max-size))

(define my-arbitrary-integer
  (arbitrary integer-gen (lambda (x y) y)))

(define arbitrary-integer-fn
  (arbitrary-procedure my-arbitrary-integer
                       my-arbitrary-integer))

; matrix generation
(define (gen-matrix gen)
  (sized (lambda (n)
           (sized (lambda (m)
                    (choose-list (choose-list gen (+ m 1)) (+ 1 n)))))))

(define (gen-sq-matrix gen)
  (sized (lambda (n)
           (choose-list (choose-list gen (+ n 1)) (+ 1 n)))))

(define num-matrix
  (gen-matrix
    integer-gen))

(define sq-num-matrix
  (gen-sq-matrix
    integer-gen))

(define xno-matrix
  (gen-matrix
    (choose-one-of
      '("X" "O" #f))))

(define (model-test ex re . args)
  (equal? (apply ex args) (apply re args)))

;01. all?
(define all?-same-as-andmap
  (property ((p? (arbitrary-procedure arbitrary-boolean arbitrary-integer))
             (xs (arbitrary-list arbitrary-integer)))
    (model-test andmap solutions.all? p? xs)))

(test-case
  "MODEL TEST: all? behaves like andmap"
  (check-property all?-same-as-andmap))

;02. any?
(define any?-same-as-ormap
  (property ((p? (arbitrary-procedure arbitrary-boolean arbitrary-integer))
             (xs (arbitrary-list arbitrary-integer)))
    (model-test ormap solutions.any? p? xs)))

(test-case
  "MODEL TEST: any? behaves like andmap"
  (check-property any?-same-as-ormap))

;03. concat
(define concat-same-as-flatten
  (property ((xss (arbitrary-list (arbitrary-list arbitrary-integer))))
    (equal? (flatten xss) (solutions.concat xss))))

(test-case
  "MODEL TEST: concat behaves like flatten on lists of lists"
  (check-property concat-same-as-flatten))

;04. rows
(define rows-same-as-id
  (property ((xss num-matrix))
    (model-test id solutions.rows xss)))

(test-case
  "MODEL TEST: rows behaves like id on matrices"
  (check-property rows-same-as-id))

;05. cols
(define cols-twice-is-id
  (property ((xss num-matrix))
    (equal? xss (solutions.cols (solutions.cols xss)))))

(define cols-same-elems
  (property ((xss num-matrix))
    (let ((flattened (flatten xss)))
      (andmap (lambda (x) (elem x flattened))
              (flatten (solutions.cols xss))))))

(test-case
  "PROPERTY: cols applied twice is id"
  (check-property cols-twice-is-id))

(test-case
  "PROPERTY: cols doesn't change the elements"
  (check-property cols-same-elems))

(test-case
  "UNIT TESTS: cols actually transposes"
  (test-begin
    (check-equal? (solutions.cols '((1 2 3) (4 5 6) (7 8 9)))
                  '((1 4 7) (2 5 8) (3 6 9)))
    (check-equal? (solutions.cols '((1 2) (4 5) (7 8)))
                  '((1 4 7) (2 5 8)))))

;06. matrix-ref
(define matrix-ref-always-returns-an-element-from-the-matrix
  (property ((xss num-matrix)
             (i (choose-integer 0 max-size))
             (j (choose-integer 0 max-size)))
    (let ((i0 (remainder i (length xss)))
          (j0 (remainder j (length (car xss)))))
      (elem (solutions.matrix-ref xss i0 j0) (flatten xss)))))

(test-case
  "PROPERTY: matrix-ref always returns an element from the matrix"
  (check-property matrix-ref-always-returns-an-element-from-the-matrix))

(test-case
  "UNIT TESTS: matrix-ref"
  (test-begin
    (check-equal? (solutions.matrix-ref '((1 2 3) (4 5 6)) 1 2)
                  6)
    (check-equal? (solutions.matrix-ref '((1 2) (4 5) (7 8)) 2 0)
                  7)))

;07. set
(define list-ref-after-set-retrieves-the-set-element
  (property ((xs (arbitrary-list arbitrary-integer))
             (x  arbitrary-integer))
    (==> (not (= (length xs) 0))
         (property ((n (choose-integer 0 (- (length xs) 1))))
           (equal? x
                   (list-ref (solutions.set xs n x) n))))))

(test-case
  "PROPERTY: list-refing an element that was just set returns the same element"
  (check-property list-ref-after-set-retrieves-the-set-element))

;08. place
(define matrix-ref-after-place-retrieves-the-placed-element
  (property ((xss num-matrix)
             (x arbitrary-integer))
    (property ((i (choose-integer 0 (- (length xss) 1)))
               (j (choose-integer 0 (- (length (car xss)) 1))))
      (equal? x
              (solutions.matrix-ref (solutions.place xss i j x) i j)))))

(test-case
  "PROPERTY: matrix-refing an element that was just placed returns the same element"
  (check-property matrix-ref-after-place-retrieves-the-placed-element))

;09. diag
(define diag-same-elems
  (property ((xss num-matrix))
    (let ((flattened (flatten xss)))
      (andmap (lambda (x) (elem x flattened))
              (solutions.diag xss)))))

(define transpose-preserves-diag
  (property ((xss sq-num-matrix))
    (equal? (solutions.diag xss) (solutions.diag (solutions.cols xss)))))

(test-case
  "PROPERTY: all elements from diag are in the matrix"
  (check-property diag-same-elems))

(test-case
  "PROPERTY: transposition preserves the diagonal"
  (check-property transpose-preserves-diag))

(test-case
  "UNIT TESTS: diag"
  (test-begin
    (check-equal? (solutions.diag '((0)))
                  '(0))
    (check-equal? (solutions.diag '((1 2 3) (4 5 6) (7 8 9)))
                  '(1 5 9))
    (check-equal? (solutions.diag '((69 0) (-1 1337)))
                  '(69 1337))))

;10. diags
(define diags-same-elems
  (property ((xss num-matrix))
    (let ((flattened (flatten xss)))
      (andmap (lambda (d) (andmap (lambda (x) (elem x flattened)) d))
              (solutions.diags xss)))))

(test-case
  "PROPERTY: all elements from diags are in the matrix"
  (check-property diags-same-elems))

(test-case
  "UNIT TESTS: diags"
  (test-begin
    (check-equal? (solutions.diags '((0)))
                  '((0) (0)))
    (check-equal? (solutions.diags '((1 2 3) (4 5 6) (7 8 9)))
                  '((1 5 9) (3 5 7)))
    (check-equal? (solutions.diags '((69 0) (-1 1337)))
                  '((69 1337) (0 -1)))))

;;11. map-matrix
(define map-after-flatten-is-the-same-as-map-matrix
  (property ((xss num-matrix)
             (f arbitrary-integer-fn))
    (equal? (map f (flatten xss))
            (flatten (solutions.map-matrix f xss)))))

(test-case
  "PROPERTY: for all f and xs: (map f (flatten xss)) == (flatten (map-matrix f xss))"
  (check-property map-after-flatten-is-the-same-as-map-matrix))

;12. filter-matrix
(define filter-after-flatten-is-the-same-as-filter-matrix
  (property ((xss num-matrix)
             (p? (arbitrary-procedure
                   arbitrary-boolean
                   my-arbitrary-integer)))
    (equal? (filter p? (flatten xss))
            (flatten (solutions.filter-matrix p? xss)))))

(define the-remaining-elements-all-satisfy-the-predicate
  (property ((xss num-matrix)
             (p? (arbitrary-procedure
                   arbitrary-boolean
                   my-arbitrary-integer)))
    (andmap p? (flatten (solutions.filter-matrix p? xss)))))

(define the-remaining-elements-are-originally-from-the-matrix
  (property ((xss num-matrix)
             (p? (arbitrary-procedure
                   arbitrary-boolean
                   my-arbitrary-integer)))
    (let ((flattened (flatten xss)))
      (andmap (lambda (x) (elem x flattened))
              (flatten (solutions.filter-matrix p? xss))))))

(define filtering-twice-is-the-same-as-once
  (property ((xss num-matrix)
             (p? (arbitrary-procedure
                   arbitrary-boolean
                   my-arbitrary-integer)))
    (equal? (solutions.filter-matrix p? xss)
            (solutions.filter-matrix p? (solutions.filter-matrix p? xss)))))

(test-case
  "PROPERTY: for all p? and xs: (filter p? (flatten xss)) == (flatten (filter-matrix p? xss))"
  (check-property filter-after-flatten-is-the-same-as-filter-matrix))

(test-case
  "PROPERTY: after filtering all the remaining elements satisfy the predicate used for filtering"
  (check-property the-remaining-elements-all-satisfy-the-predicate))

(test-case
  "PROPERTY: after filtering all the remaining elements were originally in the matrix"
  (check-property the-remaining-elements-are-originally-from-the-matrix))

(test-case
  "PROPERTY: filtering twice is the same as filtering once"
  (check-property filtering-twice-is-the-same-as-once))

;13. zip-with
(define zip-with-same-as-map
  (property ((xs (arbitrary-list arbitrary-integer))
             (ys (arbitrary-list arbitrary-integer)))
    (and (model-test solutions.zip-with map cons xs xs)
         (model-test solutions.zip-with map + xs xs)
         (model-test solutions.zip-with map * xs xs))))

(test-case
  "MODEL TEST: zip-with behaves like map"
  (check-property zip-with-same-as-map))

;14. zip-with-matrix
(define concat-zip-matrix-same-as-zip-concat
  (property ((xss num-matrix)
             (yss num-matrix))
    (equal? (solutions.concat (solutions.zip-matrix xss yss))
            (map cons (solutions.concat xss) (solutions.concat yss)))))

(test-case
  "PROPERTY: zip-matrixing and then concat-ing is the same as concat-ing and then zipping"
  (check-property concat-zip-matrix-same-as-zip-concat))
