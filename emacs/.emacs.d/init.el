;; Setup

(setq user-full-name "Antoine Roulin"
      user-mail-address "antoine.roulin@coopengo.com")

(require 'package)

(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

;; UTF-8 as default encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; Interface

(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)

(global-hl-line-mode t) ; highlight current line

(setq-default frame-title-format "%b (%f)") ; filename in title bar

;; Highlights matching parenthesis
(setq show-paren-delay 0)
(show-paren-mode 1)

(electric-pair-mode 1) ; auto bracket insertion

(when (member "Iosevka SS01" (font-family-list)) (set-frame-font "Iosevka SS01-14" t t))

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

(use-package doom-modeline
  :ensure t)
(doom-modeline-mode)

(setq save-interprogram-paste-before-kill t)

(desktop-save-mode 1)

(use-package hungry-delete
  :ensure t
  :config
  (global-hungry-delete-mode))

(use-package aggressive-indent
  :ensure t
  :config
  (global-aggressive-indent-mode 1))

;; Swiper, Ivy, Counsel

(use-package counsel
  :ensure t
  :bind
  (("M-y" . counsel-yank-pop)
   :map ivy-minibuffer-map
   ("M-y" . ivy-next-line)))

(use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "%d/%d ")
  (setq ivy-display-style 'fancy))

(use-package swiper
  :ensure t
  :bind (("C-s" . swiper-isearch)
	 ("C-r" . swiper-isearch)
	 ("C-c C-r" . ivy-resume)
	 ("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)))

;; Linter

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

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

(setq org-hide-emphasis-markers t)
(setq org-src-tab-acts-natively t)
(setq org-src-fontify-natively t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((js . t)))

;; Parens

(use-package smartparens
  :ensure t
  :hook (prog-mode . smartparens-mode)
  :custom
  (sp-escape-quotes-after-insert nil)
  :config
  (require 'smartparens-config))

(show-paren-mode t)

;; Snippets

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1))
(use-package yasnippet-snippets
  :ensure t)

;; Projectile

(use-package projectile
  :ensure t
  :bind (:map projectile-mode-map
              ("C-c p" . 'projectile-command-map))
  :config 
  (projectile-mode +1))

;; Completion

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  (global-company-mode t))

;; Python

(add-hook 'python-mode-hook
	  (lambda ()
            (setq indent-tabs-mode nil)
	    (infer-indentation-style)
	    (add-to-list 'write-file-functions 'delete-trailing-whitespace)))

(use-package virtualenvwrapper
  :ensure t
  :config
  (venv-initialize-interactive-shells)
  (venv-initialize-eshell))

(venv-workon "coog")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (helpful virtualenvwrapper company projectile yasnippet-classic-snippets yasnippet-snippets yasnippet smartparens org-bullets git-gutter git-timemachine magit which-key flycheck counsel aggressive-indent hungry-delete doom-modeline solarized-theme use-package)))
 '(solarized-distinct-fringe-background t)
 '(solarized-high-contrast-mode-line nil)
 '(solarized-use-more-italic t)
 '(sp-escape-quotes-after-insert nil)
 '(x-underline-at-descent-line t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
