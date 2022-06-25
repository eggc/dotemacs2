(require 'use-package)

(use-package rebecca-theme
  :config
  (load-theme 'rebecca t))

;; コメントのデフォルトカラーが暗くて見えないことがあるのでを少し明るくする
(set-face-foreground 'font-lock-comment-face "dark gray")

(use-package diminish)
(advice-add 'vc-git-mode-line-string :override (lambda (file) ""))

(use-package dashboard
  :config
  (setq dashboard-set-init-info t)
  (dashboard-setup-startup-hook))

(use-package highlight-indent-guides
  :diminish highlight-indent-guides-mode
  :hook
  (prog-mode . highlight-indent-guides-mode))

(use-package smartparens
  :diminish smartparens-mode
  :config
  (require 'smartparens-config)
  (smartparens-global-mode))

(use-package auto-dim-other-buffers
  :config
  (auto-dim-other-buffers-mode))

(provide 'eg-ui)
