;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(show-paren-mode 1)
(column-number-mode 1)
(global-display-line-numbers-mode 1)

(setq custom-file "~/.emacs.d/emacs-custom.el")
(package-initialize)

;;(add-to-list 'load-path "~/.emacs.d/")


(load-file custom-file)


(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)


;;; multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-c m")       'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "M-\"")        'mc/skip-to-previous-like-this)
;; Echange pour mettre le curseur sur un mot redondant a la place de du C-d initial
(global-unset-key (kbd "C-d"))
(global-unset-key (kbd "C-s"))
(global-set-key (kbd "C-s") 'mc/mark-previous-like-this-word)
(global-set-key (kbd "C-d") 'mc/mark-next-like-this-word)
;; Echange entre le focus sur les différents curseurs et le yank
(define-key mc/keymap (kbd "M-c") nil)
(define-key mc/keymap (kbd "C-v") nil)
;; Utilisation du focus sur les différents curseurs
(define-key mc/keymap (kbd "M-c") 'mc/cycle-backward)
(define-key mc/keymap (kbd "M-v") 'mc/cycle-forward)


;; Changer de kbd pour coller
(global-unset-key (kbd "C-v"))
(global-set-key (kbd "C-v") #'yank)
(define-key isearch-mode-map (kbd "C-v") #'isearch-yank-kill)
(global-unset-key (kbd "C-y"))
(define-key isearch-mode-map (kbd "C-y") nil)

;; Changer la recherche en avant par C-f
(global-unset-key (kbd "C-f"))
(global-set-key (kbd "C-f")              'isearch-forward)
(define-key isearch-mode-map (kbd "C-f") 'isearch-repeat-forward)
;; /usr/share/emacs/26.3/lisp/isearch.el.gz


(require 'undo-tree)
(global-undo-tree-mode)
(setq undo-tree-auto-save-history nil)
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-z") #'undo)
(global-unset-key (kbd "C-_"))

;; (define-key map (kbd "C-z") 'undo)
(global-unset-key (kbd "C-y"))
(global-set-key (kbd "C-y") #'redo)
(global-unset-key (kbd "C-?"))

;; (setq package-check-signature nil) // Si problème lors de l'installation de package


;;; auto completion
(require 'auto-complete)
(ac-config-default)
;; (global-auto-complete-mode t)

(load-file "~/.emacs.d/simpc-mode.el")
(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))
(add-hook 'simpc-mode 'ac-cc-mode-setup)

;; (add-hook 'simpc-mode 'ac-mode)
;; (add-hook 'ac-mode #'simpc-mode)
;; (add-hook 'simpc-mode #'ac-cc-mode-setup)
;; (add-hook 'simpc-mode-common-hook #'ac-cc-mode-setup) ;; c'est ça qui faut faire mais simpc-mode-...n'existe pas 
;; (add-hook 'c-mode-common-hook #'simpc-mode)

(load-file "~/.emacs.d/fasm-mode.el")
(require 'fasm-mode)
(add-to-list 'auto-mode-alist '("\\.\\(asm\\|[sS]\\)?\\'" . fasm-mode))



;; double les parenthère
(electric-pair-mode 1)
(global-set-key (kbd "\C-x\C-m") 'compile)
(setq-default compile-command "./build.sh")

;; (add-hook 'c-mode-hook (lambda ()
;;                          (interactive)
;;                          (c-toggle-comment-style -1)))

;;; affiche les combinaison suivante
(add-to-list 'load-path "path/to/which-key.el")
(require 'which-key)
(which-key-mode t)

;; refresh buffer
(global-auto-revert-mode 1)

;; Commentaire bind
(global-set-key (kbd "C-c C-c") 'comment-region)
(global-set-key (kbd "C-c C-d") 'uncomment-region)

;; ido
(ido-mode 1)
(ido-everywhere 1)
(fido-vertical-mode 1)
(fido-mode 1)


;;; Duplicate Line
(load "subr-x.el")
(defun duplicate-line ()
  "Duplicate current line"
  (interactive)
  (let ((column (- (point) (point-at-bol)))
	(line (let ((s (thing-at-point 'line t)))
		(if s (string-remove-suffix "\n" s) ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))

(global-set-key (kbd "C-,") 'duplicate-line)


;;; Move Text
(require 'move-text)
(global-set-key (kbd "<M-down>") 'move-text-down)
(global-set-key (kbd "<M-up>") 'move-text-up)



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq backup-directory-alist '(("." . "~/.emacs_saves")))
(global-unset-key (kbd "C-x m")) ;; éviter l'erreur avec la commande pour compiler
(put 'scroll-left 'disabled nil)
