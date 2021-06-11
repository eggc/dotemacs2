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
