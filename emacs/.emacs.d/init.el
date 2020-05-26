(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)
(add-hook 'after-init-hook
          `(lambda ()
             (setq gc-cons-threshold 800000
                   gc-cons-percentage 0.1)
             (garbage-collect)) t)

;; Setup

(setq user-full-name "Antoine Roulin"
      user-mail-address "antoine.roulin@coopengo.com")

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

(electric-pair-mode 1) ; auto bracket insertion

(when (member "Iosevka SS01" (font-family-list)) (set-frame-font "Iosevka SS01-12" t t))

(use-package solarized-theme
  :ensure t
  :custom
  (solarized-use-variable-pitch nil)
  (solarized-scale-org-headlines nil)
  (solarized-distinct-fringe-background t)
  (solarized-high-contrast-mode-line nil)
  (solarized-use-more-italic t)
  (x-underline-at-descent-line t)
  :config
  (load-theme 'solarized-light t))

(setq save-interprogram-paste-before-kill t)

(desktop-save-mode 1)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Small interface tweaks

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package helpful
  :ensure t)

;; Magit

(use-package magit
  :ensure t
  :init
  (progn
    (bind-key "C-x g" 'magit-status)))

(setq magit-status-margin
      '(t "%Y-%m-%d %H:%M " magit-log-margin-width t 18))

(use-package git-timemachine
  :ensure t)

(use-package git-gutter
  :ensure t
  :init
  (global-git-gutter-mode +1))

;; Org-mode

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(add-hook 'org-mode-hook 'turn-on-flyspell)
(add-hook 'org-mode-hook 'turn-on-auto-fill)

(setq org-hide-emphasis-markers t
      org-src-tab-acts-natively t
      org-src-fontify-natively t
      org-catch-invisible-edits 'show-and-error)

;; Projectile

(use-package projectile
  :ensure t
  :bind (:map projectile-mode-map
              ("C-c p" . 'projectile-command-map))
  :config
  (projectile-mode +1))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (helpful projectile smartparens org-bullets git-gutter git-timemachine magit which-key solarized-theme use-package)))
 '(solarized-distinct-fringe-background t)
 '(solarized-high-contrast-mode-line nil)
 '(solarized-scale-org-headlines nil)
 '(solarized-use-more-italic t)
 '(solarized-use-variable-pitch nil)
 '(sp-escape-quotes-after-insert nil)
 '(x-underline-at-descent-line t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
