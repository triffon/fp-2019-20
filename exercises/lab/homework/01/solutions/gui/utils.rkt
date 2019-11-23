#lang racket
(provide succ
         id
         from-to
         fmap
         const
         v-fmap!)

(define (neg x)
  (if x #f #t))

(define (succ n) (+ n 1))
(define (id x) x)

(define (from-to a b)
  (if (> a b)
      '()
      (cons a (from-to (succ a) b))))

(define (fmap f xss)
  (map (lambda (xs) (map f xs)) xss))

(define (v-fmap! f xss)
  (vector-map (lambda (xs) (vector-map! f xs)) xss))

(define (const x)
  (lambda (y) x))
