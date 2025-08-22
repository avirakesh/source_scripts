(load "~/.emacs.d/sanemacs.el" nil t)

;;; --- Appearance ---
;; Theme
(use-package catppuccin-theme
  :ensure t
  :config
  (load-theme 'catppuccin :no-confirm))

;; Show ruler
(global-display-fill-column-indicator-mode 1)
(setq display-fill-column-indicator-column 80)


;;; --- Editing Enhancements ---
;; M-up/M-down for moving line or selection up/down
(use-package move-text
  :ensure t
  :config
  (move-text-default-bindings))

;; Indent text on move
(defun indent-region-advice (&rest ignored)
  (let ((deactivate deactivate-mark))
    (if (region-active-p)
	(indent-region (region-beginning) (region-end))
      (indent-region (line-beginning-position) (line-end-position)))
    (setq deactivate-mark deactivate)))

(advice-add 'move-text-up :after 'indent-region-advice)
(advice-add 'move-text-down :after 'indent-region-advice)

;; Smart parentheses
(use-package smartparens
  :ensure t
  :hook (prog-mode text-mode markdown-mode)
  :config
  (require 'smartparens-config))

;; Enable autocomplete globally
(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

;; Enable spell check
(add-hook 'text-mode-hook #'flyspell-mode)
(add-hook 'prog-mode-hook #'flyspell-prog-mode)

(defun duplicate-line-or-dwim ()
  "Duplicate the current line or the selected region.
   If a region is active, it duplicates the text in the region.
   Otherwise, it duplicates the current line."
  (interactive)
  (if (use-region-p)
      (duplicate-dwim)
    (duplicate-dwim)))


;;; --- Version Control ---
;; Enable pretty color on git commit
(use-package magit
  :ensure t
  :config
  (remove-hook 'server-switch-hook #'magit-commit-diff))
  ;; Remove the diff window from commit messages

;; Show git changes in gutter
(use-package diff-hl
  :ensure t
  :config
  (global-diff-hl-mode)
  (add-hook 'diff-hl-mode-hook 'diff-hl-flydiff-mode))


;;; --- Language Support ---
;; Markdown support
(use-package markdown-mode
  :ensure t
  :mode ("\.md\'" . gfm-mode)
  :init
  (setq markdown-command "pandoc"))

;; Python support
(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  :hook (python-mode . elpy-mode))

;; C/C++ support
(use-package lsp-mode
  :ensure t
  :commands (lsp)
  :hook (c-mode . lsp)
        (c++-mode . lsp)
  :init
  (setq lsp-keymap-prefix "C-c l"))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)


;;; --- Keybindings ---
;; Familiar key binds
(keymap-global-set "C-v" 'yank)
(keymap-global-set "C-a" 'mark-whole-buffer)
(keymap-global-set "C-z" 'undo-tree-undo)
(keymap-global-set "C-y" 'undo-tree-redo)
(keymap-global-set "M-/" 'comment-line)
(keymap-global-set "C-d" 'duplicate-line-or-dwim)


;;; --- Miscellaneous ---
;; Enable mouse mode
(unless (display-graphic-p)
  (xterm-mouse-mode 1))

;;; --- File Saving ---
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq require-final-newline t)

;;; --- Allow built-in-packages to be upgraded ---
(setq package-install-upgrade-built-in t)
