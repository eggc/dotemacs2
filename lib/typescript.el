(use-package typescript-mode
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


(use-package tide
  :after (typescript-mode company)
  :config
  (setq tide-format-options
        '(
          :insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis nil
          :insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets nil
          :insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces nil
          ))
  :init
  (defun setup-tide-mode ()
    (interactive)
    (tide-setup)
    (flycheck-mode +1)
    (setq flycheck-check-syntax-automatically '(save mode-enabled))
    (setq company-tooltip-align-annotations t)
    (setq typescript-indent-level 2)
    (eldoc-mode +1)
    (tide-hl-identifier-mode +1)
    (company-mode +1))
  :hook
  (before-save . tide-format-before-save)
  (typescript-mode . setup-tide-mode))
