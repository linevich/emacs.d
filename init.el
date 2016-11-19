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
	    (ergoemacs-mode 1))
  (global-set-key (kbd "M-l") 'forward-char))

;;; General appearance settings.
;; Disable menubar, toolbar and scrollbar.
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)


;;; Using different font settings methods when launching as GUI or as a daemon
(if window-system
    (progn
      (add-to-list 'default-frame-alist '(font . "Roboto Mono-9" ))
      (set-face-attribute 'default t :font "Roboto Mono-9" )
      (set-frame-font "Roboto Mono-9" nil t))
  (setq default-frame-alist '((font . "Roboto Mono-9"))))

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)



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
(use-package helm
  :ensure t
  :init (progn
	  (require 'helm-config)
	  (setq helm-candidate-number-limit 100)
	  (setq helm-idle-delay 0.0 
		helm-input-idle-delay 0.01
		helm-yas-display-key-on-candidate t
		helm-quick-update t
		helm-M-x-requires-pattern nil
		helm-ff-skip-boring-files t)
	  (helm-mode 1))) ;; Helm M-x, switch buffer and other operations completion tool.


;; Company mode - in-file completion engine.
(use-package company 
  :ensure t 
  :init (global-company-mode t))


;; Snippets
(use-package yasnippet
  :init
  (progn 
    ;;(load-file "~/.emacs.d/lisp/yasnippet/yasnippet.el")
    (yas-global-mode))
  :config
  (setq yas-snippet-dirs
	'("~/.emacs.d/snippets"
	  "~/.emacs.d/lisp/yasnippet/snippets")))


;; Parentheses highlight mode
(use-package rainbow-delimiters
  :ensure t
  :init (rainbow-delimiters-mode t)
  :config (progn
	    (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
	    (add-hook 'latex-mode-hook 'rainbow-delimiters-mode)
	    (add-hook 'json-mode-hook 'rainbow-delimiters-mode)))


(use-package autopair :ensure t :config (autopair-mode t))    ;; Auto close parentheses
(use-package flycheck :ensure t :init (global-flycheck-mode)) ;; Flychek - checking syntax
(use-package hgignore-mode :ensure t)
(use-package gitignore-mode :ensure t)
(use-package ace-jump-mode :ensure t)
(use-package less-css-mode :ensure t)
(use-package php-mode :ensure t)
(use-package jinja2-mode :ensure t)
(use-package autopair :ensure t)
(use-package json-mode :ensure t)


(use-package langtool
  :ensure t
  :init (progn
	  (setq langtool-language-tool-jar "~/bin/language-tool/languagetool-commandline.jar")
	  (setq langtool-default-language "en-US")
	  (setq langtool-mother-tongue "en")))


(use-package sr-speedbar :ensure t) ;; Speedbar

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
  :bind (("s-." . mc/mark-next-like-this)
	 ("s-," . mc/mark-previous-like-this)
	 ("s-c i n" . mc/insert-numbers)
	 ("s-c i l" . mc/insert-letters)))


;; "Yes or no" to "y or n"
(fset 'yes-or-no-p 'y-or-n-p)

;;; Backup settings
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

(defun insert-hash ()
  (interactive)
  (insert "#"))

(defun linevich/markdown-settings ()
  (interactive)
  (local-set-key (kbd "№") 'insert-hash)
  (local-set-key (kbd "C p") 'markdown-preview)
  )


(setq markdown-css-paths (list
			  "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"))
(add-hook 'markdown-mode-hook 'linevich/markdown-settings)
(add-hook 'markdown-mode-hook 'flyspell-mode-on)


(use-package textile-mode
  :ensure t
  :init (progn
	  (add-to-list 'auto-mode-alist '("\\.textile$" . textile-mode))))

(use-package magit
  :ensure t
  :init (global-unset-key (kbd "A-m"))
  :bind (("C-k" . magit-commit)
	 ("C-m" . magit-status)))

;;; LaTeX settings

(use-package tex-site  :ensure auctex)
(use-package company-auctex :ensure t)


(defun linevich/latex-settings ()
  (interactive)
  (auto-fill-mode t)
  (flyspell-mode t))

(add-hook 'latex-mode-hook 'linevich/latex-settings)

(use-package jedi
  :ensure t
  :config (progn
	    (add-hook 'python-mode-hook 'jedi:setup)
	    (setq jedi:complete-on-dot t)))

(use-package sudo-edit
  :ensure t
  :bind("C-x C-s". sudo-edit))

(use-package org
  :bind ("s-i l". org-insert-link))

(provide 'init)

;;; init.el ends here
