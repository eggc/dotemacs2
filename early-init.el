(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(fullscreen . maximized) default-frame-alist)

;; Reduce flickering when rebecca-theme is applied.
(custom-set-faces '(default ((t (:background "#162626")))))

(provide 'early-init)
