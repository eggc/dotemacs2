(use-package yaml-mode
  :mode (".yaml$")
  :hook
  (yaml-mode . yaml-mode-outline-hook))

(provide 'eg-yaml)
