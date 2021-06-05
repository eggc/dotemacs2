;; bootstrap straight https://github.com/raxod502/straight.el#getting-started
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)

(defvar dotemacs2-directory "~/work/dotemacs2/"
  "dotemacs2 を git clone したディレクトリ")

(defun eg-load (feature-name)
  "dotemacs2 の設定を読み込みます"
  (load (concat dotemacs2-directory feature-name)))
