(import (scheme))

(define (init)
  ;; Load shared object files or something...
  #f)

(define (main)
  (display "urmom")
  (newline))

(scheme-program
  (lambda (fn . fns)
    (command-line (cons fn fns))
    (command-line-arguments fns)
    (init)
    (main)))
