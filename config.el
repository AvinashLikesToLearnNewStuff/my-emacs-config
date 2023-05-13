(line-number-mode 1)
(column-number-mode 1)

(setq electric-pair-pairs '(
			    (?\( .?\))
			    (?\[ .?\])
			    ))

(electric-pair-mode t)

(setq display-time-24hr-format t)
(display-time-mode 1)

(use-package exwm
:ensure t
  :config
  (require 'exwm-config)
(exwm-config-default))

(require 'exwm-systemtray)
(exwm-systemtray-enable)

(global-set-key (kbd "s-k") 'exwm-workspace-delete)
(global-set-key (kbd "s-w") 'exwm-workspace-swap)

(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

(setq org-src-window-setup 'current-window) 
(add-to-list 'org-structure-template-alist
	     '("el" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

(setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)

(use-package ido-vertical-mode
  :ensure t
  :init
  (ido-vertical-mode 1))
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

(use-package smex
  :ensure t
  :init (smex-initialize)
  :bind
  ("M-x" . smex))

(defun kill-curr-buffer()
  (interactive)
  ( kill-buffer (current-buffer))
  )
(global-set-key (kbd "C-x k") 'kill-current-buffer)

(defun kill-all-buffers()
(interactive)
(mapc 'kill-buffer (buffer-list)))

(global-set-key (kbd "C-M-s-k") 'kill-all-buffers)

(global-set-key (kbd "C-x b") 'ibuffer)

(use-package avy
:ensure t
:bind
("M-s" . avy-goto-char))

(defun kill-whole-word()
  (interactive)
  (backward-word)
  (kill-word 1))
  (global-set-key (kbd "C-c w w") 'kill-whole-word)

(defun copy-whole-line()
  (interactive)
  (save-excursion
  (kill-new
   (buffer-substring
    (point-at-bol)
    (point-at-eol)))))
(global-set-key (kbd "C-c w l") 'copy-whole-line)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 10)))
  (setq dashboard-banner-logo-title "Hii!"))

(defun kill-whole-word()
  (interactive)
  (backward-word)
  (kill-word 1))
  (global-set-key (kbd "C-c w w") 'kill-whole-word)

(defun config-visit ()
  (interactive)
  (find-file "~/.emacs.d/config.org"))

(global-set-key (kbd "C-c e") 'config-visit)

(defun config-reload ()
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))

(global-set-key (kbd "C-c r") 'config-reload)

(use-package rainbow-mode
:ensure t
:init (rainbow-mode 1))

(use-package rainbow-delimiters
  :ensure t
  :init
  (rainbow-delimiters-mode 1))

(use-package switch-window
:ensure t
:config
(setq switch-window-input-style 'minibuffer)
(setq switch-window-increase 4)
(setq switch-window-threshold 2)
(setq switch-window-shortcut-style 'qwerty)
(setq switch-window-shortcuts 
       '("a","s","d","f","h","j","k","l"))
:bind 
([remap other-window] . switch-window))

(defun split-and-follow-horizontally()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
  (global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

(defun split-and-follow-vertically()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
  (global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode))

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (setq powerline-default-separator (quote arrow))
  (spaceline-spacemacs-theme))

(use-package diminish
  :ensure t 
:init 
(diminish 'beacon-mode)
(diminish 'which-key-mode)
(diminish 'subword-mode)
(diminish 'rainbow-mode)
)

(use-package symon
  :ensure t
  :bind
  ("s-h" . symon-mode))
