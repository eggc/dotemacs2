; built-in packages
(require 'use-package)

(use-package replace
  :ensure nil
  :config
  (add-hook 'occur-mode-hook (lambda ()
  (next-error-follow-minor-mode)
  (local-set-key (kbd "n") 'next-line)
  (local-set-key (kbd "p") 'previous-line))))

(use-package view
  :ensure nil
  :bind (:map view-mode-map
              ("j" . next-line)
              ("k" . previous-line)
              ("i" . view-mode)))

(use-package org
  :ensure nil
  :custom-face
  (org-level-1 ((t (:height 1.0))))
  (org-level-2 ((t (:height 1.0))))
  (org-link ((t (:foreground "lightblue"))))
  (org-headline-done ((t (:foreground "gray"))))
  :config
  (setq org-src-tab-acts-natively nil)
  (setq org-hide-leading-stars t)
  (setq org-hide-emphasis-markers t)
  (defvar org-indent-indentation-per-level 8)
  (add-hook 'org-mode-hook (lambda ()
  (local-unset-key (kbd "M-h"))
  (local-unset-key (kbd "C-M-t"))
  (org-indent-mode t))))

(use-package recentf
  :ensure nil
  :config
  (setq recentf-max-saved-items 3000)
  (setq recentf-auto-cleanup 'never)
  (recentf-mode 1))

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

(use-package eww
  :config
  (setq eww-search-prefix "http://www.google.co.jp/search?q="))

(use-package dired-subtree)

(use-package wdired)

(use-package flyspell
  :config
  (setq-default ispell-program-name "aspell"))

(provide 'eg-built-in)
