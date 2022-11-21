(require 'use-package)

(use-package yaml-mode
  :mode (".yaml$")
  :hook
  (yaml-mode . highlight-indentation-mode))

(provide 'eg-yaml)
