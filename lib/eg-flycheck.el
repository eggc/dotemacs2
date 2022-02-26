(use-package flycheck
  :hook
  (emacs-lisp-mode . flycheck-mode)
  :bind (("s-e" . flycheck-list-errors))
  :config
  (setq flycheck-emacs-lisp-load-path 'inherit)
  (custom-set-variables '(flycheck-ruby-rubocop-executable "rubocop-daemon-wrapper")))

(provide 'eg-flycheck)
