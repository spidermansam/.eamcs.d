
;; python 代码检查
(global-set-key (kbd "C-c C-c")  'search-forward)

; 其他配置

(defun my-python-mode-config ()
  (setq python-indent-offset 4
	python-indent 4
	indent-tabs-mode nil
	default-tab-width 4
	;; 设置 run-python 的参数
	python-shell-interpreter "ipython"
	python-shell-interpreter-args "-i"
	python-shell-prompt-regexp "In \\[[0-9]+\\]: "
	python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
	python-shell-completion-setup-code "from IPython.core.completerlib import module_completion"
	python-shell-completion-module-string-code "';'.join(module_completion('''%s'''))\n"
	python-shell-completion-string-code "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")
  (require 'python-mode)
    (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode)))



; 全局自动补括号和引号
(electric-pair-mode t)


; python 按键配置
(defun auto-pair ()
;  (local-set-key (kbd "C-x C-s") 'elpy-check)
  (local-set-key (kbd "C-z") 'undo)
  )
(add-hook 'python-mode-hook 'auto-pair)



; auto company
;(require 'company)
;(global-company-mode t); 全局开启

;(setq company-idle-delay 0.2;菜单延迟
;      company-minimum-prefix-length 1; 开始补全字数
;      company-require-match nil
;      company-dabbrev-ignore-case nil
;      company-dabbrev-downcase nil
;      company-show-numbers t; 显示序号
;      company-transformers '(company-sort-by-backend-importance)
;      company-continue-commands '(not helm-dabbrev)
;      )
;                                        ; 补全菜单选项快捷键
;(define-key company-active-map (kbd "C-n") 'company-select-next)
;(define-key company-active-map (kbd "C-p") 'company-select-previous)
;
;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode);global enable


(provide 'init-vim)
