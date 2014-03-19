(in-package :edit-distance)

(defun hamming-distance (string-a string-b)
  (if (= (length string-a) (length string-b))
      (loop
         for a across string-a
         for b across string-b
         when (char-not-equal a b)
         count a)
      (error 'different-length-error)))

(defun levenshtein-distance-rec (string-a string-b)
  (labels ((levenshtein-distance-aux (str-a length-a str-b length-b)
             (if (= 0 (min length-a length-b))
                 (max length-a length-b)
                 (min (1+ (levenshtein-distance-aux str-a (1- length-a) str-b     length-b))
                      (1+ (levenshtein-distance-aux str-a     length-a  str-b (1- length-b)))
                      (+  (levenshtein-distance-aux str-a (1- length-a) str-b (1- length-b))
                          (indicator-cost string-a length-a string-b length-b))))))
    (levenshtein-distance-aux string-a (length string-a) string-b (length string-b))))

(defun indicator-cost (string-a index-a string-b index-b)
  (let ((len-a (length string-a))
        (len-b (length string-b)))
  (assert (and (<= index-a len-a) (<= index-b len-b)))
  (if (char-equal (aref string-a (1- len-a)) (aref string-b (1- len-b)))
      0
      1)))

(define-condition different-length-error (error)
  ())
