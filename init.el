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
 '(custom-enabled-themes '(spacemacs-dark))
 '(custom-safe-themes
   '("7fd8b914e340283c189980cd1883dbdef67080ad1a3a9cc3df864ca53bdc89cf" default))
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(company dashboard rainbow-delimiters switch-window rainbow-mode avy smex ido-vertical-mode org-bullets beacon spacemacs-theme which-key use-package cmake-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "GOOG" :family "FiraCode Nerd Font")))))
