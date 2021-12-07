;; https://github.com/raxod502/apheleia

(use-package apheleia
  :config
  (add-to-list 'apheleia-formatters '(rubocop "emacs-apheleia-rubocop" filepath))
  (add-to-list 'apheleia-mode-alist '(ruby-mode . rubocop))
  :hook
  (typescript-mode . apheleia-mode)
  (tsx-mode . apheleia-mode)
  (ruby-mode . apheleia-mode))
