#lang racket
(require rackunit/text-ui)

(provide describe)

(define-syntax (describe stx)
  (syntax-case stx ()
    ((_ id l ...)
     (if (identifier-binding #'id) ; the identifier behind id is defined
         #'(and (run-tests
                  (test-suite
                    (string-append "Tests for "
                                   (symbol->string (syntax->datum #'id)))
                    l ...)
                  'verbose)
                (void))
         #'(display
             (string->symbol
               (string-append (symbol->string (syntax->datum #'id))
                              " is not defined\n")))))))
