(use-package rebecca-theme
  :config
  (load-theme 'rebecca t))

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

