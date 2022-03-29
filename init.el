(add-to-list 'load-path "~/work/dotemacs2/lib/")

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

(use-package imenu-list)
(use-package string-inflection :bind (("C-x C-y" . string-inflection-ruby-style-cycle)))
