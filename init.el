(add-to-list 'load-path "~/work/dotemacs2/lib/")

;; https://github.com/radian-software/straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(require 'eg-package)
(require 'eg-functions)
(require 'eg-global-keybind)
(require 'eg-global-ui)
(require 'eg-env)
(require 'eg-tree-sitter)
(require 'eg-built-in)
(require 'eg-vertico)
(require 'eg-consult)
(require 'eg-ui)
(require 'eg-git)
(require 'eg-ruby)
(require 'eg-go)
(require 'eg-js)
(require 'eg-typescript)
(require 'eg-shellscript)
(require 'eg-lsp)
(require 'eg-yaml)
(require 'eg-uml)
(require 'eg-grep)
(require 'eg-projectile)
(require 'eg-company)
(require 'eg-jump)
(require 'eg-snippet)
(require 'eg-flymake)
(require 'eg-flycheck)


;; (require 'eg-apheleia)

(use-package graphql-mode)
(use-package nginx-mode)
(use-package slim-mode)
(use-package markdown-mode)
(use-package dockerfile-mode)

(use-package imenu-list :config (setq imenu-max-item-length 256))
(use-package string-inflection :bind (("C-x C-y" . string-inflection-ruby-style-cycle)))
(use-package atomic-chrome :config (atomic-chrome-start-server))

(when (getenv "EMACS_ENABLE_COPILOT")
  (use-package copilot :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))))
