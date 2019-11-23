(load "./binary-tree.scm")



(load "../testing/check.scm")

(define (square x) (* x x))
(define (cube x) (* x x x))

(define tree
  (make-tree 1
             (make-tree 2
                        (leaf 4)
                        (leaf 5))
             (leaf 3)))

(define squared-tree
  (make-tree 1
             (make-tree 4
                        (leaf 16)
                        (leaf 25))
             (leaf 9)))

(define cubed-tree
  (make-tree 1
             (make-tree 8
                        (leaf 64)
                        (leaf 125))
             (leaf 27)))

(check (map-tree square empty-tree) => empty-tree)
(check (map-tree square (leaf 4)) => (leaf 16))
(check (map-tree square tree) => squared-tree)
(check (map-tree cube tree) => cubed-tree)

(check-report)
(check-reset!)
