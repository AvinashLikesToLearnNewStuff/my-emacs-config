;;; devil-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "devil" "devil.el" (0 0 0 0))
;;; Generated autoloads from devil.el

(autoload 'devil-mode "devil" "\
Local minor mode to support Devil key sequences.

If called interactively, enable Devil mode if ARG is positive,
and disable it if ARG is zero or negative.  If called from Lisp,
also enable the mode if ARG is omitted or nil, and toggle it if
ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(put 'global-devil-mode 'globalized-minor-mode t)

(defvar global-devil-mode nil "\
Non-nil if Global Devil mode is enabled.
See the `global-devil-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-devil-mode'.")

(custom-autoload 'global-devil-mode "devil" nil)

(autoload 'global-devil-mode "devil" "\
Toggle Devil mode in all buffers.
With prefix ARG, enable Global Devil mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Devil mode is enabled in all buffers where
`devil--on' would do it.
See `devil-mode' for more information on Devil mode.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "devil" '("devil")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; devil-autoloads.el ends here
