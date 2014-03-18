;;;; package.lisp

(in-package :cl-user)

(defpackage #:edit-distance
  (:nicknames :edist)
  (:use #:cl))

(defpackage #:edit-distance-test
  (:use #:cl
        #:fiveam
        #:edit-distance))
