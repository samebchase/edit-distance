(in-package :edit-distance-test)

(def-suite all-tests)

(in-suite all-tests)

(test trivial
  (is (= 2 2)))

(test hamming
  (is (= 3 (hamming-distance "toned" "roses")))
  (is (= 2 (hamming-distance "1011101" "1001001")))
  (is (= 3 (hamming-distance "2173896" "2233796")))
  (signals edit-distance::different-length-error (hamming-distance "foobar" "foo")))

(test levenshtein-rec-trivial
  (is (= 0 (levenshtein-distance-rec "" "")))
  (is (= 0 (levenshtein-distance-rec "0" "0")))
  (is (= 1 (levenshtein-distance-rec "1" "0")))
  (is (= 6 (levenshtein-distance-rec "" "123456"))))

(test levenshtein-distance-rec-non-trivial
  (is (= 3 (levenshtein-distance-rec "toned" "roses")))
  (is (= 2 (levenshtein-distance-rec "1011101" "1001001")))
  (is (= 3 (levenshtein-distance-rec "2173896" "2233796")))
  (is (= 3 (levenshtein-distance-rec "kitten" "sitting")))
  (is (= 1 (levenshtein-distance-rec "closure" "clojure")))
  (is (= 1 (levenshtein-distance-rec "clojure" "closure")))
  (is (= 2 (levenshtein-distance-rec "xyx" "xyyyx")))
  (is (= 0 (levenshtein-distance-rec "Clojure" "Clojure"))))

;; These take too long for the recursive implementation
;;
;; (is (= 10 (levenshtein-distance-rec "ttttattttctg" "tcaaccctaccat")))
;; (is (=  9 (levenshtein-distance-rec "gaattctaatctc" "caaacaaaaaattt"))))
