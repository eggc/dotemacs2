(require 'use-package)

(use-package magit
  :config
  (defvar magit-diff-refine-hunk t)
  ; magit をとにかく軽量にしたいので普段見ない情報は計算しない
  (remove-hook #'magit-status-sections-hook #'magit-insert-status-headers)
  (remove-hook #'magit-status-sections-hook #'magit-insert-unpushed-to-upstream-or-recent)
  (remove-hook #'magit-status-sections-hook #'magit-insert-unpushed-to-pushremote)
  (remove-hook #'magit-refs-sections-hook   #'magit-insert-tags)
  (remove-hook #'server-switch-hook         #'magit-commit-diff)
  :bind (("s-g" . magit-status)))

(use-package browse-at-remote
  :config
  (advice-add #'browse-at-remote--get-local-branch :override (lambda () "master")) ;; master ブランチを常に見る
  (advice-add #'browse-at-remote--get-remotes :override (lambda () '("upstream"))) ;; upstream リポジトリを常に見る
)

(provide 'eg-git)
