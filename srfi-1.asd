;;;; srfi-1.asd

(cl:in-package :asdf)

(defsystem :srfi-1
  :serial t
  :components ((:file "package")
               (:file "utils")
               (:file "srfi-1")
               (:file "test")))

(defmethod perform ((o test-op) (c (eql (find-system :srfi-1))))
  (load-system :srfi-1)
  (or (flet ((_ (pkg sym)
               (intern (symbol-name sym) (find-package pkg))))
         (let ((result (funcall (_ :fiveam :run) (_ :srfi-1-internal :srfi-1))))
           (funcall (_ :fiveam :explain!) result)
           (funcall (_ :fiveam :results-status) result)))
      (error "test-op failed") ))

