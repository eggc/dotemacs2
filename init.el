(defconst eg-custom-load-path (or (getenv "EG_CUSTOM_LOAD_PATH") "~/private/dotemacs2/lib/"))
(defconst eg-deepl-api-key (getenv "EG_DEEPL_API_KEY"))
(defconst eg-enable-copilot (equal (getenv "EG_ENABLE_COPILOT") "1"))

(add-to-list 'load-path eg-custom-load-path)

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

(when eg-enable-copilot
  (use-package copilot
    :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
    :hook (prog-mode . copilot-mode)
    :bind (:map copilot-completion-map
                ("<tab>" . 'copilot-accept-completion)
                ("TAB" . 'copilot-accept-completion)
                ("C-TAB" . 'copilot-accept-completion-by-word)
                ("C-<tab>" . 'copilot-accept-completion-by-word)
                ("C-n" . 'copilot-next-completion)
                ("C-p" . 'copilot-previous-completion))
    :config
    (add-to-list 'copilot-indentation-alist '(prog-mode 2))
    (add-to-list 'copilot-indentation-alist '(org-mode 2))
    (add-to-list 'copilot-indentation-alist '(text-mode 2))
    (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2))
    (setopt copilot-max-char-warning-disable t)
    (setopt copilot-indent-offset-warning-disable t)
    )
  (use-package shell-maker)
  (use-package copilot-chat
    :straight (:host github :repo "chep/copilot-chat.el" :files ("*.el"))
    :after (request org markdown-mode shell-maker))
)

(when eg-deepl-api-key
  (use-package txl
    :straight (:host github :repo "tmalsburg/txl.el")
    :bind (("C-c t" . txl-translate-region-or-paragraph))
    :config
    (setq txl-languages '(JA . EN-US))
    (setq txl-deepl-api-key eg-deepl-api-key)
    (setq txl-deepl-api-url "https://api-free.deepl.com/v2/translate")
))
