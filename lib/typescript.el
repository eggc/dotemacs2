(use-package typescript-mode
  :mode ("\\.ts[x]?$"))
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
