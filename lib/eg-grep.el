(require 'use-package)

(use-package wgrep
  :config
  (setf wgrep-enable-key "r")
  (setq wgrep-auto-save-buffer t)
  (defvar my-ignore-directories '("node_modules" ".bundle" "yardoc" "coverage" "log" "tmp"))
  (defvar my-ignore-files '("*.min.js" "*.log" "*bundle.js"))
  (setq grep-find-ignored-directories (append grep-find-ignored-directories my-ignore-directories))
  (setq grep-find-ignored-files (append grep-find-ignored-files my-ignore-files))
)

(use-package ripgrep
  :if (file-exists-p "/usr/local/bin/rg")
  :config
  (defun ripgrep-regexp-with-arguments (regexp directory args)
  (interactive
    (list (read-from-minibuffer "Ripgrep search for: ")
          (read-directory-name "Directory: ")
          (read-from-minibuffer "optional arguments: ")))
    (ripgrep-regexp regexp directory (list args))))

(provide 'eg-grep)
