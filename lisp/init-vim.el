;;临时记号
;;有时你需要跳到另一个文件进行一些操作，然后很快的跳回来。你当然可以 使用 bookmark或者寄存器。
;;但是这些实在是太慢了。你多想拥有vi那样的 ma, mb, 'a, 'b 的操作。现在你可以用几行 elisp 达到类似的目的
(global-set-key [(control ?\.)] 'ska-point-to-register)
(global-set-key [(control ?\,)] 'ska-jump-to-register)
(defun ska-point-to-register()
      "Store cursorposition _fast_ in a register. 
Use ska-jump-to-register to jump back to the stored 
position."
      (interactive)
      (setq zmacs-region-stays t)
      (point-to-register 8))

(defun ska-jump-to-register()
      "Switches between current cursorposition and position
that was stored with ska-point-to-register."
      (interactive)
      (setq zmacs-region-stays t)
      (let ((tmp (point-marker)))
	(jump-to-register 8)
	(set-register 8 tmp)))



;; 注释
(defun my-comment-or-uncomment-region (beg end &optional arg)
  (interactive (if (use-region-p)
		   (list (region-beginning) (region-end) nil)
		 (list (line-beginning-position)
		       (line-beginning-position 2))))
  (comment-or-uncomment-region beg end arg)
  )
(global-set-key [remap comment-or-uncomment-region] 'my-comment-or-uncomment-region)

;; 移动行


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


;;输入左边的括号，就会自动补全右边的部分.包括(), '', [] , {} ,""
(require 'cperl-mode)
(defun auto-pair ()
  (interactive)
  (make-local-variable 'skeleton-pair-alist)
  (setq skeleton-pair-alist '(
			      (?` ?` _ "''")
			      (?\( _ ")")
			      (?\[ _ "]")
			      ;;                      (?{ \n > _ \n ?} >)
			      (?\" _ "\"")))
  (setq skeleton-pair t)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "'") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe))
(add-hook 'python-mode-hook 'auto-pair)
(add-hook 'python-mode-hook 'auto-pair)

(provide 'init-vim)
