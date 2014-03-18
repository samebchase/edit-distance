(in-package :edit-distance)

(defun hamming-distance (string-a string-b)
  (if (= (length string-a) (length string-b))
      (loop
         for a across string-a
         for b across string-b
         when (char-not-equal a b)
         count a)
      (error "Hamming distance is only defined on strings of the same length.")))

(defun levenshtein-distance (string-a string-b)
  0)
