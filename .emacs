(add-to-list 'load-path "~/.emacs.d/color-theme/")
(load-file "~/.emacs.d/color-theme/color-theme.el")

(global-font-lock-mode t)                      ; Highlighting...
(setq font-lock-maximum-decoration t)          ; ...as much as possible...

;; Set deafult window position
(if (window-system) (set-frame-position (selected-frame) 0 0))

;;Mute sound
(setq ring-bell-function 'ignore)

;; Reopen buffers from last session on startup
(desktop-save-mode 1)

;; ------------ Sublime Text Color Theme -----------
(defun sublime-text-2 ()
  (interactive)
  (color-theme-install
   '(sublime-text-2
     ((background-color . "#272822")
      (background-mode . light)
      (border-color . "#1a1a1a")
      (cursor-color . "#fce94f")
      (foreground-color . "#eeeeec")
      (mouse-color . "black"))
     (fringe ((t (:background "#1a1a1a"))))
     (mode-line ((t (:foreground "#33333c" :background "#b5b7b3"))))
     (mode-line-inactive ((t (:foreground "#eeeeec" :background "#5a5a5a"))))
     (region ((t (:foreground "#303030" :background "#cc9900"))))
     (font-lock-reference-face ((t (:foreground "red"))))
     (font-lock-builtin-face ((t (:foreground "#00d3b8"))))
     (font-lock-constant-face ((t (:foreground "#00d3b8"))))
     (font-lock-comment-face ((t (:foreground "#8ae234"))))
     (font-lock-function-name-face ((t (:foreground "#ece47e" :bold t))))
     (font-lock-keyword-face ((t (:foreground "#ff007f"))))
     (font-lock-string-face ((t (:foreground "#ece47e"))))
     (font-lock-type-face ((t (:foreground"#00d3b8"))))
     (font-lock-variable-name-face ((t (:foreground "#ece47e"))))
     (minibuffer-prompt ((t (:foreground "#eeeeec" :bold t))))
     (font-lock-warning-face ((t (:foreground "Red" :bold t))))
     )))
(provide 'sublime-text-2)
(require 'color-theme)
(setq color-theme-is-global t)
(color-theme-initialize)
(sublime-text-2)

;; -- Colors for i-search --
(defun isearch-face-settings ()
  "Face settings for isearch."
  (set-face-foreground 'isearch "#303030")
  (set-face-background 'isearch "#cc9900")
  (set-face-foreground 'lazy-highlight "#1a1a1a")
  (set-face-background 'lazy-highlight "#eeeeec")
  (custom-set-faces '(isearch-fail ((((class color)) (:background "red" :bold t))))))
(eval-after-load "isearch"
  `(isearch-face-settings))
(provide 'isearch-face-settings)

;; No tab indent. Indent 2 spaces.
(setq-default tab-width 2)
(setq js-indent-level 2)
(setq-default indent-tabs-mode nil)

;; Append newline to end of file
(setq-default require-final-newline t)

;; Remove trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Set default directory to home and disable splash screen
(setq default-directory "~/")
(setq inhibit-startup-message t)

;; Make delete work the way it is supposed to...
(define-key global-map '[delete] 'delete-char)

;; Make delete delete everything in the highlighted area
(delete-selection-mode t)

;; Define a key binding for goto-line
(define-key global-map "\C-x\C-g" 'goto-line)

;; Delete word backwards
(global-set-key (kbd "<M-kp-delete>") 'backward-kill-word)

;; Map auto complete to C-Enter
(global-set-key '[(control return)] 'dabbrev-expand)

(transient-mark-mode t)

;; Make emacs auto reload buffers when files have changed on disk.
(global-auto-revert-mode t)

;; Show matching parenthasesis
(show-paren-mode 1)

;; Make sure we don't get unneccessary new lines at the end of file.
(setq next-line-add-newlines nil)

;; Only scroll one step at a time
(setq scroll-step 2)
(setq scroll-conservatively 10000)
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq mouse-wheel-scroll-amount '(2 ((shift) . 1) ((control) . nil)))

;; Show current line and column counters
(setq line-number-mode t)
(setq column-number-mode t)

;; Show full path to files in the menu bar
(setq frame-title-format
      '(buffer-file-name "%f" (dired-directory dired-directory "%b")))

;; Balance windows after splits and merges.
(defun split-windows-horizontally-evenly ()
  (interactive)
  (command-execute 'split-window-right)
  (command-execute 'balance-windows))
(global-set-key (kbd "C-x 3") 'split-windows-horizontally-evenly)

(defun delete-windows-horizontally-evenly ()
  (interactive)
  (command-execute 'delete-window)
  (command-execute 'balance-windows))
(global-set-key (kbd "C-x 0") 'delete-windows-horizontally-evenly)

;; Command to delete current line
(defvar previous-column nil "Save the column position")
(defun nuke-line()
  "Kill an entire line, including the trailing newline character"
  (interactive)
  (setq previous-column (current-column))
  (end-of-line)
  (if (= (current-column) 0)
      (delete-char 1)
    (progn
      (beginning-of-line)
      (kill-line)
      (delete-char 1)
      (move-to-column previous-column))))
(global-set-key (kbd "C-q") 'nuke-line)

;; Switch to previous buffer with M-Enter or C-Enter
(defun switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))
(global-set-key (kbd "<M-kp-enter>") 'switch-to-previous-buffer)
(global-set-key (kbd "<C-kp-enter>") 'switch-to-previous-buffer)

;; Use ctrl-tab to cycle buffers
(global-set-key  (kbd "<C-tab>") 'next-buffer)
(global-set-key  (kbd "<C-S-tab>") 'previous-buffer)

;; Google tags bindings
;;(global-set-key [(?\M-.)] 'gtags-feeling-lucky) ;; equiv: find-tag
;;(global-set-key [(?\M-,)] 'gtags-next-tag)      ;; equiv: tags-loop-continue
;;(global-set-key [(?\M-*)] 'gtags-pop-tag)       ;; equiv: pop-tag-mark
;;(global-set-key (kbd "C-c c") 'gtags-show-callers)
;;(global-set-key (kbd "C-c t") 'gtags-show-tag-locations-under-point)

;; Set default curson and font face
(setq-default cursor-type 'bar)
(set-default-font "Source Code Pro 12")
(setq scroll-preserve-screen-position t)

;; Make meta be for fast navigation
(define-key global-map [M-left]  'beginning-of-line)
(define-key global-map [M-right] 'end-of-line)
(define-key global-map [M-up]  'beginning-of-buffer)
(define-key global-map [M-down] 'end-of-buffer)

;; Use regex searches by default.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; duplicate the current line or region
(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))
(global-set-key (kbd "C-x d") 'duplicate-current-line-or-region)
(global-set-key (kbd "C-c d") 'duplicate-current-line-or-region)

(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-v") 'yank)

;; Remove scrollbars and toolbars on startup
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; Shortcut to (un)comment section
(global-set-key (kbd "C-c C-c") 'comment-region)
(global-set-key (kbd "C-c C-v") 'uncomment-region)

;; Switch buffers better shortcut
(global-set-key (kbd "C-`") (kbd "C-x b"))

;; Kill buffer better shortcut
(global-set-key (kbd "M-q") (kbd "C-x k"))

;; Save cursor position and return. Useful when scrolling around.
(global-set-key (kbd "M-1") (kbd "C-<SPC> C-<SPC>"))
(global-set-key (kbd "M-2") (kbd "C-u C-<SPC>"))

;; Put auto save files in system temp directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Jump to next error
(global-set-key (kbd "<XF86Launch9>") 'next-error)
(global-set-key (kbd "<XF86Launch8>") 'previous-error)

;; Enable copy/paste to other apps
(setq x-select-enable-clipboard t)

;; -------------- LaTeX specific stuff ----------------------------
;; This line tells emacs where to find the latex compiler
(setenv "PATH" (concat "/usr/texbin:" (getenv "PATH")))
;; This line tells emacs to create pdf files instead of dvi files.
(setq-default TeX-PDF-mode t)
(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
      '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))

;; Start emacs in server mode so that skim can talk to it.
(server-start)
'(LaTeX-command "latex -synctex=1")
(add-hook 'TeX-mode-hook
          (lambda ()
            (add-to-list 'TeX-output-view-style
                         '("^pdf$" "."
                           "/Applications/Skim.app/Contents/SharedSupport/displayline -b %n %o %b"))))

;; ----------- Google specific stuff -----------------------------
;; (require 'google-imports)
;; (require 'p4-google)                ;; g4-annotate, improves find-file-at-point
;; (require 'compilation-colorization) ;; colorizes output of (i)grep
;; (require 'rotate-clients)           ;; google-rotate-client
;; (require 'rotate-among-files)       ;; google-rotate-among-files
;; (require 'googlemenu)               ;; handy Google menu bar
;; (require 'p4-files)                 ;; transparent support for Perforce filesystem
;; (require 'google3)                  ;; magically set paths for compiling google3 code
;; (require 'google3-build)            ;; support for blaze builds
;; (setq google-build-system "blaze")

;; ;; Switch between cc and h files easily
;; (global-set-key (kbd "<C-kp-add>") 'google-rotate-among-files)

;; ;; Compile on F16
;; (global-set-key (kbd "<XF86Launch7>") 'google3-build)
;; (global-set-key (kbd "<C-XF86Launch7>") 'google3-test)

;; ;; Highlight lines over 80 chars wide
;; (custom-set-faces
;;  '(my-long-line-face ((((class color)) (:background "grey20"))) t))
;; (add-hook 'font-lock-mode-hook
;;           (function
;;            (lambda ()
;;              (setq font-lock-keywords
;;                    (append font-lock-keywords
;;                            '(("^.\\{81,\\}$" (0 'my-long-line-face t))))))))

;; Set Clang to format code
;;(load "/usr/lib/clang-format/clang-format.el")
;;(global-set-key (kbd "C-f") 'indent-for-tab-command)
;;(add-hook 'c-mode-common-hook (function (lambda () (local-set-key (kbd "<tab>") 'clang-format-region))))

;;(setq p4-use-p4config-exclusively t)
;;(load-file "/home/build/public/eng/elisp/google.el")
;;(load-file "/usr/local/google/home/alexanderfaxa/.fill-column-indicator.el")

(setq debug-on-error t)
