(defun other-window-back ()
  (interactive)
  (other-window -1))

(keyboard-translate ?\C-h ?\C-?)                           ; C-h で delete を発行
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "C-t") 'other-window)
;;(g lobal-set-key (kbd "M-t") 'other-window-back)
(global-set-key (kbd "C-M-t") 'other-frame)
(global-set-key (kbd "C-x SPC") 'cua-rectangle-mark-mode)  ; 矩形選択/入力
(global-set-key (kbd "C-c l") 'toggle-truncate-lines)      ; 行末で折り返す <-> 折り返さない
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
(global-set-key (kbd "M-i") 'imenu)
(global-set-key (kbd "C-s-f") 'toggle-frame-fullscreen)

;; 自作関数
(global-set-key (kbd "C-x C-p") 'file-full-path-org-link-to-clipboard)
(global-set-key (kbd "C-x C-i") 'insert-current-date)
