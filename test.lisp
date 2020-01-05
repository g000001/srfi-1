(in-package "https://github.com/g000001/srfi-1#internals")

(5am:def-suite srfi-1)

(5am:in-suite srfi-1)


(5am:test circular-list
  (5am:is (equal (let ((cl (circular-list 1 2 3)))
               (map #'list cl '(1 2 3 4 5)))
             '((1 1) (2 2) (3 3) (1 4) (2 5)) )))

(5am:test last-pair
  (5am:is (equal (last-pair '(1 2 3 4))
                 '(4))))
