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
  (labels ((levenshtein-distance-aux (str-a i str-b j)
             (if (= 0 (min i j))
                 (max i j)
                 (min (1+ (levenshtein-distance-aux str-a (1- i) str-b     j))
                      (1+ (levenshtein-distance-aux str-a     i  str-b (1- j)))
                      (+  (levenshtein-distance-aux str-a (1- i) str-b (1- j))
                          (indicator-cost string-a i string-b j))))))
    (levenshtein-distance-aux string-a (length string-a) string-b (length string-b))))

(defun indicator-cost (string-a i string-b j)
  (let ((len-a (length string-a))
        (len-b (length string-b))
        (idx (1- i))
        (jdx (1- j)))
    (assert (and (< idx len-a) (< jdx len-b)))
  (if (char-equal (aref string-a idx) (aref string-b jdx))
      0
      1)))

(define-condition different-length-error (error)
  ())
