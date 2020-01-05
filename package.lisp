;;;; package.lisp
(cl:in-package cl-user)


(defpackage "https://github.com/g000001/srfi-1"
  (:use)
  (:export
   xcons tree-copy make-list list-tabulate cons* list-copy proper-list?
   circular-list? dotted-list? not-pair? null-list? list=
   circular-list length+ iota first second third fourth fifth sixth
   seventh eighth ninth tenth car+cdr take drop take-right
   drop-right take! drop-right! split-at split-at! last last-pair
   zip unzip1 unzip2 unzip3 unzip4 unzip5 count append!
   append-reverse append-reverse! concatenate concatenate!
   unfold fold pair-fold reduce unfold-right fold-right pair-fold-right
   reduce-right append-map append-map! map! pair-for-each filter-map
   map-in-order filter partition remove filter! partition! remove!
   find find-tail any every list-index take-while drop-while take-while!
   span break span! break! delete delete! member alist-cons
   alist-copy delete-duplicates delete-duplicates! assoc alist-delete
   alist-delete! reverse! lset<= lset= lset-adjoin lset-union
   lset-intersection lset-difference lset-xor lset-diff+intersection
   lset-union! lset-intersection! lset-difference! lset-xor!
   lset-diff+intersection!))


(defpackage "https://github.com/g000001/srfi-1#internals"
  (:use cl)
  (:shadow let map loop)
  (:shadowing-import-from "https://github.com/g000001/srfi-1"
                          assoc
                          break
                          concatenate
                          count
                          delete
                          delete-duplicates
                          eighth
                          every
                          fifth
                          find
                          first
                          fourth
                          last
                          make-list
                          member
                          ninth
                          reduce
                          remove
                          second
                          seventh
                          sixth
                          tenth
                          third))


;; *EOF*
