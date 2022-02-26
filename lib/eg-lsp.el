(use-package eglot
  :config
  (add-to-list 'eglot-server-programs '(typescript-mode . ("/Users/eguchi.ken/.nvm/versions/node/v12.19.0/bin/typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs '(tsx-mode . ("/Users/eguchi.ken/.nvm/versions/node/v12.19.0/bin/typescript-language-server" "--stdio")))
  :hook
  (typescript-mode . eglot-ensure)
  (tsx-mode . eglot-ensure))

(provide 'eg-lsp)
