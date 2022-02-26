(require 'use-package)

(use-package js
  :config
  (setq js-indent-level 2))

(use-package coffee-mode
  :config
  (add-hook 'coffee-mode-hook (lambda()
    (setq coffee-tab-width 2))
))

(provide 'eg-js)
