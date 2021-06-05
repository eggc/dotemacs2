(load "~/work/dotemacs2/bootstrap")
(eg-load "global-keybind")
(eg-load "global-ui")
(eg-load "functions")

(package-initialize)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x))
  :config
  (setq exec-path-from-shell-arguments ())
  (exec-path-from-shell-initialize))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(eg-load "ruby")

(use-package use-package-chords
  :ensure t
  :config (key-chord-mode 1))

(use-package replace
  :ensure nil
  :config
  (add-hook 'occur-mode-hook (lambda ()
  (next-error-follow-minor-mode)
  (local-set-key (kbd "n") 'next-line)
  (local-set-key (kbd "p") 'previous-line))))

(use-package rebecca-theme
  :config
  (load-theme 'rebecca t))

(use-package view
  :ensure nil
  :bind (:map view-mode-map
              ("j" . next-line)
              ("k" . previous-line)
              ("i" . view-mode)))

(use-package org
  :ensure nil
  :config
  (add-hook 'org-mode-hook (lambda ()
  (setq org-hide-leading-stars t)
  (setq org-hide-emphasis-markers t)
  (setq org-indent-indentation-per-level 8)
  (setq org-todo-keywords '((sequence "TODO" "DOING" "|" "DONE")))
  (local-unset-key (kbd "M-h"))
  (local-unset-key (kbd "C-M-t"))
  (org-indent-mode t))))

(use-package recentf
  :config
  (setq recentf-max-saved-items 3000)
  (setq recentf-auto-cleanup 'never)
  (recentf-mode 1))

(use-package ivy
  :config
  (setq counsel-find-file-at-point t)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-height 20)
  (ivy-mode)
  :custom
  (ivy-initial-inputs-alist nil))

(use-package counsel
  :config
  (counsel-mode))

(use-package ivy-xref
  :init
  (setq xref-show-definitions-function #'ivy-xref-show-defs)
  (setq xref-show-xrefs-function #'ivy-xref-show-xrefs)
  (setq ivy-xref-use-file-path t))

(use-package dired
  :ensure nil
  :config
  (setq dired-use-ls-dired nil)
  (setq dired-dwim-target t) ; 2個のdiredバッファがある時、コピー/移動先のパスを他方のバッファにする
  (unbind-key "C-t" dired-mode-map)
  :bind (:map dired-mode-map
              ("j" . 'dired-next-line)
              ("k" . 'dired-previous-line)
              ("<tab>" . 'dired-subtree-insert)
              ("<backtab>" . 'dired-subtree-remove)
              ("h" . 'dired-subtree-remove)
              ("r" . 'wdired-change-to-wdired-mode)))
(use-package dired-subtree)
(use-package wdired)

(use-package coffee-mode
  :config
  (add-hook 'coffee-mode-hook (lambda()
    (setq coffee-tab-width 2))
))

(use-package wgrep
  :config
  (setf wgrep-enable-key "r")
  (setq wgrep-auto-save-buffer t)
  (setq my-ignore-directories '("node_modules" ".bundle" "yardoc" "coverage" "log" "tmp"))
  (setq my-ignore-files '("*.min.js" "*.log" "*bundle.js"))
  (setq grep-find-ignored-directories (append grep-find-ignored-directories my-ignore-directories))
  (setq grep-find-ignored-files (append grep-find-ignored-files my-ignore-files))
)

(use-package projectile
  :config
  (setq projectile-project-search-path '("~/"))
  (setq projectile-completion-system 'ivy)
  (setq projectile-use-git-grep t)
  (projectile-mode +1)
  :bind-keymap
  ("C-c p" . projectile-command-map)
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

(use-package magit
  :config
  (setq magit-completing-read-function 'ivy-completing-read)
  (setq magit-diff-refine-hunk t)
  (remove-hook 'magit-refs-sections-hook 'magit-insert-tags)
  (remove-hook 'server-switch-hook 'magit-commit-diff)
  :chords (("gh" . magit-status))
)

(use-package forge
  :after magit
  :config
  ;; (remove-hook 'magit-status-sections-hook 'forge-insert-pullreqs)
  ;; (remove-hook 'magit-status-sections-hook 'forge-insert-issues)
  (setq forge-topic-list-columns
        '(("#" 5 forge-topic-list-sort-by-number (:right-align t) number nil)
          ("Assignees" 15 t nil assignees nil)
          ("Title" 35 t nil title  nil))))

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
  (setq dumb-jump-selector 'ivy)
  (setq dumb-jump-max-find-time 5)
  :init
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
  :chords (("dj" . xref-find-definitions)
           ("p@" . dumb-jump-go-prompt)))

(use-package spaceline)
(use-package spaceline-config
  :ensure nil
  :config
  (spaceline-emacs-theme)
  (spaceline-toggle-minor-modes-off)
  (spaceline-toggle-version-control-off)
)

(use-package paradox
 :custom
 (paradox-github-token t))

(use-package web-mode
  :config
  (setq web-mode-content-types-alist '(("jsx"  . ".js[x]?\\'")))
  (add-hook 'web-mode-hook (lambda()
    (setq web-mode-code-indent-offset 2)
    (setq web-mode-markup-indent-offset 2)))
  :mode ("\\.js[x]?$"))

(use-package eww
  :config
  (setq eww-search-prefix "http://www.google.co.jp/search?q="))

(use-package js
  :config
  (setq js-indent-level 2))

(use-package typescript-mode)
(use-package tide
  :after (typescript-mode company)
  :init
  (defun setup-tide-mode ()
    (interactive)
    (tide-setup)
    (flycheck-mode +1)
    (setq flycheck-check-syntax-automatically '(save mode-enabled))
    (setq company-tooltip-align-annotations t)
    (setq typescript-indent-level 2)
    (eldoc-mode +1)
    (tide-hl-identifier-mode +1)
    (company-mode +1))
  :hook
  (before-save . tide-format-before-save)
  (typescript-mode . setup-tide-mode))

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

(use-package beacon)
(use-package pulse
  :after beacon
  :config
  (defun pulse-line (&rest _)
    "Pulse the current line."
    (pulse-momentary-highlight-one-line (point)))

  (dolist (command '(scroll-up-command scroll-down-command
                                       recenter-top-bottom other-window))
    (advice-add command :after #'pulse-line)))

;; (use-package lsp-mode
;;   :if (executable-find "solargraph")
;;   :init (setq lsp-keymap-prefix "M-p")
;;   :hook ((ruby-mode . lsp))
;;   :commands lsp)

;; (use-package lsp-ui :commands lsp-ui-mode)
;; (use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;; (use-package which-key :config (which-key-mode))

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
   '(wgrep ripgrep yaml-mode web-mode use-package twittering-mode tide spaceline smex slim-mode rubocop rspec-mode rjsx-mode restclient rebecca-theme rbenv projectile-rails paradox nvm key-chord jest idomenu ido-vertical-mode ido-completing-read+ gist forge exec-path-from-shell evil-string-inflection dumb-jump doom-modeline direnv dired-subtree dashboard csv-mode counsel coffee-mode atom-one-dark-theme)))
