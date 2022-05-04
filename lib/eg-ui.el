(require 'use-package)

(use-package rebecca-theme
  :config
  (load-theme 'rebecca t))

;; コメントのデフォルトカラーが暗くて見えないことがあるのでを少し明るくする
(set-face-foreground 'font-lock-comment-face "dark gray")

(use-package dashboard
  :config
  (setq dashboard-set-init-info t)
  (dashboard-setup-startup-hook))

(use-package spaceline)
(use-package spaceline-config
  :ensure nil
  :config
  (spaceline-emacs-theme)
  (spaceline-toggle-minor-modes-off)
  (spaceline-toggle-version-control-off)
  (spaceline-toggle-global-off))

(use-package highlight-indent-guides
  :hook
  (prog-mode . highlight-indent-guides-mode))

(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode))

(use-package auto-dim-other-buffers
  :config
  (auto-dim-other-buffers-mode))

(provide 'eg-ui)
