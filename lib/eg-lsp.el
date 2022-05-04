(require 'use-package)

(use-package eglot
  :config
  (add-to-list 'eglot-server-programs '(typescript-mode . ("~/.yarn/bin/typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs '(tsx-mode . ("~/.yarn/bin/typescript-language-server" "--stdio")))
  :hook
  (typescript-mode . eglot-ensure)
  (tsx-mode . eglot-ensure))

(provide 'eg-lsp)
