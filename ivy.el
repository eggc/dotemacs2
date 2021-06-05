(use-package ivy
  :config
  (defvar counsel-find-file-at-point t)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-height 20)
  (ivy-mode)
  :custom
  (ivy-initial-inputs-alist nil))

(use-package counsel
  :config
  (counsel-mode))

(use-package ivy-xref
  :init
  (setq xref-show-definitions-function #'ivy-xref-show-defs)
  (setq xref-show-xrefs-function #'ivy-xref-show-xrefs)
  (setq ivy-xref-use-file-path t))
