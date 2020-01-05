;;;; srfi-1.asd

(cl:in-package :asdf)

(defsystem :srfi-1
  :name "SRFI 1: list"
  :description "List Library"
  :author "Olin Shivers"
  :maintainer "CHIBA Masaomi <chiba.masaomi@gmail.com>"
  :version "20200106"
  :serial t
  :depends-on (:fiveam)
  :components ((:file "package")
               (:file "utils")
               (:file "srfi-1")))

(defmethod perform :after ((o load-op) (c (eql (find-system :srfi-1))))
  (let ((name "https://github.com/g000001/srfi-1")
        (nickname :srfi-1))
    (if (and (find-package nickname)
             (not (eq (find-package nickname)
                      (find-package name))))
        (warn "~A: A package with name ~A already exists." name nickname)
        (rename-package name name `(,nickname)))))

(defsystem :srfi-1.test
  :name "srfi-1.test"
  :description "srfi-1.test"
  :author "CHIBA Masaomi <chiba.masaomi@gmail.com>"
  :maintainer "CHIBA Masaomi <chiba.masaomi@gmail.com>"
  :version "20200106"
  :serial t
  :depends-on (:srfi-1 :fiveam)
  :components ((:file "test")))

(defmethod perform ((o test-op) (c (eql (find-system :srfi-1.test))))
  (load-system :srfi-1)
  (or (flet ((_ (pkg sym)
               (intern (symbol-name sym) (find-package pkg))))
        (let ((result (funcall (_ :fiveam :run)
                               (_ "https://github.com/g000001/srfi-1#internals" :srfi-1))))
           (funcall (_ :fiveam :explain!) result)
           (funcall (_ :fiveam :results-status) result)))
      (error "test-op failed") ))
