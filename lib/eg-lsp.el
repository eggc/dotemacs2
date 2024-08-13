(require 'use-package)
(require 'lsp-mode)
(require 'lsp-ruby-lsp)

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "s-l")
  (setq lsp-disabled-clients '(rubocop-ls))
  (setq lsp-headerline-breadcrumb-enable nil)
  :hook
  ((ruby-mode . lsp)
   (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :config
  (defun lsp-ruby-lsp--execute-command (command buffer-name)
    (let* ((default-directory (lsp-workspace-root))
           (buffer (progn
                     (when (get-buffer buffer-name) (kill-buffer buffer-name))
                     (generate-new-buffer buffer-name))))
      (async-shell-command command buffer)))
  (defun lsp-ruby-lsp--open-file (arg_hash)
    "Open file for ruby-lsp-rails"
    (let* ((arguments (gethash "arguments" arg_hash))
           (uri (aref (aref arguments 0) 0))
           (path-with-line-number (split-string (lsp--uri-to-path uri) "#L"))
           (path (car path-with-line-number))
           (line-number (cadr path-with-line-number)))
      (find-file path)
      (when line-number (forward-line (1- (string-to-number line-number))))))
  (defun lsp-ruby-lsp--run-test (arg_hash)
    "Run test for ruby-lsp-rails"
    (let* ((arguments (gethash "arguments" arg_hash))
           (command (aref arguments 2)))
      (lsp-ruby-lsp--execute-command command "*ruby-lsp run test*")))
  (defun lsp-ruby-lsp--run-task (arg_hash)
    "Run test for ruby-lsp-rails"
    (let* ((arguments (gethash "arguments" arg_hash))
           (command (aref arguments 0)))
      (lsp-ruby-lsp--execute-command command "*ruby-lsp run task*")))

  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection #'lsp-ruby-lsp--build-command)
    :activation-fn (lsp-activate-on "ruby")
    :priority 100
    :action-handlers (ht ("rubyLsp.openFile" #'lsp-ruby-lsp--open-file)
                         ("rubyLsp.runTask" #'lsp-ruby-lsp--run-task)
                         ("rubyLsp.runTest" #'lsp-ruby-lsp--run-test)
                         ("rubyLsp.runTestInTerminal" #'lsp-ruby-lsp--run-test))
    :server-id 'ruby-lsp-ls2)))

(use-package lsp-ui :commands lsp-ui-mode)
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package which-key :config (which-key-mode))

(provide 'eg-lsp)
