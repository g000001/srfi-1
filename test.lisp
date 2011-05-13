(in-package :srfi-1-internal)

(test circular-list
  (is (equal (let ((cl (circular-list 1 2 3)))
               (map #'list cl '(1 2 3 4 5)))
             '((1 1) (2 2) (3 3) (1 4) (2 5)) )))

(test last-pair
  (is (equal (last-pair '(1 2 3 4))
             '(4))))