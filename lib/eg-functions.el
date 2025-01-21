(require 'project)

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
  (let ((path (file-full-path))
        (name (file-name-nondirectory buffer-file-name))
        (word (thing-at-point 'symbol)))
    (if word
        (to-clipboard (concat "[[" path "][" word "]]"))
      (to-clipboard (concat "[[" path "][" name "]]")))))

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

(defun build-rspec-command ()
  "今開いているファイルの rspec 実行コマンドをクリップボードにコピーします"
  (interactive)
  (let* ((project-root-path (project-root (project-current)))
        (buffer-path (substring (buffer-file-name) (length project-root-path))))
    (to-clipboard (concat "bundle exec rspec " buffer-path))
    ))

(defun quote-current-line ()
  (interactive)
  (let ((pos (point)))
    (back-to-indentation)
    (insert "'")
    (move-end-of-line 1)
    (insert "'")
    (goto-char pos)
    ))

(defun open-pull-request ()
  "Run the shell command 'gh pr view --web <word>' to open the PR in the web browser.
<word> is the word at the current cursor position or a user-provided input."
  (interactive)
  (let* ((word-at-point (thing-at-point 'symbol t))
         (default-command (concat "gh pr view --web " (or word-at-point "")))
         (command (read-string "Run command: " default-command)))
    (shell-command command)))

(global-set-key (kbd "C-x C-p") #'file-full-path-org-link-to-clipboard)
(global-set-key (kbd "C-x C-d") #'insert-current-date)
(global-set-key (kbd "C-c C-t") #'build-rspec-command)

(provide 'eg-functions)
