(defun set-current-status (status)
  (if status (defvar *current-status* status))
  (message "%s..." *current-status*))

;; comando para abrir este arquivo de dotfile
(defun dotfile ()
  "Opens the dotfile for editing"
  (interactive)
  (find-file "~/.emacs.d/init.el"))


(set-current-status "Inicializando")
(setq inhibit-startup-message t)
(tool-bar-mode -1) ;; tira toolbar
(menu-bar-mode -1) ;; tira barra de menu
(scroll-bar-mode -1) ;; tira barra de scroll
(global-hl-line-mode t) ;; marca linha do cursor
(line-number-mode t) ;; mostra linhas
(show-paren-mode 1) ;; mostra o parenteses do outro lado
(global-linum-mode t) ;; set nu do emacs
(electric-pair-mode 1) ;; autoclose dos bgl
(setq make-backup-files nil) ;; desativa aqueles arquivos que comecam com ~
(setq auto-save-default nil) ;; desativa aqueles #arquivos#

(set-current-status "Configurando coisas básicas como o gerenciador de pacotes")
;; melpa
(require 'package)
(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/")
	     t)
(add-to-list 'package-archives
	     '("org" . "https://orgmode.org/elpa/")
	     t)

;; bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; tema
(message "Configurando tema...")
(use-package atom-one-dark-theme
  :ensure t
  :config
  (load-theme 'atom-one-dark t))

(set-current-status "Configurando outros plugins")
;; undo-tree
(use-package undo-tree 
  :ensure t
  :config
  (global-undo-tree-mode))

(use-package company 
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package company-lsp 
  :ensure t
  :after company
  :init
  (push 'company-lsp company-backends)
  (setq company-lsp-async t)
  )

(use-package lsp-mode
  :ensure t
  :config
  (add-hook 'after-init-hook #'lsp-deferred))

(use-package company-quickhelp 
  :ensure t
  :after company)

;; slime
(use-package slime 
  :ensure t
  :config
  (setq inferior-lisp-program "sbcl") ;; qual interpretador o slime vai chamar
  )

;; autocomplete slime
(use-package slime-company 
  :ensure t
  :after (slime company)
  :config
  (setq slime-company-completion 'fuzzy)
  (setq slime-company-after-completion 'slime-company-just-one-space))

;; python
(use-package elpy 
  :ensure t
  :after (company)
  :init
  (elpy-enable))

;; clojure
;; C-c C-k dá eval no buffer no REPL

(use-package cider 
  :ensure t
  :after (company)
  :init
  (add-hook 'cider-repl-mode-hook #'company-mode)
  (add-hook 'cider-mode-hook #'company-mode)
  (setq cider-show-error-buffer 'only-in-repl))

;; yasnippet
(use-package yasnippet 
  :ensure t
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)

;; configurar evil mode se ativado
(set-current-status "Evil-mode") 
(use-package evil 
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-commentary 
  :ensure t
  :after evil
  :config
  (evil-commentary-mode))

(use-package evil-collection 
  :ensure t
  :after evil
  :config
  (evil-collection-init))

(set-current-status "Configurando org-mode")
(use-package org
  :ensure t)

(use-package evil-org
  :ensure t
  :after (org evil)
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
	    (lambda ()
	      (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;; smex: M-x melhorado
(use-package smex 
  :ensure t
  :config
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  ;; M-x antigo
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
  )

(set-current-status "Configurando dashboard")
(use-package all-the-icons
  :ensure t
  :init
  (setq inhibit-compacting-font-caches t)) ;; icones

(use-package all-the-icons-dired 
  :ensure t
  :after all-the-icons
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
  (add-hook 'dired-mode-hook 'dired-hide-details-mode))

(use-package dired-toggle
  :ensure t
  :bind (
	 ("<f3>" . #'dired-toggle))
  :config
  (setq dired-toggle-window-size 32)
  (setq dired-toggle-window-side 'left))

(use-package dashboard 
  :ensure t
  :after all-the-icons
  :config
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content t)
  (setq dashboard-show-shortcuts nil)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (dashboard-setup-startup-hook))

(use-package fzf
  :ensure t)

(set-current-status "Pronto")
