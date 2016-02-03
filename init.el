;;; init.el --- my .emacs config
;; Anton Linevich <mail@linevich.net>
;;; Commentary:
;;; Code:


;;; Package settings
(require 'package)
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'no-error 'no-message)
(add-to-list 'load-path "~/.emacs.d/lisp/")

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
			 ("org" . "http://orgmode.org/elpa/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(setq use-package-verbose t)
(require 'use-package)

(use-package auto-compile
  :ensure t
  :config (auto-compile-on-load-mode))
(setq load-prefer-newer t)

(use-package ergoemacs
  :pin gnu
  :init (ergoemacs-mode 1)
  :config (progn 
	    (setq ergoemacs-theme nil)
	    (setq ergoemacs-keyboard-layout "us")
	    (setq ergoemacs-message-level nil) ;; Disabling all debug messages.
	    (ergoemacs-mode 1)))

;;; General appearance settings.
;; Disable menubar, toolbar and scrollbar.
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)


;; Setting color theme
(use-package spacemacs-theme :ensure t :init (load-theme 'spacemacs-dark t))

(use-package spaceline
  :ensure t
  :init (progn
	  (require 'spaceline-config)
	  (spaceline-emacs-theme)
	  (spaceline-helm-mode)
	  (spaceline-toggle-column-on)))

(use-package fill-column-indicator
  :ensure t
  :init (progn
	  (setq-default fill-column 100)
	  (setq fci-rule-color "#3D3D3D")
	  (setq fci-rule-column 100)
	  (setq fci-rule-width 1)
	  (setq fci-rule-character-color "#3D3D3D")
	  (add-hook 'markdown-mode-hook 'fci-mode)
	  (add-hook 'emacs-lisp-mode-hook 'fci-mode)))


;;; Auto completion tools.
(use-package helm :ensure t :init (helm-mode 1)) ;; Helm M-x, switch buffer and other operations completion tool.
(use-package company :ensure t :init (global-company-mode t)) ;; Company mode - in-file completion engine.

;; Snippets

(use-package yasnippet
  :init
  (progn 
    (load-file "~/.emacs.d/lisp/yasnippet/yasnippet.el")
    (yas-global-mode))
  :config
  (setq yas-snippet-dirs
	'("~/.emacs.d/snippets"
	  "~/.emacs.d/lisp/yasnippet/snippets")))


(use-package rainbow-delimiters :ensure t :init (rainbow-delimiters-mode t)) ;; Parentheses highlight mode
(use-package autopair :ensure t :config (autopair-mode t))    ;; Auto close parentheses
(use-package flycheck :ensure t :init (global-flycheck-mode)) ;; Flychek - checking syntax
(use-package hgignore-mode :ensure t)
(use-package gitignore-mode :ensure t)
(use-package ace-jump-mode :ensure t)
(use-package less-css-mode :ensure t)
(use-package php-mode :ensure t)
(use-package jinja2-mode :ensure t)
(use-package autopair :ensure t)

;;; HTML & CSS/LESS settings

(use-package emmet-mode
  :ensure t
  :config (progn
	    (add-hook 'sgml-mode-hook 'emmet-mode)
	    (add-hook 'css-mode-hook  'emmet-mode)))

(use-package rainbow-mode
  :ensure t
  :config (progn
	    (add-hook 'css-mode-hook 'rainbow-mode)
	    (add-hook 'less-css-mode-hook 'rainbow-mode)))

;;;  Keybindings
(global-set-key (kbd "C-x p m") 'package-list-packages)
(global-set-key (kbd "C-x C-f") 'fill-paragraph)

(use-package multiple-cursors
  :ensure t
  :config (progn 
	    (global-set-key (kbd "s-.") 'mc/mark-next-like-this)
	    (global-set-key (kbd "s-,") 'mc/mark-previous-like-this)))


;; "Yes or no" to "y or n"
(fset 'yes-or-no-p 'y-or-n-p)

;;; Backup settings
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))


(provide 'init)
;;; init.el ends here
