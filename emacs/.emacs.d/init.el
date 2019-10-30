;; -*- lexical-binding: t; -*-

(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(when (member "Iosevka SS01" (font-family-list)) (set-frame-font "Iosevka SS01-13" t t))

(setq-default use-package-always-defer t
              use-package-always-ensure t
              indent-tabs-mode nil
              tab-width 2
              css-indent-offset 2)

(desktop-save-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

(setq make-backup-files nil
      auto-save-default nil
      inhibit-splash-screen t
      visible-bell nil)

(setq user-full-name "Antoine Roulin"
      user-mail-address "antoine.roulin@coopengo.com")

(menu-bar-mode -1)
(tool-bar-mode -1)

(global-hl-line-mode t) ; highlight current line

(setq-default frame-title-format "%b (%f)") ; filename in title bar

;; UTF-8 as default encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; Highlights matching parenthesis
(setq show-paren-delay 0)
(show-paren-mode 1)

(electric-pair-mode 1) ; auto bracket insertion

(setq org-hide-emphasis-markers t)

(global-prettify-symbols-mode 1)
(setq prettify-symbols-unprettify-at-point t)

(setq ring-bell-function (lambda ()
                           (invert-face 'mode-line)
                           (run-with-timer 0.1 nil 'invert-face 'mode-line)))

(setq exec-path (append exec-path '("/usr/local/bin")))

(use-package flycheck
  :defer 1
  :init (global-flycheck-mode))

(use-package projectile
  :config (progn
            (projectile-mode)
            (setq projectile-enable-caching t)
            (setq projectile-completion-system 'ivy)))

(use-package counsel-projectile
  :config
  (counsel-projectile-mode))

(use-package magit
  :pin melpa-stable
  :defer 1
  :config (progn
            (put 'magit-clean 'disabled nil)
            (add-hook 'magit-status-sections-hook 'magit-insert-worktrees)
            (setq magit-commit-show-diff nil)))

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc")
  :config (progn
            (add-hook 'markdown-mode-hook 'visual-line-mode)
            (add-hook 'markdown-mode-hook (lambda () (flyspell-mode 1)))))

(use-package which-key
  :defer 1
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config (which-key-mode))

;; A better help buffer
(use-package helpful)

;; Nicer bullets for org-mode
(use-package org-bullets
  :hook (org-mode . org-bullets-mode))
;; Org-mode code blocks
(setq org-src-tab-acts-natively t)
(setq org-src-fontify-natively t)

(setq dired-dwim-target t
      dired-recursive-deletes t
      dired-use-ls-dired nil
      delete-by-moving-to-trash t)

(use-package editorconfig
  :defer 1
  :config (editorconfig-mode 1))

(use-package flyspell
  :defer 1
  :config (progn
            (setq flyspell-issue-message-flag nil)))

(use-package ivy
  :defer 1
  :config (progn
            (ivy-mode)
            (setq ivy-use-virtual-buffers t)
            (setq ivy-count-format "")
            (setq ivy-use-selectable-prompt t)))

(use-package counsel
  :defer 1
  :config (progn
            (global-set-key (kbd "M-x") 'counsel-M-x)))

(use-package swiper :defer 1)

(use-package vlf)

;; Solarized theme
(use-package solarized-theme
  :defer 0.1
  :custom
  (solarized-distinct-fringe-background t)
  (solarized-high-contrast-mode-line t)
  (solarized-use-more-italic t)
  (x-underline-at-descent-line t)
  :config
  (load-theme 'solarized-light t))

;; Quickly delete whitespace
(use-package hungry-delete
  :defer 1
  :config
  (global-hungry-delete-mode))

(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)))

;; Python Config

(setq py-python-command "python3")
(setq python-shell-interpreter "python3")

(use-package jedi
  :ensure t
  :hook ((python-mode-hook . jedi:setup)
         (python-mode-hook . jedi:ac-setup))
  :config (setq jedi:complete-on-dot t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (elpy page-break-lines hungry-delete solarized-theme vlf editorconfig org-bullets helpful which-key markdown-mode magit counsel-projectile projectile flycheck use-package)))
 '(solarized-distinct-fringe-background t t)
 '(solarized-high-contrast-mode-line t t)
 '(solarized-use-more-italic t t)
 '(x-underline-at-descent-line t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
