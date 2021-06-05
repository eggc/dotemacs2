(defun file-full-path ()
  "今開いているファイルの絶対パス::行数を返します"
  (if (equal major-mode 'dired-mode)
      default-directory
    (concat (buffer-file-name) "::" (number-to-string (line-number-at-pos)))))

(defun to-clipboard (x)
  "与えられた文字列をクリップボードにコピーします"
  (when x
    (with-temp-buffer
      (insert x)
      (clipboard-kill-region (point-min) (point-max)))
    (message x)))

(defun file-full-path-to-clipboard ()
  "今開いているファイルの org link をクリップボードにコピーします"
  (interactive)
  (to-clipboard (file-full-path)))

(defun file-full-path-org-link-to-clipboard ()
  "今開いているファイルの org link をクリップボードにコピーします"
  (interactive)
  (to-clipboard (concat "[[" (file-full-path) "][" (file-name-nondirectory buffer-file-name) "]]")))

(defun insert-current-time ()
  "現在時間をカレントバッファに出力します"
  (interactive)
    (insert
     (replace-regexp-in-string "\n$" "" (shell-command-to-string "date '+%H:%M:%S'"))))

(defun insert-current-date (&optional diff)
  "現在年月日をカレントバッファに出力します"
  (interactive "P")
    (insert
     (shell-command-to-string
      (format
       "echo -n $(LC_ALL=ja_JP date -v-%dd +'%%Y/%%m/%%d (%%a)')"
       (or diff 0)))))