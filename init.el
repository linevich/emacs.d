;;; init.el --- my  .emacs config
;;; Commentary:
;;; Code:

;;; Package settings
(require 'package)
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'no-error 'no-message)
(add-to-list 'load-path "~/.emacs.d/lisp/yasnippet")

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
			 ("org" . "http://orgmode.org/elpa/")))

;; Package pipnning
(when (boundp 'package-pinned-packages)
  (setq package-pinned-packages
	'((ergoemacs-mode . "gnu"))))

(package-initialize)

(defun install-required-packages (package-list)
  (when (>= emacs-major-version 24)
    (package-refresh-contents)
    (mapc (lambda (package)
            (unless (require package nil t)
              (package-install package)))
          package-list)))

;; Reuired pakcages
(setq required-package-list '(yasnippet
			      ergoemacs-mode
			      sublime-themes
			      helm-mode
			      company
			      spaceline-config
			      rainbow-delimiters
			      hgignore-mode
			      gitignore-mode
			      fill-column-indicator
			      spacemacs-theme
			      fill-column-indicator
			      rainbow-mode
			      multiple-cursors
			      emmet-mode
			      ace-jump-mode
			      less-css-mode
			      php-mode
			      jinja2-mode
			      ))

(install-required-packages required-package-list)

(setq ergoemacs-theme nil)
(setq ergoemacs-keyboard-layout "us")
(ergoemacs-mode 1)

;;; General appearance settings.

;; Setting color theme
(load-theme 'spacemacs-dark t)

(fset 'yes-or-no-p 'y-or-n-p)

;; Disable menubar and toolbar.
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(spaceline-emacs-theme)
(spaceline-helm-mode)
(spaceline-toggle-column-on)
(rainbow-delimiters-mode t)

(setq-default fill-column 100)
(setq fci-rule-color "#3D3D3D")
(setq fci-rule-column 100)
(setq fci-rule-width 1)
(setq fci-rule-character-color "#3D3D3D")
(add-hook 'markdown-mode-hook 'fci-mode)


;;; Auto completion tools.

;; Helm M-x, switch buffer and other operations completion tool.
(helm-mode 1)

;; Company mode - in-file completion engine.
(global-company-mode t)

;; Snippets
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"
        "~/.emacs.d/lisp/yasnippet/snippets"
	))
(yas-global-mode t)

;; Parentheses highlight mode
(rainbow-delimiters-mode t)
(rainbow-mode t)

;; Flychek - checking syntax
(global-flycheck-mode)

;;; HTML & CSS/LESS settings

(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode 'rainbow-mode)
(add-hook 'less-css-mode-hook 'emmet-mode 'rainbow-mode)

;;;  Keybindings
(global-set-key (kbd "C-x p m") 'package-list-packages)
(global-set-key (kbd "C-x C-f") 'fill-paragraph)

(global-set-key (kbd "s-.") 'mc/mark-next-like-this)
(global-set-key (kbd "s-,") 'mc/mark-previous-like-this)


(provide 'init)
;;; init.el ends here
