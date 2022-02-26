(use-package yasnippet
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-global-mode 1)
  :bind (("s-y" . yas-insert-snippet)))

(provide 'eg-snippet)
