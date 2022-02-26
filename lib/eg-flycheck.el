(use-package flycheck
  :hook
  (ruby-mode . flycheck-mode)
  :config
  (custom-set-variables '(flycheck-ruby-rubocop-executable "rubocop-daemon-wrapper")))

(provide 'eg-flycheck)
