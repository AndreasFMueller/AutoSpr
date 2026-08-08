;; emacs -Q --script regex-buffer.el
(with-temp-buffer
  (let* ((s1 "a")
         (s2 "a?")
         (regex (concat s1 s2)))
    (dotimes (_ 29)
      (insert "a")
      (goto-char (point-min))
      (when (re-search-forward regex (point-max) nil 1) (message "%s matches %s" (buffer-string) regex))
      (setq
       s1 (concat s1 "a")
       s2 (concat s2 "a?")
       regex (concat s1 s2)))))
