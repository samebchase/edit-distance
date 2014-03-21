;;;; package.lisp

(in-package :cl-user)

(defpackage #:edit-distance
  (:nicknames :edist)
  (:use #:cl)
  (:export :hamming-distance
           :levenshtein-distance-rec
           :levenshtein-distance))

(defpackage #:edit-distance-test
  (:nicknames :edistest)
  (:use #:cl
        #:fiveam
        #:edit-distance))
