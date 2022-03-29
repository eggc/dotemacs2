(require 'use-package)

(use-package flymake
  :bind (("M-g M-e" . flymake-goto-next-error)))

(provide 'eg-flymake)
