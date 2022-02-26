(require 'use-package)

(use-package go-mode
  :config
  (add-to-list 'company-backends 'company-go)
  :init
  (defun go-mode-custom-hook () (setq-local tab-width 4))
  :hook
  (go-mode . go-mode-custom-hook))

(provide 'eg-go)
