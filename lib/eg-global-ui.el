(show-paren-mode 1)
(column-number-mode t)
(global-hl-line-mode t)
(global-auto-revert-mode t)
(delete-selection-mode t)

(defvar show-paren-delay 0)
(defvar show-paren-style 'expression)
(defvar x-select-enable-clipboard t)
(defvar x-select-enable-primary t)
(defvar ediff-window-setup-function 'ediff-setup-windows-plain)
(setq-default indent-tabs-mode nil)
(setq save-interprogram-paste-before-kill t)
(setq require-final-newline t)
(setq backup-directory-alist `((".*". ,temporary-file-directory)))
(setq kill-ring-max 500)

(server-start)

; 長い行（とくに整形されてないjson等の表示）の処理が非常に重いためそれを軽減する
; https://emacs.stackexchange.com/questions/598/how-do-i-prevent-extremely-long-lines-making-emacs-slow/601
(setq-default bidi-display-reordering nil)
(setq use-short-answers t) ; yes or no の質問を y, n で答えられるようにする

(require 'cl-seq)
(defun eg-find-font(my-font-list) (car (last (cl-intersection (font-family-list) my-font-list :test #'equal))))

(let ((my-font-main (eg-find-font '("HackGen Console NF" "Ricty" "Monaco")))
      (my-font-sub (eg-find-font '("mplus Nerd Font" "Monaco"))))
  (create-fontset-from-ascii-font my-font-main nil "eggc")
  (set-fontset-font "fontset-eggc" 'unicode my-font-main)
  (set-fontset-font "fontset-eggc" 'unicode my-font-sub nil 'append)
  (add-to-list 'default-frame-alist '(font . "fontset-eggc")))

(defun eg-delayed-setup ()
  "原因不明だが起動時点でデフォルトセットするとクリアされてしまうのでわざと数秒遅延させる"
  (set-face-font 'default "fontset-eggc")
  (set-face-attribute 'default nil :height 200))
(add-hook 'window-setup-hook 'eg-delayed-setup)

;; Disable syntax highlight when open a large file(such as compressed javascript file)
;; https://gist.github.com/jidaikobo-shibata/96e00bd843c838f45ab8183e286150ec
;; https://www.reddit.com/r/emacs/comments/a2fac5/opening_large_files/
(defun open-large-file-quickly()
  "To read large file."
  (interactive)
  (progn
    (when (file-exists-p (buffer-file-name))
      (let* ((file-name (buffer-file-name (current-buffer)))
             (f-attr (file-attributes file-name))
             (f-size (nth 7 f-attr))
             (is-large (>= f-size 350000)))
        (if (not (string= (substring (buffer-file-name) 0 1) "*"))
            (progn
              (when is-large
                (message "File Size: %s Bytes, Opened by less function mode" f-size)
                (fundamental-mode)
                (font-lock-mode -1)
                (which-function-mode -1))))))))

(add-hook 'before-save-hook #'delete-trailing-whitespace)
(add-hook 'find-file-hook #'open-large-file-quickly)

(provide 'eg-global-ui)
