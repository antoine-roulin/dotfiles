;; -*- lexical-binding: t -*-

;; Reduce startup time
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)
(add-hook 'after-init-hook
          `(lambda ()
             (setq gc-cons-threshold 800000
                   gc-cons-percentage 0.1)
             (garbage-collect)) t)

;; Personnal informations

(setq user-full-name "Antoine Roulin"
      user-mail-address "antoine.roulin@coopengo.com")

;; Package management setup

(require 'package)

(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; UTF-8 as default encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; Interface

(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)

(global-hl-line-mode t) ; highlight current line

(setq-default frame-title-format "%f") ; filename in title bar

;; Highlights matching parenthesis
(setq show-paren-delay 0)
(show-paren-mode 1)

(when (member "Iosevka SS01" (font-family-list)) (set-frame-font "Iosevka SS01-12" t t))

(use-package modus-operandi-theme
  :ensure
  :config (load-theme modus-operandi))

(use-package smooth-scrolling
  :ensure t
  :config (smooth-scrolling-mode 1))

(setq save-interprogram-paste-before-kill t)

(desktop-save-mode 1)

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package helpful
  :ensure t
  :bind (("C-h f" . helpful-callable)
	 ("C-h v" . helpful-variable)
	 ("C-h k" . helpful-key)
	 ("C-c C-d" . helpful-at-point)
	 ("C-h F" . helpful-function)
	 ("C-h C" . helpful-command)))

;; Editing

(use-package undo-tree
  :ensure t
  :config (global-undo-tree-mode))

(use-package evil
  :ensure t
  :config (evil-mode 1))

(setq electric-pair-mode 1)

;; Fuzzy search and selections

(use-package icomplete-vertical
  :ensure t
  :demand t
  :custom
  (completion-styles '(partial-completion substring))
  (completion-category-overrides '((file (styles basic substring))))
  (read-file-name-completion-ignore-case t)
  (read-buffer-completion-ignore-case t)
  (completion-ignore-case t)
  :config
  (icomplete-mode)
  (icomplete-vertical-mode)
  :bind (:map icomplete-minibuffer-map
              ("<down>" . icomplete-forward-completions)
              ("C-n" . icomplete-forward-completions)
              ("<up>" . icomplete-backward-completions)
              ("C-p" . icomplete-backward-completions)
              ("C-v" . icomplete-vertical-toggle)))

(use-package orderless
  :ensure t
  :init (icomplete-mode) ; optional but recommended!
  :custom (completion-styles '(orderless)))

;; Completion

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  (global-company-mode t))

;; Magit

(use-package magit
  :ensure t
  :init
  (progn (bind-key "C-x g" 'magit-status)))

(setq magit-status-margin '(t "%Y-%m-%d %H:%M " magit-log-margin-width t 18))

(use-package git-timemachine
  :ensure t)

(use-package git-gutter
  :ensure t
  :init (global-git-gutter-mode +1))

;; Org-mode

(use-package org-superstar
  :ensure t
  :hook (org-mode . org-superstar-mode))

(add-hook 'org-mode-hook 'turn-on-auto-fill)

(setq org-hide-emphasis-markers t
      org-src-tab-acts-natively t
      org-src-fontify-natively t
      org-catch-invisible-edits 'show-and-error)

(use-package olivetti
  :ensure t
  :hook (org-mode . olivetti-mode)
  :config
  (setq olivetti-body-width 0.65)
  (setq olivetti-minimum-body-width 72)
  (setq olivetti-recall-visual-line-mode-entry-state t))

(use-package mixed-pitch
  :ensure t
  :hook (org-mode . mixed-pitch-mode))

(defun arln/after-org-mode-load ()
  (set-window-fringes (selected-window) 0 0)
  (cursor-type-mode 1))
(add-hook 'org-mode-hook 'arln/after-org-mode-load)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("00664002472a541e3df8a699c2ea4a5474ea30518b6f9711fdf5fe3fe8d6d34f" default)))
 '(package-selected-packages
   (quote
    (mixed-pitch olivetti org-superstar helpful smartparens org-bullets git-gutter git-timemachine magit which-key use-package)))
 '(sp-escape-quotes-after-insert nil)
 '(x-underline-at-descent-line t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(variable-pitch ((t (:height 1.2 :family "Alegreya")))))
