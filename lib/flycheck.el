(use-package flycheck
  :hook
  (ruby-mode . flycheck-mode)
  :config
  (custom-set-variables '(flycheck-ruby-rubocop-executable (concat dotemacs2-directory "bin/flycheck-ruby-rubocop.sh"))))
