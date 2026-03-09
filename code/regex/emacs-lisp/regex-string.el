;; emacs -Q --script regex-string.el
(let* ((s1 "a")
       (s2 "a?")
       (regex (concat s1 s2)))
  (dotimes (_ 29)
    (when (string-match-p regex s1) (message "%s matches %s" s1 regex))
    (setq s1 (concat s1 "a")
          s2 (concat s2 "a?")
          regex (concat s1 s2))))
