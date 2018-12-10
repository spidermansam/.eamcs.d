;;; init-package.el --- Initialize package configurations.	-*- lexical-binding: t -*-

;; Copyright (C) 2018 Vincent Zhang

;; Author: Vincent Zhang <seagle0128@gmail.com>
;; URL: https://github.com/seagle0128/.emacs.d

;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;

;;; Commentary:
;;
;; Emacs Package management configurations.
;;

;;; Code:

(eval-when-compile
  (require 'init-custom))

;; HACK: DO NOT copy package-selected-packages to init/custom file forcibly.
;; https://github.com/jwiegley/use-package/issues/383#issuecomment-247801751
(defun my-save-selected-packages (&optional value)
  "Set `package-selected-packages' to VALUE but don't save to `custom-file'."
  (when value
    (setq package-selected-packages value)))
(advice-add 'package--save-selected-packages :override #'my-save-selected-packages)

;;
;; ELPA: refer to https://github.com/melpa/melpa and https://elpa.emacs-china.org/.
;;
(defun set-package-archives (&optional archives)
  "Set specific package ARCHIVES repository."
  (interactive)
  (unless archives
    (setq archives
          (intern (completing-read "Switch to archives: "
                                   '(melpa melpa-mirror emacs-china netease tuna)))))

  (let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                      (not (gnutls-available-p))))
         (proto (if no-ssl "http" "https")))
    (pcase archives
      ('melpa
       (setq package-archives `(,(cons "gnu"   (concat proto "://elpa.gnu.org/packages/"))
                                ,(cons "melpa" (concat proto "://melpa.org/packages/")))))
      ('melpa-mirror
       (setq package-archives `(,(cons "gnu"   (concat proto "://elpa.gnu.org/packages/"))
                                ,(cons "melpa" (concat proto "://www.mirrorservice.org/sites/melpa.org/packages/")))))
      ('emacs-china
       (setq package-archives `(,(cons "gnu"   (concat proto "://elpa.emacs-china.org/gnu/"))
                                ,(cons "melpa" (concat proto "://elpa.emacs-china.org/melpa/")))))
      ('netease
       (setq package-archives `(,(cons "gnu"   (concat proto "://mirrors.163.com/elpa/gnu/"))
                                ,(cons "melpa" (concat proto "://mirrors.163.com/elpa/melpa/")))))
      ('tuna
       (setq package-archives `(,(cons "gnu"   (concat proto "://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/"))
                                ,(cons "melpa" (concat proto "://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))))
      (archives
       (error "Unknown archives: '%s'" archives))))

  (setq centaur-package-archives archives)

  (message "Set package archives to '%s'." archives))

;; Set package archives
(if (file-exists-p (locate-user-emacs-file "elpa"))
    (set-package-archives centaur-package-archives)
  (progn
    ;; First startup
    (set-package-archives)

    ;; Save to `custom-file'
    (when (and (stringp custom-file)
               (file-readable-p custom-file)
               (file-writable-p custom-file))
      (let ((buffer (find-buffer-visiting custom-file))
            (regexp "^\\(;; +\\|.*\\)(setq centaur-package-archives '.+)")
            (str (format "(setq centaur-package-archives '%s)" centaur-package-archives)))
        (if buffer
            (with-current-buffer buffer
              (save-excursion
                (save-restriction
                  (widen)
                  (goto-char (point-min))
                  (when (re-search-forward regexp nil t)
                    (replace-match str))
                  (save-buffer))))
          (with-current-buffer (find-file-noselect custom-file)
            (goto-char (point-min))
            (when (re-search-forward regexp nil t)
              (replace-match str))
            (save-buffer)
            (kill-buffer)))))))

;; Initialize packages
(unless (bound-and-true-p package--initialized) ; To avoid warnings in 27
  (setq package-enable-at-startup nil)          ; To prevent initializing twice
  (package-initialize))

;; Setup `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Should set before loading `use-package'
(setq use-package-always-ensure t)
(setq use-package-always-defer t)
(setq use-package-expand-minimally t)
(setq use-package-enable-imenu-support t)

(eval-when-compile
  (require 'use-package))

;; Required by `use-package'
(use-package diminish)
(use-package bind-key)

;; Initialization benchmark
(when centaur-benchmark
  (use-package benchmark-init
    :commands (benchmark-init/activate)
    :hook (after-init . benchmark-init/deactivate)
    :init (benchmark-init/activate)))

;; Extensions
(use-package package-utils
  :init
  (defalias 'upgrade-packages 'package-utils-upgrade-all)
  (defalias 'upgrade-packages-and-restart 'package-utils-upgrade-all-and-restart))

(provide 'init-package)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-package.el ends here
