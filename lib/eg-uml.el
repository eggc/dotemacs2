;; https://skoji.jp/blog/2020/01/plantuml.html
(use-package plantuml-mode
  :mode ("\\.plantuml\\'" "\\.uml\\'")
  :config
  (setq plantuml-executable-path "plantuml")
  (setq plantuml-default-exec-mode 'executable)
  (setq plantuml-output-type "png")
  (setq plantuml-executable-args (append plantuml-executable-args '("-charset" "UTF-8"))))

(provide 'eg-uml)
