(use-package magit
  :config
  (defvar magit-diff-refine-hunk t)
  ; magit をとにかく軽量にしたいので普段見ない情報は計算しない
  (remove-hook 'magit-status-sections-hook 'magit-insert-status-headers)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-upstream-or-recent)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-pushremote)
  (remove-hook 'magit-refs-sections-hook 'magit-insert-tags)
  (remove-hook 'server-switch-hook 'magit-commit-diff)
  :bind (("s-g" . magit-status)))

(use-package browse-at-remote
  :config
  (defun browse-at-remote--get-local-branch () "master") ;; master ブランチを常に見る
  (defun browse-at-remote--get-remotes () '("upstream")) ;; upstream リポジトリを常に見る
)

;; (use-package forge
;;   :after magit
;;   :config
;;   ;; (remove-hook 'magit-status-sections-hook 'forge-insert-pullreqs)
;;   ;; (remove-hook 'magit-status-sections-hook 'forge-insert-issues)
;;   (defvar forge-topic-list-columns
;;         '(("#" 5 forge-topic-list-sort-by-number (:right-align t) number nil)
;;           ("Assignees" 15 t nil assignees nil)
;;           ("Title" 35 t nil title  nil))))
