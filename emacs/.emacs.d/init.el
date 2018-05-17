(setq user-full-name "Antoine Roulin"
      user-mail-address "antoine.roulin@eisti.fr")

;; GUI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(toggle-frame-maximized)

(fset 'yes-or-no-p 'y-or-n-p) ; shorter messages

(global-set-key (kbd "<f5>") 'revert-buffer) ; reload a file in the current buffer

(global-hl-line-mode t) ; highlight current line

(setq-default frame-title-format "%b (%f)") ; filename in title bar

(setq ring-bell-function 'ignore) ; no bell

;; UTF-8 as default encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(show-paren-mode 1) ; Highlights matching parenthesis

(electric-pair-mode 1) ; auto bracket insertion

(c-set-offset (quote cpp-macro) 0 nil) ; pragma indentation in C/C++

;; Backup and auto-saved files in temporary directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Font and display
(set-face-attribute 'default t :font "Source Code Pro" :height 126)
(set-face-attribute 'variable-pitch t :font "Charter" :height 144)

(defun set-buffer-variable-pitch ()
  (interactive)
  (variable-pitch-mode t)
  (setq line-spacing 3)
  (set-face-attribute 'org-table nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-link nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-block nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-date nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-special-keyword nil :inherit 'fixed-pitch))

(add-hook 'org-mode-hook 'set-buffer-variable-pitch)
(add-hook 'eww-mode-hook 'set-buffer-variable-pitch)
(add-hook 'markdown-mode-hook 'set-buffer-variable-pitch)
(add-hook 'Info-mode-hook 'set-buffer-variable-pitch)

(setq org-hide-emphasis-markers t)

(global-prettify-symbols-mode 1)
(setq prettify-symbols-unprettify-at-point t)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

(setq use-package-always-ensure t)

;; Provides help for keys
(use-package which-key
  :config
  (which-key-mode))
	
;; Nicer bullets for org-mode
(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

;; Window switching
(use-package ace-window
  :init
  (global-set-key [remap other-window] 'ace-window)
  (custom-set-faces
   '(aw-leading-char-face
     ((t (:inherit ace-jump-face-foreground :height 3.0))))))

;; Search
(use-package swiper
  :ensure counsel
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
  :bind ("M-s" . avy-goto-char))
  
;; Auto-completion
(use-package auto-complete
  :init
  (ac-config-default)
  (global-auto-complete-mode t))

;; Snippets
(use-package yasnippet
  :init
  (yas-global-mode 1))

;; Solarized theme
(use-package solarized-theme
  :custom
  (solarized-distinct-fringe-background t)
  (solarized-high-contrast-mode-line t)
  (solarized-use-more-italic t)
  (x-underline-at-descent-line t)
  :config
  (load-theme 'solarized-light t))

;; Linting
(use-package flycheck
  :init
  (global-flycheck-mode t))

;; Quickly delete whitespace
(use-package hungry-delete
  :config
  (global-hungry-delete-mode))

;; Expand the marked region by semantic units
(use-package expand-region
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

;; Web Development
(use-package web-mode
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
  :config
  (add-hook 'sgml-mode-hook 'emmet-mode)
  (add-hook 'web-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook 'emmet-mode))

(use-package better-shell
  :bind
  (("C-'" . better-shell-shell)
   ("C-;" . better-shell-remote-open)))

;; Project management
(use-package projectile
  :config
  (projectile-mode)
  (setq projectile-completion-system 'ivy)
  (setq projectile-enable-caching t))

(use-package counsel-projectile
  :config
  (counsel-projectile-mode))

;; startup screen
(use-package dashboard
  :ensure page-break-lines
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "Praise St. IGNUcius!")
  (setq dashboard-startup-banner "~/dotfiles/emacs/.emacs.d/top_gnu.jpeg")
  (setq dashboard-image-banner-max-width 500)
  (setq dashboard-items '((recents . 5)
			  (projects . 5))))

;; Git versionning
(use-package magit)

;; LaTeX editing
(use-package tex
  :ensure auctex
  :config
  (TeX-PDF-mode t))

;; Racket programming
(use-package racket-mode
  :hook (((racket-mode racket-repl-mode) . racket-unicode-input-method-enable)
	 (racket-mode . (lambda ()
			  (define-key racket-mode-map (kbd "C-c r") 'racket-run)))))

;; Markdown
(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc"))

;; nice writing environment
(use-package olivetti
  :ensure t
  :hook ((org-mode LaTeX-mode text-mode) . olivetti-mode))

;; multiple cursors
;;(use-package multiple-cursors
  ;;:ensure t
  ;;:config
  ;;(global-unset-key (kbd "M-<down-mouse-1>"))
  ;;(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click))

;; Scala
(use-package scala-mode
  :interpreter ("scala" . scala-mode)
  :config
  (setq prettify-symbols-alist scala-prettify-symbols-alist))

(use-package eldoc
  :ensure nil
  :diminish eldoc-mode
  :commands eldoc-mode)

(use-package elixir-mode
  :mode "\\.elixir2\\'")

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (org dashboard page-break-lines scala-mode elixir-mode yasnippet which-key web-mode use-package try solarized-theme racket-mode org-journal org-bullets olivetti markdown-mode magit jedi hungry-delete flycheck expand-region emmet-mode counsel-projectile better-shell auctex ace-window)))
 '(solarized-distinct-fringe-background t)
 '(solarized-high-contrast-mode-line t)
 '(solarized-use-more-italic t)
 '(x-underline-at-descent-line t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0))))
 '(org-document-title ((t (:inherit default :weight bold :foreground "black" :font "Source Sans Pro" :height 1.5 :underline nil))))
 '(org-level-1 ((t (:inherit default :foreground "black" :slant normal :weight bold :height 1.75 :width normal :foundry "ADBO" :family "Charter"))))
 '(org-level-2 ((t (:inherit default :foreground "black" :slant normal :weight bold :height 1.5 :width normal :foundry "ADBO" :family "Charter"))))
 '(org-level-3 ((t (:inherit default :foreground "black" :slant normal :weight bold :height 1.25 :width normal :foundry "ADBO" :family "Charter"))))
 '(org-level-4 ((t (:inherit default :weight bold :foreground "black" :font "Source Sans Pro" :height 1.1))))
 '(org-level-5 ((t (:inherit default :weight bold :foreground "black" :font "Source Sans Pro"))))
 '(org-level-6 ((t (:inherit default :weight bold :foreground "black" :font "Source Sans Pro"))))
 '(org-level-7 ((t (:inherit default :weight bold :foreground "black" :font "Source Sans Pro"))))
 '(org-level-8 ((t (:inherit default :weight bold :foreground "black" :font "Source Sans Pro"))))
 '(variable-pitch ((t (:family "Charter")))))
