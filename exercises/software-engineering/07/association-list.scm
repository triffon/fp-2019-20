(define (make-alist f keys)
  (map (lambda (key)
         (cons key (f key)))
       keys))

(define (keys alist)
  (map car alist))
(define (values alist)
  (map cdr alist))
; (assoc key alist), (assv key alist), (assq key alist)

(define (del-assoc key alist)
  (filter (lambda (kv)
            (not (equal? (car kv) key)))
          alist))

(define (add-assoc key value alist)
  (cons (cons key value)
        (del-assoc key alist)))
