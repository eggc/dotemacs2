(setenv "SPEC_OPTS" "--format documentation")
(setenv "RSPEC_RETRY_RETRY_COUNT" "1")

(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess) ; find-file の時 path にカーソルが当たってたらそれを開く
(setq ido-use-url-at-point t)  ; find-file の時 url にカーソルが当たってたらそれを開く
(setq ido-auto-merge-work-directories-length -1) ; マッチするものがない時に、自動で recentf を検索しない
(ido-everywhere t)
(menu-bar-mode -1)
(show-paren-mode 1)
(column-number-mode t)
(global-hl-line-mode)
(global-auto-revert-mode 1)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)
(setq-default indent-tabs-mode nil)
(setq x-select-enable-clipboard t)
(setq x-select-enable-primary t)
(setq save-interprogram-paste-before-kill t)
(setq require-final-newline t)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq backup-directory-alist `((".*". ,temporary-file-directory)))
(add-hook 'before-save-hook 'delete-trailing-whitespace)

; 長い行（とくに整形されてないjson等の表示）の処理が非常に重いためそれを軽減する
; https://emacs.stackexchange.com/questions/598/how-do-i-prevent-extremely-long-lines-making-emacs-slow/601
(setq-default bidi-display-reordering nil)

; 日本語入力時のちらつきを防止する
;; http://hylom.net/emacs-25.1-ime-flicker-problem
(setq redisplay-dont-pause nil)

; https://qiita.com/tadsan/items/68b53c2b0e8bb87a78d7
(setq recentf-max-saved-items 2000) ;; 2000ファイルまで履歴保存する
(setq recentf-auto-cleanup 'never)  ;; 存在しないファイルは消さない
(setq recentf-exclude '("/recentf" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores" "/\\.emacs\\.d/\\.cask/"))
(setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))
(recentf-mode 1)

;; http://garin.jp/2017/09/09/2017-09-09-143435.html
;; recentf の メッセージをエコーエリア(ミニバッファ)に表示しない
;; (*Messages* バッファには出力される)
(defun recentf-save-list-inhibit-message:around (orig-func &rest args)
  (setq inhibit-message t)
  (apply orig-func args)
  (setq inhibit-message nil)
  'around)
(advice-add 'recentf-cleanup   :around 'recentf-save-list-inhibit-message:around)
(advice-add 'recentf-save-list :around 'recentf-save-list-inhibit-message:around)
(recentf-mode 1)
; https://www.emacswiki.org/emacs/RecentFiles#toc8
(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))

(add-hook 'org-mode-hook (lambda ()
  (setq org-hide-leading-stars t)
  (setq org-indent-indentation-per-level 8)
  (setq org-todo-keywords '((sequence "TODO" "DOING" "|" "DONE")))
  (local-unset-key (kbd "M-h"))    ; org-mode の M-h を利用しない。
  (org-indent-mode t)              ; インデントをヘッダに合わせる。
  ))

(defun other-window-back ()
  (interactive)
  (other-window -1)
  )

(keyboard-translate ?\C-h ?\C-?)                           ; C-h で delete を発行
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "C-t") 'other-window)
(global-set-key (kbd "M-t") 'other-window-back)
(global-set-key (kbd "C-x SPC") 'cua-rectangle-mark-mode)  ; 矩形選択/入力
(global-set-key (kbd "C-c l") 'toggle-truncate-lines)      ; 行末で折り返す <-> 折り返さない
(global-set-key (kbd "C-c t") 'recentf-ido-find-file)

; (font-family-list) でフォント一覧を見れるのでそこから選ぶ
(set-face-attribute 'default nil :family "Ricty" :height 170)
(set-fontset-font t 'japanese-jisx0208 (font-spec :family "Ricty")) ; これがないと一部の漢字のフォントがおかしくなる
(fset 'yes-or-no-p 'y-or-n-p) ; yes or no の質問を y, n で答えられるようにする

(add-hook 'occur-mode-hook (lambda ()
  (next-error-follow-minor-mode)
  (local-set-key (kbd "n") 'next-line)
  (local-set-key (kbd "p") 'previous-line)
 ))

(package-initialize)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-refresh-contents)
(defvar my/favorite-packages
  '(auto-complete idomenu ido-vertical-mode ido-completing-read+
    smex rubocop exec-path-from-shell rspec-mode direnv
    rbenv yasnippet dumb-jump dired-subtree
    slim-mode string-inflection
    coffee-mode wgrep dashboard paradox
    rjsx-mode
    projectile projectile-rails spaceline
    use-package magit key-chord rebecca-theme wdired))
(dolist (package my/favorite-packages)
  (unless (package-installed-p package)
    (package-install package)))

(load-theme 'rebecca t)

(setq dired-dwim-target t) ; 2個のdiredバッファがある時、コピー/移動先のパスを他方のバッファにする

(add-hook 'dired-mode-hook (lambda ()
  (local-unset-key (kbd "C-t"))                         ; 普段の C-t をそのまま
  (local-set-key (kbd "j")     'dired-next-line)        ; vim のような上下移動
  (local-set-key (kbd "k")     'dired-previous-line)    ; vim のような上下移動
  (local-set-key (kbd "<tab>") 'dired-subtree-insert)   ; サブツリーを見やすく開く(org-modeと揃える)
  (local-set-key (kbd "h")     'dired-subtree-remove)   ; サブツリーを隠す
  (local-set-key (kbd "r")     'wdired-change-to-wdired-mode) ; ファイル名編集
))

(setq ido-max-window-height 0.75)
(setq ido-vertical-define-keys 'C-n-C-p-up-and-down)
(ido-vertical-mode 1)
(global-set-key (kbd "M-i") 'idomenu)

(defun coffee-custom ()
    "coffee-mode-hook"
    (set (make-local-variable 'tab-width) 2)
    (setq coffee-tab-width 2))
(add-hook 'coffee-mode-hook '(lambda() (coffee-custom)))

(setq ruby-insert-encoding-magic-comment nil)
(setq ruby-deep-indent-paren-style nil)
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\Gemfile$" . ruby-mode))

(add-hook 'ruby-mode-hook '(lambda()
  (rubocop-mode)
  (local-set-key (kbd "C-c , R") 'rubocop-autocorrect-current-file)
))

;; @see https://github.com/pezra/rspec-mode#debugging
(add-hook 'after-init-hook 'inf-ruby-switch-setup)
;; @see https://github.com/pezra/rspec-mode#auto-scrolling
(setq compilation-scroll-output t)

(yas-global-mode 1)
(setq yas-prompt-functions '(yas-ido-prompt))

(defun insert-current-date (&optional diff)
  "日にちをカレントバッファに出力します"
  (interactive "P")
    (insert
     (shell-command-to-string
      (format
       "echo -n $(LANG=ja_JP date -v-%dd +'%%Y/%%m/%%d (%%a)')"
       (or diff 0)))))

;; 今開いているファイルのフルパスを得る。dired バッファは NG
(defun file-full-path ()
  "Put the current file name on the clipboard"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

; for emacs cocoa
(menu-bar-mode t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-set-key (kbd "s-f") 'find-file)                    ; C-x C-f
(global-set-key (kbd "s-b") 'switch-to-buffer)             ; C-x b
(global-set-key (kbd "s-0") 'delete-window)                ; C-x 0
(global-set-key (kbd "s-1") 'delete-other-windows)         ; C-x 1
(global-set-key (kbd "s-2") 'split-window-vertically)      ; C-x 2
(global-set-key (kbd "s-3") 'split-window-horizontally)    ; C-x 3
(global-set-key (kbd "s-t") 'make-frame-command)           ; C-x 5 2
(global-set-key (kbd "s-D") 'split-window-vertically)      ; iterm と同じ
(global-set-key (kbd "s-d") 'split-window-horizontally)    ; iterm と同じ
(global-set-key (kbd "s-q") 'version)                      ; 誤操作防止用

; https://github.com/senny/rbenv.el
(use-package rbenv
  :config
  (setq rbenv-show-active-ruby-in-modeline nil)
  (global-rbenv-mode)
)

(use-package wdired)         ; Dired バッファの上でファイル名をリネームできるようにする

(use-package wgrep
  :config
  (setf wgrep-enable-key "r")
  (setq wgrep-auto-save-buffer t)
  (setq grep-find-ignored-directories (append grep-find-ignored-directories '("node_modules" ".bundle" "yardoc" "coverage" "log" "tmp")))
  (setq grep-find-ignored-files (append grep-find-ignored-files '("*.min.js" "*.log")))
)

(use-package projectile
  :config
  (setq projectile-project-search-path '("~/"))
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1)
)

(use-package projectile-rails
  :config
  (projectile-rails-global-mode)
  )

(use-package dashboard
  :config
  (setq dashboard-items '((recents  . 10) (projects . 10) (bookmarks . 5)))
  (dashboard-setup-startup-hook)
)

(use-package auto-complete)
(use-package auto-complete-config
  :config
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (global-auto-complete-mode t)
  (ac-config-default)
  (setq ac-ignore-case nil) ; auto-complete で大文字小文字を区別する。
  (setq ac-auto-start 4)
)

(use-package forge
  :after magit)
(use-package direnv
 :config
 (setq direnv-always-show-summary nil)
 (direnv-mode))

(use-package key-chord
  :config
  (setq key-chord-two-keys-delay 0.04)
  (key-chord-mode 1)
  (key-chord-define-global "fd" 'find-file)
  (key-chord-define-global "gh" 'magit-status)
  (key-chord-define-global "sd" 'save-buffer)
  (key-chord-define-global "rt" 'recentf-ido-find-file)
  (key-chord-define-global "bm" 'bookmark-jump)
  (key-chord-define-global "dj" 'dumb-jump-go)
  (key-chord-define-global "y7" 'yas-insert-snippet)
  (key-chord-define-global "id" 'insert-current-date)
  (key-chord-define-global "fp" 'file-full-path)
  (key-chord-define-global "cy" 'string-inflection-ruby-style-cycle)
)

(use-package spaceline-config
  :config
  (spaceline-emacs-theme)
  (spaceline-toggle-minor-modes-off)
  (spaceline-toggle-version-control-off)
)

(use-package paradox
 :ensure t
 :custom
 (paradox-github-token t))

(use-package ido-completing-read+
  :config
  (ido-ubiquitous-mode 1)
  )

(use-package smex
  :config
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ;old M-x
  )

(use-package rjsx-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.js$" . rjsx-mode))
  (add-hook 'rjsx-mode-hook (lambda()
    (auto-complete-mode)
    (setq-local sgml-basic-offset 2)
    (setq-local js-indent-level 2)
    (setq js2-strict-missing-semi-warning nil)))
)


; https://github.com/purcell/exec-path-from-shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit nil :foreground "#ae81ff" :height 1.0))))
 '(org-level-2 ((t (:inherit nil :foreground "#ccccff" :height 1.0)))))
