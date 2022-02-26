(package-initialize)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'load-path "~/work/dotemacs2/lib/")

(require 'use-package)
(require 'use-package-ensure)
(setq use-package-always-ensure t)

(require 'eg-env)
(require 'eg-global-keybind)
(require 'eg-global-ui)
(require 'eg-functions)
(require 'eg-tree-sitter)
(require 'eg-built-in)
(require 'eg-vertico)
(require 'eg-consult)
(require 'eg-ui)
(require 'eg-git)
(require 'eg-ruby)
(require 'eg-typescript)
(require 'eg-lsp)
(require 'eg-grep)
;; (require 'eg-flycheck)
;; (require 'eg-apheleia)

(use-package coffee-mode
  :config
  (add-hook 'coffee-mode-hook (lambda()
    (setq coffee-tab-width 2))
))


(use-package projectile
  :config
  (setq projectile-project-search-path '("~/"))
  (setq projectile-use-git-grep t)
  (projectile-mode +1)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  ("s-ｐ" . projectile-command-map)
  ("s-p" . projectile-command-map))

(use-package projectile-rails
  :after (projectile)
  :config
  (projectile-rails-global-mode))

(use-package dashboard
  :config
  (setq dashboard-set-init-info t)
  (dashboard-setup-startup-hook))

(use-package company
  :init (global-company-mode)
  :bind (("C-M-i" . company-complete)))

(use-package dumb-jump
  :config
  (setq dumb-jump-max-find-time 5)
  :init
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(use-package paradox
 :custom
 (paradox-github-token t))

(use-package js
  :config
  (setq js-indent-level 2))

(use-package yasnippet
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-global-mode 1)
  :bind (("s-y" . yas-insert-snippet)))

(use-package yaml-mode
  :mode (".yaml$")
  :hook
  (yaml-mode . yaml-mode-outline-hook))

(use-package go-mode
  :config
  (add-to-list 'company-backends 'company-go)
  :init
  (defun go-mode-custom-hook () (setq-local tab-width 4))
  :hook
  (go-mode . go-mode-custom-hook))

(use-package slim-mode)

(use-package string-inflection
  :bind (("C-x C-y" . string-inflection-ruby-style-cycle)))

(use-package rotate)
(use-package graphql-mode)

;; (use-package nvm
;;   :config
;;   (nvm-use "v10.19.0"))

;; https://skoji.jp/blog/2020/01/plantuml.html
(use-package plantuml-mode
  :mode ("\\.plantuml\\'" "\\.uml\\'")
  :config
  (setq plantuml-executable-path "plantuml")
  (setq plantuml-default-exec-mode 'executable)
  (setq plantuml-output-type "png")
  (setq plantuml-executable-args (append plantuml-executable-args '("-charset" "UTF-8"))))

(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode))

(use-package nginx-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(yasnippet yaml-mode yaml wgrep web-mode vertico use-package-chords twittering-mode tree-sitter-langs tide spaceline smex smartparens slim-mode ruby-electric rubocop rspec-mode rotate ripgrep restclient rebecca-theme rbenv projectile-rails plantuml-mode paradox org-superstar orderless nvm nginx-mode markdown-mode magit jest idomenu ido-vertical-mode ido-completing-read+ highlight-indent-guides graphql-mode go-mode gist ghub exec-path-from-shell evil-string-inflection eglot dumb-jump doom-modeline direnv dired-subtree dashboard csv-mode counsel consult company coffee-mode closql browse-at-remote beacon atom-one-dark-theme apheleia)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-headline-done ((t (:foreground "gray"))))
 '(org-level-1 ((t (:height 1.0))))
 '(org-level-2 ((t (:height 1.0))))
 '(org-link ((t (:foreground "lightblue")))))
