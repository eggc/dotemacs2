(require 'use-package)

(use-package tree-sitter
  :config
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))
(use-package tree-sitter-langs)

(provide 'eg-tree-sitter)
