(use-package rebecca-theme
  :config
  (load-theme 'rebecca t))

;; コメントのデフォルトカラーが暗くて見えないことがあるのでを少し明るくする
(set-face-foreground 'font-lock-comment-face "dark gray")

(use-package spaceline)
(use-package spaceline-config
  :ensure nil
  :config
  (spaceline-emacs-theme)
  (spaceline-toggle-minor-modes-off)
  (spaceline-toggle-version-control-off)
  (spaceline-toggle-global-off))

(use-package highlight-indent-guides
  :config
  (setq highlight-indent-guides-method 'bitmap)
  :hook
  (prog-mode . highlight-indent-guides-mode))
