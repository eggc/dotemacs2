(require 'use-package)

; https://github.com/senny/rbenv.el
(use-package rbenv
  :commands rbenv--update-mode-line global-rbenv-mode
  :config
  ;; Do not show ruby version in the modeline
  (advice-add #'rbenv--update-mode-line :override (lambda ()))
  (global-rbenv-mode))

(use-package ruby-mode
  :ensure nil
  :config
  (setq ruby-insert-encoding-magic-comment nil)
  (setq ruby-deep-indent-paren-style nil)
  :mode ("\\Gemfile$" "\\Schemafile$" "\\Steepfile$" "\\ruby$" "\\rbs$" "\\.rake$"))

(use-package rubocop
  :diminish rubocop-mode
  :hook
  (ruby-mode . rubocop-mode)
  :bind (("C-c , R" . rubocop-autocorrect-current-file)
         ("C-c C-, C-r" . rubocop-autocorrect-current-file)))

(use-package rspec-mode
  :config
  (setq rspec-use-spring-when-possible nil)
  (setq compilation-scroll-output "first-error")
  (defun rspec-runner () "bin/rspec")
  ;; @see https://github.com/pezra/rspec-mode#debugging
  :hook
  (after-init . inf-ruby-switch-setup)
  :bind (("C-c C-, C-v" . rspec-verify)
         ("C-c C-, C-s" . rspec-verify-single))
  )

(use-package ruby-electric
  :diminish ruby-electric-mode
  :hook ((ruby-mode . ruby-electric-mode)))

(provide 'eg-ruby)
