(require 'use-package)

(use-package magit
  :functions
  magit-status-sections-hook
  magit-refs-sections-hook
  :commands
  magit-insert-status-headers
  magit-insert-unpushed-to-upstream-or-recent
  magit-insert-unpushed-to-pushremote
  magit-insert-tags
  :config
  (defvar magit-diff-refine-hunk t)
  ; magit をとにかく軽量にしたいので普段見ない情報は計算しない
  (remove-hook #'magit-status-sections-hook #'magit-insert-status-headers)
  (remove-hook #'magit-status-sections-hook #'magit-insert-unpushed-to-upstream-or-recent)
  (remove-hook #'magit-status-sections-hook #'magit-insert-unpushed-to-pushremote)
  (remove-hook #'magit-refs-sections-hook   #'magit-insert-tags)
  (defun git-commit-mode-hooks () (setq fill-column 120))
  (add-hook 'git-commit-mode-hook 'git-commit-mode-hooks)
  :bind (("s-g" . magit-status)))

(use-package browse-at-remote
  :commands
  browse-at-remote--get-local-branch
  browse-at-remote--get-remotes
)

(provide 'eg-git)
