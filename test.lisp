(in-package :edit-distance-test)

(def-suite all-tests)

(in-suite all-tests)

(test trivial
  (is (= 2 2)))

(test hamming
  (is (= 3 (hamming-distance "toned" "roses")))
  (is (= 2 (hamming-distance "1011101" "1001001")))
  (is (= 3 (hamming-distance "3.2173896" "2233796"))))

(test levenshtein
  (is (= 3 (levenshtein-distance "toned" "roses")))
  (is (= 2 (levenshtein-distance "1011101" "1001001")))
  (is (= 3 (levenshtein-distance "3.2173896" "2233796")))

  (is (= 3 (levenshtein-distance "kitten" "sitting")))
  (is (= 3 (levenshtein-distance "closure" "clojure")))
  (is (= 1 (levenshtein-distance "clojure" "closure")))
  (is (= 2 (levenshtein-distance "xyx" "xyyyx")))
  (is (= 6 (levenshtein-distance "" "123456")))
  (is (= 0
         (levenshtein-distance "Clojure" "Clojure")
         (levenshtein-distance "" "")))
  (is (= 10 (levenshtein-distance "ttttattttctg" "tcaaccctaccat")))
  (is (=  9 (levenshtein-distance "gaattctaatctc" "caaacaaaaaattt"))))
