(use-package typescript-mode
  :config
  (setq typescript-indent-level 2)
  :mode (".ts$"))

;; No major mode support TSX
;; Create tsx-mode by extend web-mode
(use-package web-mode
  :after (tree-sitter tree-sitter-langs)
  :config
  (add-hook 'web-mode-hook (lambda()
    (setq web-mode-code-indent-offset 2)
    (setq web-mode-markup-indent-offset 2)))
  (define-derived-mode tsx-mode web-mode "TypeScript[TSX]")
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-mode))
  (add-to-list 'tree-sitter-major-mode-language-alist '(tsx-mode . tsx)))

(provide 'eg-typescript)
