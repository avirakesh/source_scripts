(load "~/.emacs.d/sanemacs.el" nil t)

;; Theme
(use-package catppuccin-theme
  :ensure t
  :config
  (load-theme 'catppuccin :no-confirm))

;; M-up/M-down for moving line or selection up/down
(use-package move-text
  :ensure t
  :config
  (move-text-default-bindings))

;; Smart parentheses
(use-package smartparens
  :ensure t
  :hook (prog-mode text-mode markdown-mode)
  :config
  (require 'smartparens-config))

;; Enable pretty color on git commit
;; (use-package magit
  ;; :ensure t
  ;; :config
  ;; (remove-hook 'server-switch-hook #'magit-commit-diff))
  ;; Remove the diff window from commit messages

;; Indent text on move
;; (defun indent-region-advice (&rest ignored)
  ;; (let ((deactivate deactivate-mark))
    ;; (if (region-active-p)
	;; (indent-region (region-beginning) (region-end))
      ;; (indent-region (line-beginning-position) (line-end-position)))
    ;; (setq deactivate-mark deactivate)))

;; (advice-add 'move-text-up :after 'indent-region-advice)
;; (advice-add 'move-text-down :after 'indent-region-advice)

;; Enable mouse mode
(unless (display-graphic-p)
  (xterm-mouse-mode 1))

;; Show ruler
(global-display-fill-column-indicator-mode 1)
(setopt display-fill-column-indicator-column 80)

;; Enable autocomplete globally
(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

;; Enable spell check
;; (add-hook 'text-mode-hook #'flyspell-mode)
;; (add-hook 'prog-mode-hook #'flyspell-prog-mode)

;; Familiar keybinds
(keymap-global-set "C-v" 'yank)
(keymap-global-set "C-a" 'mark-whole-buffer)
(keymap-global-set "C-z" 'undo-tree-undo)
(keymap-global-set "C-y" 'undo-tree-redo)
(keymap-global-set "M-/" 'comment-line)


(defun duplicate-line-or-dwim ()
  "Duplicate the current line or the selected region.
   If a region is active, it duplicates the text in the region.
   Otherwise, it duplicates the current line."
  (interactive)
  (if (use-region-p)
      (duplicate-dwim)
    (duplicate-dwim)))

(keymap-global-set "C-d" 'duplicate-line-or-dwim)
