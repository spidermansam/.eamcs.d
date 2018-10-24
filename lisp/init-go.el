; init-golang

(require 'go-mode)
(require 'company-go)
(require 'go-autocomplete)
(require 'auto-complete-config)


(ac-config-default)
(setq ac-ignore-case t)
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

; 移除 为启用的import
(add-hook 'go-mode-hook '(lambda() (local-set-key (kbd "C-c C-r")'go-remove-unused-imports)))

; 自动格式化
(add-hook 'go-mode-hook '(lambda () (local-set-key (kbd "C-c C-f") 'gofmt)))
(add-hook 'before-save-hook 'gofmt-before-save)

; go文档 需要go get code.google.com/p/go.tools/cmd/godoc
;(add-hook 'go-mode-hook '(lambda() (local-set-key (kbd "C-c C-k") 'godoc)))

; 自动补全
(add-hook 'go-mode-hook '(lambda()
                           (set (make-local-variable 'company-backends)'(company-go))
                           (company-mode)))




(add-hook 'go-mode-hook #'(lambda() (setq ac-sources '(ac-source-go ac-source-abbrev ac-source-dictionary))))

(provide 'init-go)
