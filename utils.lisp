(in-package :srfi-1-internal)

(defmacro defun-inline (name (&rest args) &body body)
  `(progn
     (declaim (inline ,name))
     (defun ,name (,@args)
       ,@body)))

(defun-inline map (function list &rest more-list)
  (apply #'mapcar function list more-list))

(defun-inline null? (obj) (null obj))

(defun-inline eq? (x y) (eq x y))

(defun-inline pair? (obj) (consp obj))

(defun-inline zero? (x) (zerop x))

(defun-inline set-car! (list obj)
  (rplaca list obj))

(defun-inline set-cdr! (cons x)
  (rplacd cons x))

(defun-inline equal? (x y)
  (equal x y))

(defun-inline memq (x list)
  (cl:member x list :test #'eq))

(defmacro begin (&body body)
  `(progn ,@body))

;; from sbcl
(defmacro named-let (name binds &body body)
  (dolist (x binds)
    (unless (= 2(length x))
      (error "malformed NAMED-LET variable spec: ~S" x)))
  `(labels ((,name ,(mapcar #'cl:first binds) ,@body))
     (,name ,@(mapcar #'cl:second binds))))

(defmacro let (&rest args)
  (etypecase (car args)
    (list `(cl:let ,@args))
    (symbol `(#+sbcl sb-int:named-let
              #-sbcl named-let
                     ,@args))))

(defmacro receive ((&rest args) vals &body body)
  `(multiple-value-bind (,@args) ,vals
     ,@body))

(defmacro define (name&args &body body)
  (etypecase name&args
    (list (destructuring-bind (name &rest args)
                              name&args
            `(defun ,name (,@args)
               ,@body)))
    (symbol `(setf (symbol-function ',name&args) (progn ,@body)))))
