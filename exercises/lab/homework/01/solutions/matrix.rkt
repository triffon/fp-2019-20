#lang racket

(provide all?
         any?
         concat
         rows
         cols
         matrix-ref
         set
         place
         diag
         diags
         map-matrix
         filter-matrix
         zip-with
         zip-matrix)
; the provide "exports" these functions

; 00.
(define (all? p? xs) void)

; 01.
(define (any? p? xs) void)

; 02.
(define (concat xss) void)

; 03.
(define (rows xss) void)

; 04.
(define (cols xss) void)

; 05.
(define (matrix-ref xss i j) void)

; 06.
(define (set xs i x) void)

; 07.
(define (place xss i j x) void)

; 08.
(define (diag xss) void)

; 09.
(define (diags xss) void)

; 10.
(define (map-matrix f xss) void)

; 11.
(define (filter-matrix p? xss) void)

; 12.
(define (zip-with f xs ys) void)

; 13.
(define (zip-matrix xss yss) void)
