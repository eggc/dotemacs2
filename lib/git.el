(use-package magit
  :config
  (defvar magit-diff-refine-hunk t)
  (remove-hook 'magit-refs-sections-hook 'magit-insert-tags)
  (remove-hook 'server-switch-hook 'magit-commit-diff)
  :chords (("gh" . magit-status)))

;; (use-package forge
;;   :after magit
;;   :config
;;   ;; (remove-hook 'magit-status-sections-hook 'forge-insert-pullreqs)
;;   ;; (remove-hook 'magit-status-sections-hook 'forge-insert-issues)
;;   (defvar forge-topic-list-columns
;;         '(("#" 5 forge-topic-list-sort-by-number (:right-align t) number nil)
;;           ("Assignees" 15 t nil assignees nil)
;;           ("Title" 35 t nil title  nil))))
