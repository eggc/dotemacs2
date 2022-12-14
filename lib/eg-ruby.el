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
  :config
  (setq rubocop-autocorrect-command "rubocop -A --format emacs")
  :hook
  (ruby-mode . rubocop-mode)
  :bind (("C-c , R" . rubocop-autocorrect-current-file)
         ("C-c C-, C-r" . rubocop-autocorrect-current-file)))

(defun rspec-specize-file-name-advice (args)
  "controller からテストファイルを探索する時に request spec に移動するパッチ"
  (let ((file-name (nth 0 args)))
    (setq file-name (string-replace "/controllers/" "/requests/" file-name))
    (setq file-name (string-replace "_controller.rb" ".rb" file-name))
    (list file-name)
    ))

(defun rspec-targetize-file-name-advice (args)
  "request spec からプロダクトコードを探索する時に controller に移動するパッチ"
  (let ((file-name (nth 0 args)) (extension (nth 1 args)))
    (setq file-name (string-replace "/requests/" "/controllers/" file-name))
    (setq file-name (string-replace "_spec" "_controller" file-name))
    (list file-name extension)
    ))

(use-package rspec-mode
  :config
  (setq rspec-use-spring-when-possible nil)
  (setq compilation-scroll-output "first-error")
  (defun rspec-runner () "bin/rspec")
  (advice-add 'rspec-specize-file-name :filter-args 'rspec-specize-file-name-advice)
  (advice-add 'rspec-targetize-file-name :filter-args 'rspec-targetize-file-name-advice)
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
