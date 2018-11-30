

(add-to-list 'load-path "~/.emacs.d/el-set")


(setq package-list '(
		     elpy
		     ))

					; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

					; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
        (package-install package)))


(provide 'init-plugins)
