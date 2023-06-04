(defvar my-term-shell "/bin/bash")
(defadvice vterm (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'vterm)

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

(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

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

(use-package expand-region
:ensure t
:config
(global-set-key (kbd "C-=") 'er/expand-region))



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

(global-set-key (kbd "M-/") 'dabbrev-expand)
(global-set-key (kbd "M-C-/") 'dabbrev-completion)

(use-package hippie-exp
  :bind ([remap dabbrev-expand] . hippie-expand)
  :commands (hippie-expand)
  :custom
  (dabbrev-ignored-buffer-regexps '("\\.\\(?:pdf\\|jpe?g\\|png\\)\\'"))
  :config
  (setq hippie-expand-try-functions-list
        '(try-expand-dabbrev
          try-expand-dabbrev-all-buffers
          try-expand-dabbrev-from-kill
          try-complete-lisp-symbol-partially
          try-complete-lisp-symbol
          try-complete-file-name-partially
          try-complete-file-name
          try-expand-all-abbrevs
          try-expand-list
          try-expand-line)))
;;;; Code Completion
(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                 ; Allows cycling through candidates
  (corfu-auto t)                  ; Enable auto completion
  (corfu-auto-prefix 1)
  (corfu-auto-delay 0.0)
  (corfu-popupinfo-delay '(0.5 . 0.2))
  (corfu-preview-current 'insert) ; Do not preview current candidate
  (corfu-preselect-first nil)
  (corfu-on-exact-match nil)      ; Don't auto expand tempel snippets

  ;; Optionally use TAB for cycling, default is `corfu-complete'.
  :bind (:map corfu-map
              ("M-SPC"      . corfu-insert-separator)
              ("TAB"        . corfu-next)
              ([tab]        . corfu-next)
              ("S-TAB"      . corfu-previous)
              ([backtab]    . corfu-previous)
              ("S-<return>" . corfu-insert)
              ("RET"        . corfu-insert))

  :init
  (global-corfu-mode)
  (corfu-history-mode)
  (corfu-popupinfo-mode) ; Popup completion info
  :config
  (add-hook 'eshell-mode-hook
            (lambda () (setq-local corfu-quit-at-boundary t
                              corfu-quit-no-match t
                              corfu-auto nil)
              (corfu-mode))))
(use-package cape
  :defer 10
  :bind ("C-c f" . cape-file)
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  (defalias 'dabbrev-after-2 (cape-capf-prefix-length #'cape-dabbrev 2))
  (add-to-list 'completion-at-point-functions 'dabbrev-after-2 t)
  (cl-pushnew #'cape-file completion-at-point-functions)
  :config
  ;; Silence then pcomplete capf, no errors or messages!
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)

  ;; Ensure that pcomplete does not write to the buffer
  ;; and behaves as a pure `completion-at-point-function'.
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-purify))

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (setq powerline-default-separator (quote arrow))
  (spaceline-spacemacs-theme))

(use-package dmenu
  :ensure t
  :bind
  ("s-SPC" . 'dmenu))

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

(use-package popup-kill-ring
  :ensure t
  :bind ("M-y" . popup-kill-ring))

(use-package swiper
  :ensure t
  :bind
  ("C-s" . swiper))



;; Initialize package sources
  (require 'package)

  (setq package-archives '(("melpa" . "https://melpa.org/packages/")
			   ("melpa-stable" . "https://stable.melpa.org/packages/")
			   ("org" . "https://orgmode.org/elpa/")
			   ("elpa" . "https://elpa.gnu.org/packages/")))

(unless (package-installed-p 'use-package)
(package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package command-log-mode)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-f" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :init
  (ivy-mode 1))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(column-number-mode)

;; Enable line numbers for some modes
(dolist (mode '(text-mode-hook
                prog-mode-hook
                conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))

;; Override some modes which derive from the above
(dolist (mode '(org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1)
  :after counsel
  :config
  (setq ivy-format-function #'ivy-format-function-line)
  (setq ivy-rich-display-transformers-list
        (plist-put ivy-rich-display-transformers-list
                   'ivy-switch-buffer
                   '(:columns
                     ((ivy-rich-candidate (:width 40))
                      (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right)); return the buffer indicators
                      (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))          ; return the major mode info
                      (ivy-rich-switch-buffer-project (:width 15 :face success))             ; return project name using `projectile'
                      (ivy-rich-switch-buffer-path (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.3))))))  ; return file path relative to project root or `default-directory' if project is nil
                     :predicate
                     (lambda (cand)
                       (if-let ((buffer (get-buffer cand)))
                           ;; Don't mess with EXWM buffers
                           (with-current-buffer buffer
                             (not (derived-mode-p 'exwm-mode)))))))))




(use-package counsel
  :demand t
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
          ("C-M-j" . counsel-switch-buffer)
         ("C-M-l" . counsel-imenu)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (setq ivy-initial-inputs-alist nil)) ;; Don't start searches with ^

(add-hook 'emacs-lisp-mode-hook #'flycheck-mode)

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . helpful-function)
  ([remap describe-symbol] . helpful-symbol)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key))

(use-package general
  :config
  (general-evil-setup t)

  (general-create-definer dw/leader-key-def
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (general-create-definer dw/ctrl-c-keys
    :prefix "C-c"))

(defun dw/evil-hook ()
  (dolist (mode '(custom-mode
                  eshell-mode
                  git-rebase-mode
                  erc-mode
                  circe-server-mode
                  circe-chat-mode
                  circe-query-mode
                  sauron-mode
                  term-mode))
  (add-to-list 'evil-emacs-state-modes mode)))

(defun dw/dont-arrow-me-bro ()
  (interactive)
  (message "Arrow keys are bad, you know?"))

(use-package undo-tree
  :init
  (global-undo-tree-mode 1))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-respect-visual-line-mode t)
  (setq evil-undo-system 'undo-tree)
  :config
  (add-hook 'evil-mode-hook 'dw/evil-hook)
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
(defvar dw/is-termux nil) ; Dummy definition, replace it with the actual logic

(unless dw/is-termux
  ;; Disable arrow keys in normal and visual modes
  (define-key evil-normal-state-map (kbd "<left>") 'dw/dont-arrow-me-bro)
  (define-key evil-normal-state-map (kbd "<right>") 'dw/dont-arrow-me-bro)
  (define-key evil-normal-state-map (kbd "<down>") 'dw/dont-arrow-me-bro)
  (define-key evil-normal-state-map (kbd "<up>") 'dw/dont-arrow-me-bro)
  (evil-global-set-key 'motion (kbd "<left>") 'dw/dont-arrow-me-bro)
  (evil-global-set-key 'motion (kbd "<right>") 'dw/dont-arrow-me-bro)
  (evil-global-set-key 'motion (kbd "<down>") 'dw/dont-arrow-me-bro)
  (evil-global-set-key 'motion (kbd "<up>") 'dw/dont-arrow-me-bro))

  (unless dw/is-termux
    ;; Disable arrow keys in normal and visual modes
    (define-key evil-normal-state-map (kbd "<left>") 'dw/dont-arrow-me-bro)
    (define-key evil-normal-state-map (kbd "<right>") 'dw/dont-arrow-me-bro)
    (define-key evil-normal-state-map (kbd "<down>") 'dw/dont-arrow-me-bro)
    (define-key evil-normal-state-map (kbd "<up>") 'dw/dont-arrow-me-bro)
    (evil-global-set-key 'motion (kbd "<left>") 'dw/dont-arrow-me-bro)
    (evil-global-set-key 'motion (kbd "<right>") 'dw/dont-arrow-me-bro)
    (evil-global-set-key 'motion (kbd "<down>") 'dw/dont-arrow-me-bro)
    (evil-global-set-key 'motion (kbd "<up>") 'dw/dont-arrow-me-bro))

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :init
  (setq evil-collection-company-use-tng nil)  ;; Is this a bug in evil-collection?
  :custom
  (evil-collection-outline-bind-tab-p nil)
  :config
  (setq evil-collection-mode-list
        (remove 'lispy evil-collection-mode-list))
  (evil-collection-init))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :demand t
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Projects/Code")
    (setq projectile-project-search-path '("~/Projects/Code")))
  (setq projectile-switch-project-action #'dw/switch-project-action))

(use-package counsel-projectile
  :after projectile
  :bind (("C-M-p" . counsel-projectile-find-file))
  :config
  (counsel-projectile-mode))

(dw/leader-key-def
  "pf"  'counsel-projectile-find-file
  "ps"  'counsel-projectile-switch-project
  "pF"  'counsel-projectile-rg
  ;; "pF"  'consult-ripgrep
  "pp"  'counsel-projectile
  "pc"  'projectile-compile-project
  "pd"  'projectile-dired)

;; Install and configure org-download
(use-package org-download
  :ensure t
  :config
  (setq org-download-method 'directory)
  (setq org-download-heading-lvl nil))

;; Install and configure ox-pandoc
(use-package ox-pandoc
  :ensure t)

(use-package org-auto-tangle
 ;; :load-path "site-lisp/org-auto-tangle/"    ;; this line is necessary only if you cloned the repo in your site-lisp directory 
  :defer t
  :hook (org-mode . org-auto-tangle-mode))

(use-package symon
  :ensure t
  :config
  ;; Refresh rate in seconds
  (setq symon-refresh-rate 1)

  ;; System monitor display format
  (setq symon-format '(
                       symon-mode-line
                       symon-current-time
                       symon-linux-memory
                       symon-linux-cpu
                       symon-linux-network-rx
                       symon-linux-network-tx))

  ;; Customize the appearance of the system monitor
  (setq symon-mode-line-format
        '((:eval (propertize "" 'face `(:foreground "orange")))))
  (setq symon-linux-memory-format " %p% ")
  (setq symon-linux-cpu-format " %p% ")
  (setq symon-linux-network-rx-format " %s")
  (setq symon-linux-network-tx-format " %s")

  ;; Customize the colors of the system monitor
  (setq symon-color-allocation
        '((symon-mode-line . (:foreground "white" :background "blue"))
          (symon-current-time . (:foreground "white" :background "black"))
          (symon-linux-memory . (:foreground "white" :background "purple"))
          (symon-linux-cpu . (:foreground "white" :background "green"))
          (symon-linux-network-rx . (:foreground "white" :background "cyan"))
          (symon-linux-network-tx . (:foreground "white" :background "magenta"))))

  ;; Enable symon
  (symon-mode))

(use-package all-the-icons
  :ensure t
  :init)

(use-package all-the-icons-dired
  :ensure t
  :init (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

(use-package all-the-icons-ibuffer
  :ensure t
  :init (all-the-icons-ibuffer-mode 1))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'devil)
  (package-install 'devil))
(require 'devil)
(global-devil-mode)
(global-set-key (kbd "C-;") 'global-devil-mode)
(devil-set-key (kbd ";"))

(fset 'inserting\ an\ html\ tangle\ block
   (kmacro-lambda-form [?\; ?x ?\( ?s ?r ?c ?\C-x ?a ?e escape ?k ?k ?j ?A ?: backspace ?h backspace ?h ?t ?m ?l ?  ?: ?t ?a ?n ?g ?l ?e ?  ?d ?o ?c ?u ?m ?e ?n ?t C-backspace ?c ?h ?i ?l ?d ?N ?o ?d ?e ?s ?\( ?\) ?. ?h ?t ?m ?l escape ?h ?h ?h ?h ?h ?h ?h ?h ?h ?h ?h ?h ?h ?h ?h ?h ?i ?l ?i ?s ?t ?i ?n ?g ?_ escape ?o escape ?i] 0 "%d"))
