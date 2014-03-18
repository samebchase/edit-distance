;;;; edit-distance.asd

(defpackage :edit-distance-system
  (:use :cl :asdf))

(in-package :edit-distance-system)

(defsystem #:edit-distance
  :serial t
  :description "Edit distance algorithms"
  :author "Samuel Chase <samebchase@gmail.com>"
  :license "Unknown"
  :depends-on (#:fiveam
               #:optima
               #:alexandria)
  :components ((:file "package")
               (:file "edit-distance")
               (:file "test")))

