;;撤消
;;(global-set-key (kbd "C-z") 'undo)
;;全选
;;(global-set-key (kbd "C-a") 'mark-whole-buffer)
;;保存
;;(global-set-key (kbd "C-s") 'save-buffer)

;;tab转空格
(setq-default indent-tabs-mode nil)
(setq default-tab-width 4)
(setq backward-delete-char-untabify-method nil)


;;跳转到某行
(global-set-key [(meta g)] 'goto-line)
;;Tab补全或缩进
(global-set-key [(tab)] 'my-indent-or-complete)


;;显示匹配括号
(show-paren-mode t)
(setq show-paren-style 'parentheses)


;; 不产生备份文件
(setq make-backup-files nil)


;; 替换 yes no -> y n
(fset 'yes-or-no-p'y-or-n-p)


;; 显示行号
(global-linum-mode 1) ; always show line numbers
(setq linum-format "%d$ ")
(setq py-autopep8-options '("--max-line-length=100"))

;; 更换光标为方块
(setq-default cursor-type 'box)


					;滚动页面时比较舒服，不要整页的滚动
(setq     scroll-step 1
	  scroll-margin 3
	  scroll-conservatively 10000)


;;滚动页面时比较舒服，不要整页的滚动
(setq     scroll-step 1
	  scroll-margin 3
	  scroll-conservatively 10000)


;;显示时间
(display-time-mode t)
;;启动Emacs Server
;;(server-start)


;;高亮当前行
(require 'hl-line)
(global-hl-line-mode t)
(set-face-background 'hl-line "#426167")


;;在标题栏显示buffer的名字(默认不显示)
(setq frame-title-format "%b@emacs")


;; 自定义高亮行显示颜色
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
;(setq highlight-indentation-offset 4)
(setq highlight-indent-guides-method 'character)
(setq highlight-indent-guides-auto-odd-face-perc 15)
(setq highlight-indent-guides-auto-even-face-perc 15)
(setq highlight-indent-guides-auto-character-face-perc 20)

;;关闭tab提示音
(setq visible-bell t)


;;启动Emacs自动设置为两个窗口(上下各一个)
(split-window-horizontally)


;;关闭烦人的出错时的提示声。
(setq visible-bell t)


;;隐藏工具栏
;;(tool-bar-mode nil)

;;去掉菜单栏，将F10绑定为显示菜单栏，需要菜单栏了可以摁F10调出，再摁F10就去掉菜单
(menu-bar-mode nil)

;;用一个很大的 kill ring. 这样防止我不小心删掉重要的东西。
(setq kill-ring-max 200)


(provide 'init-ui)