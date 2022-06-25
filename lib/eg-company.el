(require 'use-package)

(use-package company
  :diminish company-mode
  :init (global-company-mode)
  :bind (("C-M-i" . company-complete)))

(provide 'eg-company)
