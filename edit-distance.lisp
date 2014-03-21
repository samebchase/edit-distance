(in-package :edit-distance)

#|

Hamming distance:

Number of differing corresponding symbols in two strings of equal
length.

|#

(defun hamming-distance (string-a string-b)
  (if (= (length string-a) (length string-b))
      (loop
         for a across string-a
         for b across string-b
         when (char-not-equal a b)
         count a)
      (error 'different-length-error)))

#|

Levenshtein distance:

The number of operations required to transform one string to the other the allowed operations are:

1. Insertion
2. Deletion
3. Substitution

It is computed for two strings by memoising the distances between the
prefixes using the table prefix-distance.

    s.t.r.i.n.g-b
  0 1 2 3 4 5 6 7
s 1             |
t 2             |
r 3       X     |
i 4             |
n 5             |
g 6             V
a 7 ----------->D

Here X denotes the distance between the 4-prefix of string-b and the
3-prefix of string-a. We fill all the values of the table.

The final value to be returned is:

prefix-distance[(length string-a), (length string-b)]; it is
represented on the diagram by D.

|#

(defun levenshtein-distance (string-a string-b)
  (let* ((rows (1+ (length string-a)))
         (cols (1+ (length string-b)))
         (prefix-distance (make-array (list rows cols))))

         ;; Trivial case where the first string is empty, so the
         ;; prefixes in the first row, increase by one.

         (loop for idx from 1 below cols do
              (setf (aref prefix-distance 0 idx) idx))

         ;; Trivial case, where the second string is empty, so the
         ;; prefixes in the first column, increase by one.

         (loop for jdx from 1 below rows do
              (setf (aref prefix-distance jdx 0) jdx))

         (loop for idx from 1 below rows do
              (loop for jdx from 1 below cols do

                   (setf (aref prefix-distance idx jdx)
                         (if (char-equal (aref string-a (1- idx))
                                         (aref string-b (1- jdx)))
                             ;; if the last corresponding symbols of
                             ;; the n-prefix and m-prefix are equal,
                             ;; then the distance is the same is that
                             ;; of the (n-1)-prefix and the
                             ;; (m-1)-prefix.
                             (aref prefix-distance (1- idx) (1- jdx))
                             
                             (min (1+ (aref prefix-distance (1- idx)     jdx))
                                  (1+ (aref prefix-distance     idx  (1- jdx)))
                                  (1+ (aref prefix-distance (1- idx) (1- jdx))))))))
                                  
         (aref prefix-distance (1- rows) (1- cols))))
         

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
  (let ((idx (1- i))
        (jdx (1- j)))
    (assert (and (< idx (length string-a)) (< jdx (length string-b))))
    (if (char-equal (aref string-a idx) (aref string-b jdx))
        0
        1)))

(define-condition different-length-error (error)
  ())
