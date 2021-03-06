(cl:in-package "https://github.com/g000001/srfi-1#internals")

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
    (symbol `(progn
               (declaim (ftype function ,name&args))
               (setf (symbol-function ',name&args) (progn ,@body))))))

(defun f- (x y)
  (- x y))

(defun f+ (x y)
  (+ x y))

#-sbcl
(define-compiler-macro f- (x y)
  `(the fixnum (- (the fixnum ,x) (the fixnum ,y))))

#+sbcl
(define-compiler-macro f- (x y)
  `(sb-ext:truly-the fixnum
                     (- (sb-ext:truly-the fixnum ,x)
                        (sb-ext:truly-the fixnum ,y))))


#-sbcl
(define-compiler-macro f+ (x y)
  `(the fixnum (+ (the fixnum ,x) (the fixnum ,y))))

#+sbcl
(define-compiler-macro f+ (x y)
  `(sb-ext:truly-the fixnum
                     (+ (sb-ext:truly-the fixnum ,x)
                        (sb-ext:truly-the fixnum ,y))))
