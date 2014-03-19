;;;; package.lisp

(in-package :cl-user)

(defpackage #:edit-distance
  (:nicknames :edist)
  (:use #:cl)
  (:export :hamming-distance
           :levenshtein-distance-rec))

(defpackage #:edit-distance-test
  (:use #:cl
        #:fiveam
        #:edit-distance))
