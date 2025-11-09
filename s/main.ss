(import (scheme))

(scheme-program
  (lambda (fn . fns)
    (command-line (cons fn fns))
    (command-line-arguments fns)
    (main)))

(define (main)
  (display "urmom")
  (newline))
