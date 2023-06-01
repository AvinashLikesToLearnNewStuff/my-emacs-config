(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa"."https://melpa.org/packages/")) 

(package-initialize)


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(unless (package-installed-p 'spacemacs-theme)
  (package-refresh-contents)
  (package-install 'spacemacs-theme))



(defalias 'yes-or-no-p 'y-or-n-p)

(org-babel-load-file (expand-file-name "/home/avinash/.emacs.d/config.org") ) 

(global-set-key (kbd "<s-return>") 'ansi-term)


(setq scroll-conservatively 100)

(setq ring-bell-function 'ignore)

(when window-system (global-hl-line-mode t))


(when window-system (global-prettify-symbols-mode t))

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(use-package beacon
  :ensure t
  :init
  (beacon-mode 1))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(custom-enabled-themes '(spacemacs-dark))
 '(custom-safe-themes
   '("7fd8b914e340283c189980cd1883dbdef67080ad1a3a9cc3df864ca53bdc89cf" default))
 '(evil-mode t)
 '(global-command-log-mode t)
 '(hl-todo-keyword-faces
   '(("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f")))
 '(ispell-dictionary nil)
 '(ivy-rich-mode t)
 '(org-fontify-done-headline nil)
 '(org-fontify-todo-headline nil)
 '(package-selected-packages
   '(yasnippet-snippets yasnippet cape corfu all-the-icons-ibuffer all-the-icons-dired all-the-icons catwoe-theme exwm-systemtray nerd-icons-dired ox-pandoc expand-region try undo-tree auto-complete ox-haunt auto-org-md general catppuccin-theme helpful counsel ivy-rich command-log-mode org-easy-img-insert org-download evil swiper popup-kill-ring dmenu exwm symon diminish spaceline company dashboard rainbow-delimiters switch-window rainbow-mode avy smex ido-vertical-mode org-bullets beacon spacemacs-theme which-key use-package cmake-mode))
 '(pdf-view-midnight-colors '("#b2b2b2" . "#292b2e"))
 '(rustic-ansi-faces
   (vector
    (catppuccin-get-color 'surface1)
    (catppuccin-get-color 'red)
    (catppuccin-get-color 'green)
    (catppuccin-get-color 'yellow)
    (catppuccin-get-color 'blue)
    (catppuccin-get-color 'pink)
    (catppuccin-get-color 'teal)
    (catppuccin-get-color 'subtext1))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "GOOG" :family "FiraCode Nerd Font"))))
 '(font-lock-comment-face ((t (:foreground "#5E5E5E"))))
 '(font-lock-doc-face ((t (:inherit font-lock-comment-face))))
 '(line-number ((t (:foreground "#5E5E5E"))))
 '(line-number-current-line ((t (:foreground "#D4D4D4" :weight bold)))))
