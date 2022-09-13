(require 'use-package)

(use-package flycheck
  :diminish flycheck-mode
  :hook
  (emacs-lisp-mode . flycheck-mode)
  :bind (("s-e" . flycheck-list-errors))
  :config
  (setq flycheck-emacs-lisp-load-path 'inherit)
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
)

(provide 'eg-flycheck)
