(defun read-as-string-until-newline (stream)
  (with-output-to-string (out-stream)
    (loop for next = (peek-char nil stream t nil t)
          until (member next '(#\newline #\tab))
          do (write-char (read-char stream t nil t) out-stream))))

(defun string-reader (stream char)
  (declare (ignore char))
  `(april::april-f
    ,(read-as-string-until-newline stream)))


(set-macro-character #\@ #'string-reader )
