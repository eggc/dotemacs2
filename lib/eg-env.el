(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x))
  :config
  (exec-path-from-shell-initialize))

(use-package direnv
  :if (file-exists-p "/usr/local/bin/direnv")
  :mode ("\\.env$" . sh-mode)
  :config
  (setq direnv-always-show-summary nil)
  (direnv-mode))

(provide 'eg-env)
