#lang racket
(require rackunit)
(require rackunit/text-ui)

; ### Задача 7
; Напишете функция `bin-to-dec`, която преобразува число от двоична в десетична бройна система.
; > Забележка: тук под бройна система разбираме просто използваните цифри в представянето на числото. Тоест няма създаваме двоични числа, започващи с [#b](http://people.csail.mit.edu/jaffer/r5rs/Syntax-of-numerical-constants.html). Що се касае до scheme, според него работим само с десетични числа.

(define (bin-to-dec n) void)

(run-tests (test-suite "count-digits tests"
                       (check-eq? (bin-to-dec 0) 0)
                       (check-eq? (bin-to-dec 1) 1)
                       (check-eq? (bin-to-dec 100) 4)
                       (check-eq? (bin-to-dec 1111) 15)
           'verbose)

