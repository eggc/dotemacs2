(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(show-paren-mode 1)
(column-number-mode t)
(global-hl-line-mode)
(global-auto-revert-mode 1)
(delete-selection-mode t)

(electric-pair-mode 1)
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
(add-hook 'before-save-hook 'delete-trailing-whitespace)

; 長い行（とくに整形されてないjson等の表示）の処理が非常に重いためそれを軽減する
; https://emacs.stackexchange.com/questions/598/how-do-i-prevent-extremely-long-lines-making-emacs-slow/601
(setq-default bidi-display-reordering nil)
(fset 'yes-or-no-p 'y-or-n-p) ; yes or no の質問を y, n で答えられるようにする

;; これ効いてなさそう
(set-face-attribute 'show-paren-match nil :inherit 'highlight :underline 'unspecified)

(defconst my-font (if (member "Ricty" (font-family-list)) "Ricty" "Monaco"))
(set-face-attribute 'default nil :family my-font :height 200)
(set-fontset-font t 'japanese-jisx0208 (font-spec :family my-font)) ; これがないと一部の漢字のフォントがおかしくなる


;; Disable syntax highlight when open a large file(such as compressed javascript file)
;; https://www.reddit.com/r/emacs/comments/a2fac5/opening_large_files/
(defun conditional-disable-modes ()
  (when (> (buffer-size) (* 3 1024 1024))
    (flycheck-mode -1)
    (font-lock-mode -1)
    (fundamental-mode)
    (which-function-mode -1)
    ))

(add-hook 'prog-mode-hook 'conditional-disable-modes)
(add-hook 'text-mode-hook 'conditional-disable-modes)
