(setq user-full-name "Antoine Roulin"
      user-mail-address "antoine.roulin@eisti.fr")

;; GUI
(menu-bar-mode -1)
(tool-bar-mode -1)

(fset 'yes-or-no-p 'y-or-n-p) ; shorter messages

(global-set-key (kbd "<f5>") 'revert-buffer) ; reload a file in the current buffer

(global-hl-line-mode t) ; highlight current line

(setq-default frame-title-format "%b (%f)") ; filename in title bar

(setq ring-bell-function 'ignore) ; no bell

(setq org-hide-emphasis-markers t) ; nicer emphasis in org-mode

;; UTF-8 as default encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(show-paren-mode 1) ; Highlights matching parenthesis

(electric-pair-mode 1) ; auto bracket insertion

;; list of recent files at startup
(require 'recentf)
(setq recentf-max-saved-items 50
      recentf-max-menu-items 40)
(recentf-mode 1)

(setq inhibit-startup-message t
      initial-buffer-choice 'recentf-open-files)

;; Backup and auto-saved files in temporary directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(let* ((variable-tuple '(:font "Source Sans Pro"))
       (base-font-color     (face-foreground 'default nil 'default))
       (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

  (custom-theme-set-faces 'user
                          `(org-level-8 ((t (,@headline ,@variable-tuple))))
                          `(org-level-7 ((t (,@headline ,@variable-tuple))))
                          `(org-level-6 ((t (,@headline ,@variable-tuple))))
                          `(org-level-5 ((t (,@headline ,@variable-tuple))))
                          `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
                          `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))
                          `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.5))))
                          `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.75))))
                          `(org-document-title ((t (,@headline ,@variable-tuple :height 1.5 :underline nil))))))

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

;; Try packages without installing them
(use-package try
	:ensure t)

;; Provides help for keys
(use-package which-key
  :ensure t
  :config
  (which-key-mode))
	
;; Nicer bullets for org-mode
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; Window switching
(use-package ace-window
  :ensure t
  :init
  (global-set-key [remap other-window] 'ace-window)
  (custom-set-faces
   '(aw-leading-char-face
     ((t (:inherit ace-jump-face-foreground :height 3.0))))))
    
;; it looks like counsel is a requirement for swiper
(use-package counsel
  :ensure t)

;; Search
(use-package swiper
  :ensure try
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-load-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  (define-key read-expression-map (kbd "C-r") 'counsel-expression-history))
    
;; Quick navigation
(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char))
  
;; Auto-completion
(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)))

;; Snippets
(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1))

;; Solarized theme
(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-light t)
  (setq solarized-distinct-fringe-background t)
  (setq solarized-high-contrast-mode-line t)
  (setq solarized-use-more-italic t)
  (setq x-underline-at-descent-line t))

;; Linting
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

;; Python completion
(use-package jedi
  :ensure t
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook 'jedi:ac-setup)) ; run M-x jedi:install-server to install

;; Quickly delete whitespace
(use-package hungry-delete
  :ensure t
  :config
  (global-hungry-delete-mode))

;; Expand the marked region by semantic units
(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

;; Web Development
(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (setq web-mode-engines-alist
	'(("django" . "\\.html\\'")))
  (setq web-mode-ac-sources-alist
	'(("css" . (ac-source-css-property))
	  ("html" . (ac-source-words-in-buffer ac-source-abbrev))))
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-quoting t))
(use-package emmet-mode
  :ensure t
  :config
  (add-hook 'sgml-mode-hook 'emmet-mode)
  (add-hook 'web-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook 'emmet-mode))

(use-package better-shell
  :ensure t
  :bind
  (("C-'" . better-shell-shell)
	("C-;" . better-shell-remote-open)))

;; Project management
(use-package projectile
  :ensure t
  :config
  (projectile-mode)
  (setq projectile-completion-system 'ivy))
(use-package counsel-projectile
  :ensure t
  :config
  (counsel-projectile-on))

;; Git versionning
(use-package magit
  :ensure t)

;; LaTeX editing
(use-package tex
  :ensure auctex
  :config
  (TeX-PDF-mode t))

;; Racket programming
(use-package racket-mode
  :ensure t)
(add-hook 'racket-mode-hook
	  (lambda ()
	    (define-key racket-mode-map (kbd "C-c r") 'racket-run)))
(add-hook 'racket-mode-hook #'racket-unicode-input-method-enable)
(add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)

;; Markdown
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc"))

;; nice writing environment
(use-package olivetti
  :ensure t
  :config
  (add-hook 'org-mode-hook 'olivetti-mode)
  (add-hook 'LaTeX-mode-hook 'olivetti-mode))

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yasnippet which-key web-mode use-package try solarized-theme racket-mode org-journal org-bullets olivetti markdown-mode magit jedi hungry-delete flycheck expand-region emmet-mode counsel-projectile better-shell auctex ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0))))
 '(org-document-title ((t (:inherit default :weight bold :foreground "black" :font "Source Sans Pro" :height 1.5 :underline nil))))
 '(org-level-1 ((t (:inherit default :weight bold :foreground "black" :font "Source Sans Pro" :height 1.75))))
 '(org-level-2 ((t (:inherit default :weight bold :foreground "black" :font "Source Sans Pro" :height 1.5))))
 '(org-level-3 ((t (:inherit default :weight bold :foreground "black" :font "Source Sans Pro" :height 1.25))))
 '(org-level-4 ((t (:inherit default :weight bold :foreground "black" :font "Source Sans Pro" :height 1.1))))
 '(org-level-5 ((t (:inherit default :weight bold :foreground "black" :font "Source Sans Pro"))))
 '(org-level-6 ((t (:inherit default :weight bold :foreground "black" :font "Source Sans Pro"))))
 '(org-level-7 ((t (:inherit default :weight bold :foreground "black" :font "Source Sans Pro"))))
 '(org-level-8 ((t (:inherit default :weight bold :foreground "black" :font "Source Sans Pro")))))
