(use-package ruby-mode
  :ensure nil
  :config
  (setq ruby-insert-encoding-magic-comment nil)
  (setq ruby-deep-indent-paren-style nil)
  :mode ("\\Gemfile$" "\\Schemafile$" "\\Steepfile$" "\\ruby$" "\\rbs$" "\\.rake$")
  :init
  (defun ruby-mode-custom-hook ()
    (interactive)
    ;; https://qiita.com/eggc/items/718dd41fa778b91f302e
    (defalias '~ruby-syntax-propertize-function
      (syntax-propertize-rules
       ;; 文字列2重展開があるとシンタックスハイライトがおかしくなるので、 ruby-expression-expansion-re を修正したやつを追加
       ("\\(?:[^\\]\\|\\=\\)\\(\\\\\\\\\\)*\\(#{[^{^}]*#{[^}]*}[^}]*}\\)\\|\\(#\\({[^}\n\\\\]*\\(\\\\.[^}\n\\\\]*\\)*}\\|\\(\\$\\|@\\|@@\\)\\(\\w\\|_\\)+\\|\\$[^a-zA-Z \n]\\)\\)"
        (0 (ignore (ruby-syntax-propertize-expansion))))))
    (add-function :before (local 'syntax-propertize-function) '~ruby-syntax-propertize-function))
  :hook (ruby-mode . ruby-mode-custom-hook))

(use-package rubocop
  :hook
  (ruby-mode . rubocop-mode)
  :bind (("C-c , R" . rubocop-autocorrect-current-file)
         ("C-c C-, C-r" . rubocop-autocorrect-current-file)))

(use-package rspec-mode
  :config
  (setq rspec-use-spring-when-possible nil)
  (setq compilation-scroll-output "first-error")
  (defun rspec-runner () "bin/rspec")
  ;; @see https://github.com/pezra/rspec-mode#debugging
  :hook
  (after-init . inf-ruby-switch-setup)
  :bind (("C-c C-, C-v" . rspec-verify)
         ("C-c C-, C-s" . rspec-verify-single))
  )

(use-package ruby-electric
  :hook ((ruby-mode . ruby-electric-mode)))

; https://github.com/senny/rbenv.el
(use-package rbenv
  :config
  (setq rbenv-show-active-ruby-in-modeline nil)
  (global-rbenv-mode))
