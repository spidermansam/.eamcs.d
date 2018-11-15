;; source
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))

(package-initialize)


;; init emacs
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'init-ui)
(require 'init-vim)
(require 'init-source)
(require 'init-plugins)
(require 'init-versions)
(require 'yasnippet)
(require 'init-go)


(elpy-enable)
;(setq elpy-rpc-banckend "jedi")

; yas
(setq yas/prompt-functions
      '(yas/dropdown-prompt yas/x-prompt yas/completing-prompt
			    yas/ido-prompt yas/no-prompt))
(yas/global-mode 1)
(yas/minor-mode-on)






(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(package-selected-packages
   (quote
    (dracula-theme i3wm smart-mode-line-powerline-theme powerline-evil powerline nyan-mode highlight-indent-guides yasnippet-snippets jedi elpy company-jedi))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'set-goal-column 'disabled nil)
