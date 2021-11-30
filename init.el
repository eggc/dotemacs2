(load "~/work/dotemacs2/bootstrap")
(eg-load "global-keybind")
(eg-load "global-ui")
(eg-load "functions")

(package-initialize)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package use-package-chords
  :ensure t
  :config (key-chord-mode 1))

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x))
  :config
  (setq exec-path-from-shell-arguments ())
  (exec-path-from-shell-initialize))

;; (use-package flycheck
;;   :ensure t
;;   :init (global-flycheck-mode))

(use-package tree-sitter
  :config
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
  (global-tree-sitter-mode))
(use-package tree-sitter-langs)

(eg-load "built-in")
(eg-load "vertico")
(eg-load "consult")
(eg-load "ruby")
(eg-load "typescript")
(eg-load "git")
(eg-load "ui")
(eg-load "migemo")
(eg-load "lsp")

(use-package coffee-mode
  :config
  (add-hook 'coffee-mode-hook (lambda()
    (setq coffee-tab-width 2))
))

(use-package wgrep
  :config
  (setf wgrep-enable-key "r")
  (setq wgrep-auto-save-buffer t)
  (defvar my-ignore-directories '("node_modules" ".bundle" "yardoc" "coverage" "log" "tmp"))
  (defvar my-ignore-files '("*.min.js" "*.log" "*bundle.js"))
  (setq grep-find-ignored-directories (append grep-find-ignored-directories my-ignore-directories))
  (setq grep-find-ignored-files (append grep-find-ignored-files my-ignore-files))
)

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

(use-package browse-at-remote)

(use-package direnv
  :if (file-exists-p "/usr/local/bin/direnv")
  :mode ("\\.env$" . sh-mode)
  :config
  (setq direnv-always-show-summary nil)
  (direnv-mode))

(use-package key-chord
  :config
  (setq key-chord-two-keys-delay 0.04)
  :chords (("i9" . insert-current-date)
           ("fp" . file-full-path-org-link-to-clipboard)
           ("kj" . view-mode)))

(use-package ripgrep
  :if (file-exists-p "/usr/local/bin/rg")
  :config
  (defun ripgrep-regexp-with-arguments (regexp directory args)
  (interactive
    (list (read-from-minibuffer "Ripgrep search for: ")
          (read-directory-name "Directory: ")
          (read-from-minibuffer "optional arguments: ")))
    (ripgrep-regexp regexp directory (list args))))

(use-package dumb-jump
  :config
  (setq dumb-jump-max-find-time 5)
  :init
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
  :chords (("dj" . xref-find-definitions)))

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
  (yaml-mode . yaml-mode-outline-hook)
  :init
  (defun yaml-outline-level ()
    "Return the outline level based on the indentation, hardcoded at 2 spaces."
    (s-count-matches "[ ]\\{2\\}" (match-string 0)))
  (defun yaml-mode-outline-hook ()
    (outline-minor-mode)
    (setq outline-regexp "^\\([ ]\\{2\\}\\)*\\([-] \\)?\\([\"][^\"]*[\"]\\|[a-zA-Z0-9_-]*\\): *\\([>|]\\|&[a-zA-Z0-9_-]*\\)?$")
    (setq outline-level 'yaml-outline-level))
  :config
  (define-key yaml-mode-map (kbd "TAB") 'outline-toggle-children))

(use-package go-mode
  :config
  (add-to-list 'company-backends 'company-go)
  :init
  (defun go-mode-custom-hook () (setq-local tab-width 4))
  :hook
  (go-mode . go-mode-custom-hook))

(use-package slim-mode)
(use-package string-inflection
  :chords (("cy" . string-inflection-ruby-style-cycle)))

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

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-comment-dwim ((t (:inherit nil :foreground "#ccccff" :height 1.0))))
 '(org-level-1 ((t (:inherit nil :foreground "#ae81ff" :height 1.0))))
 '(org-level-2 ((t (:inherit nil :foreground "#ccccff" :height 1.0))))
 '(org-link ((t (:inherit nil :foreground "#ffff55" :height 1.0)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(wgrep ripgrep yaml-mode web-mode use-package twittering-mode tide spaceline smex slim-mode rubocop rspec-mode restclient rebecca-theme rbenv projectile-rails paradox nvm key-chord jest idomenu ido-vertical-mode ido-completing-read+ gist forge exec-path-from-shell evil-string-inflection dumb-jump doom-modeline direnv dired-subtree dashboard csv-mode counsel coffee-mode atom-one-dark-theme)))
