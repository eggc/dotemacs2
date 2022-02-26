(use-package projectile
  :config
  (setq projectile-project-search-path '("~/"))
  (setq projectile-use-git-grep t)
  (projectile-mode +1)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  ("s-ｐ" . projectile-command-map)
  ("s-p" . projectile-command-map))

(use-package projectile-rails
  :after (projectile)
  :config
  (projectile-rails-global-mode))

(provide 'eg-projectile)
