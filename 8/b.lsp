(defvar moves (coerce (read-line) 'list))

(setf (cdr (last moves)) moves)

(defvar blank (read-line))

(defun parse-line (line) 
  (cons (subseq line 0 3) (cons (subseq line 3 6) (subseq line 6 9)))
)

(defvar lines (loop for line = (read-line nil nil)
          while line
          collect (parse-line (remove-if-not #'alpha-char-p line))))

(defun traverse (node move)
  (if (equal move #\L)
    (cadr (assoc node lines :test #'equal))
    (cddr (assoc node lines :test #'equal))
  )
)

(defun solve (node)
  (let (n)
    (setq n 0)
    (loop
      (setf node (traverse node (pop moves)))
      (setq n (+ n 1))
      (when (equal (lastchar node) #\Z) (return n))
    )
  )
)

(defun lastchar (s)
  (car (last (coerce s 'list)))
)

(defun start-nodes ()
  (remove-if-not (lambda (node) (equal (lastchar node) #\A)) (mapcar #'car lines))
)

(format t "~d" (apply #'lcm (mapcar #'solve (start-nodes))))
