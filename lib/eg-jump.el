(require 'use-package)

(use-package dumb-jump
  :config
  (setq dumb-jump-max-find-time 5)
  (setq dumb-jump-force-searcher 'rg)
  :init
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(provide 'eg-jump)
