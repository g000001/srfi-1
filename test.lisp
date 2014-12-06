(in-package :srfi-1-internal)

(5am:test circular-list
  (5am:is (equal (let ((cl (srfi-1circular-list 1 2 3)))
               (map #'list cl '(1 2 3 4 5)))
             '((1 1) (2 2) (3 3) (1 4) (2 5)) )))

(5am:test last-pair
  (5am:is (equal (srfi-1:last-pair '(1 2 3 4))
                 '(4))))
