;; Disable package.el because Nix manages packages
(setq package-enable-at-startup nil)

;; Basic UI cleanup
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode 5)
(tooltip-mode -1)

(setq visible-bell t)
;; Better defaults
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)

;; Use y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Fonts
(set-face-attribute 'default nil
                    :family "JetBrainsMono Nerd Font"
                    :height 100
                    :weight 'medium)

;; Proportional font for prose
(set-face-attribute 'variable-pitch nil
                    :family "EB Garamond"
                    :height 120
                    :weight 'regular)

;; Monospace
(set-face-attribute 'fixed-pitch nil
                    :family "JetBrainsMono Nerd Font"
                    :height 100
                    :weight 'medium)

(use-package ligature
  :config
  ;; Enable ligatures in programming modes
  (ligature-set-ligatures
   'prog-mode
   '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\"
     "{-" "[]" "::" ":::" ":=" "!!" "!=" "!==" "-}"
     "--" "---" "-->" "->" "->>" "-<" "-<<" "-~"
     "#{" "#[" "##" "###" "####" "#(" "#?" "#_"
     ".-" ".=" ".." "..<" "..." "?=" "??" ";;"
     "/*" "/**" "/=" "/==" "/>" "//" "///"
     "&&" "||" "||=" "|=" "|>" "^="
     "++" "+++" "+>"
     "==" "===" "==>" "=>" "=>>"
     "<=" "<==" "<=>" "<>" "<<" "<<-" "<<<"
     "<~" "<~~" "</" "</>"
     "~@" "~-" "~=" "~>" "~~"))

  (global-ligature-mode t))


;; Autosave and backup

;; Store backup files in ~/.config/emacs/backups
(setq backup-directory-alist
      `(("." . "~/.config/emacs/backups")))

;; Store autosave files in ~/.config/emacs/autosaves
(setq auto-save-file-name-transforms
      `((".*" "~/.config/emacs/autosaves/" t)))

(setq create-lockfiles nil)

;; Line numbers
(column-number-mode)
(setq display-line-numbers-type 'relative)
(setq display-line-numbers-current-absolute t)
(setq display-line-numbers-width 4)
(setq display-line-numbers-grow-only t)

(global-display-line-numbers-mode t)

(dolist (mode '(term-mode-hook
		eshell-mode-hook
		vterm-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(set-face-attribute 'line-number nil
                    :background "#191919"
                    :foreground "#3d3839"
                    :weight 'regular)

(set-face-attribute 'line-number-current-line nil
                    :background "#191919"
                    :foreground "#8e8e8e"
                    :weight 'medium)

;; Scrolling
(setq scroll-margin 10)
(setq scroll-conservatively 101) ;; don't jump cursor
(setq scroll-step 1)

;; Packages
(require 'use-package)

;; Theme
(use-package base16-theme)
(load-theme 'base16-gruvbox-material-light-soft t)
;; (load-theme 'base16-black-metal-gorgoroth t)

;; Alternative theme
;; (use-package alabaster-themes
;;     :config
;;   ;; Load the light theme
;;   (load-theme 'alabaster-themes-light t)
;;   ;; Interactively select a theme
;;   :commands (alabaster-themes-select))

;; ;; Main background / foreground
;; (set-face-attribute 'default nil
;;                     :background "#191919"
;;                     :foreground "#bbbbbb")

;; Fringe / gutter
(set-face-background 'fringe "#191919")

;; Region selection
(set-face-background 'region "#404040")
(set-face-foreground 'region "#191919")

;; Comments
(set-face-attribute 'font-lock-comment-face nil
                    :foreground "#6f6a69"
                    :slant 'italic)

;; Cursor
(set-cursor-color "#c9c9c9")

;; Line spacing
(setq-default line-spacing 0.15)

;; Mode line => Mood-line
(use-package mood-line
  :config
  (setq mood-line-glyph-alist mood-line-glyphs-unicode)
  (mood-line-mode))

;; Paredit
(use-package paredit
  :hook ((emacs-lisp-mode
          lisp-mode
          lisp-interaction-mode
          scheme-mode
          clojure-mode) . paredit-mode))

(use-package enhanced-evil-paredit
  :commands enhanced-evil-paredit-mode
  :hook (paredit-mode . enhanced-evil-paredit-mode))

;; Ivy
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy.done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

 (use-package ivy-rich
   :init
   (ivy-rich-mode 1))

;; Counsel
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 ("C-x d" . counsel-dired)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ;; so it doesn't start searches with "^"

;; Which key
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

;; Helpful for better docs
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; Evil mode
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)

  :config
  (evil-mode 1)

  ;; Escape insert mode
  (define-key evil-insert-state-map (kbd "C-g")
              #'evil-normal-state)

  ;; Better backspace behavior
  (define-key evil-insert-state-map (kbd "C-h")
              #'evil-delete-backward-char-and-join)

  ;; Visual line motions
  (evil-global-set-key 'motion "j"
                       #'evil-next-visual-line)

  (evil-global-set-key 'motion "k"
                       #'evil-previous-visual-line)

  ;; Arrow keys follow visual lines too
  (evil-global-set-key 'motion (kbd "<down>")
                       #'evil-next-visual-line)

  (evil-global-set-key 'motion (kbd "<up>")
                       #'evil-previous-visual-line))

;; Prevent :q from exiting emacs
(defun my/evil-write-and-close ()
  "Save current buffer and kill it."
  (interactive)
  (save-buffer)
  (kill-current-buffer))

(evil-ex-define-cmd "wq" #'my/evil-write-and-close)
(evil-ex-define-cmd "q" #'kill-current-buffer)

;; Modes where evil should not interfere
(dolist (mode '(term-mode
                vterm-mode
                eshell-mode
                shell-mode
                inferior-python-mode
                messages-buffer-mode))
  (evil-set-initial-state mode 'emacs))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

(use-package evil-commentary
  :config
  (evil-commentary-mode))

(use-package undo-tree
  :init
  (global-undo-tree-mode)

  :custom
  (undo-tree-auto-save-history nil))

(setq evil-undo-system 'undo-tree)

;; Vterm
(use-package vterm
  :commands vterm
  :config
  (setq vterm-max-scrollback 10000)
  (setq vterm-shell "/etc/profiles/per-user/alexx/bin/fish"))

;; Don't use evil within vterm
(evil-set-initial-state 'vterm-mode 'emacs)

;; Buffer naming for vterm
(defvar my/vterm-counter 0)

(defun my/new-vterm-buffer-name ()
  (setq my/vterm-counter (1+ my/vterm-counter))
  (format "*vterm:%d*" my/vterm-counter))

(defun my/open-vterm ()
  (let ((buffer-name
         (my/new-vterm-buffer-name)))

    ;; create terminal
    (vterm buffer-name)

    ;; mark current window as owning this terminal
    (set-window-parameter
     (selected-window)
     'my/vterm-buffer
     (current-buffer))))

(defun my/vterm-split-right ()
  (interactive)

  (split-window-right)
  (other-window 1)

  (my/open-vterm))

(defun my/vterm-split-below ()
  (interactive)

  (split-window-below)
  (other-window 1)

  (my/open-vterm))

(defun my/delete-window ()
  (interactive)

  (let* ((window (selected-window))
         (buffer
          (window-parameter
           window
           'my/vterm-buffer)))

    ;; remove visual split
    (delete-window window)

    ;; kill associated terminal
    (when (and buffer
               (buffer-live-p buffer))
      (kill-buffer buffer))))

;; Open dired from current terminal
(defun my/dired-here ()
  (interactive)
  (dired default-directory))

;; General
(use-package general
  :config
  (general-create-definer my/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC"))
;; Leader key bindings
(my/leader-keys
  "f"  '(:ignore t :which-key "files")
  "fd" '(counsel-dired :which-key "dired")
  "ff" '(counsel-find-file :which-key "find file")
  "fs" '(save-buffer :which-key "save")

  "b"  '(:ignore t :which-key "buffers")
  "bb" '(counsel-switch-buffer :which-key "switch buffer")
  "bd" '(kill-current-buffer :which-key "kill buffer")

  "w"  '(:ignore t :which-key "windows")
  "wv" '(split-window-right :which-key "vertical split")
  "ws" '(split-window-below :which-key "horizontal split")
  "wd" '(delete-window :which-key "delete")
  "wh" '(windmove-left :which-key "left")
  "w<left>" '(windmove-left :which-key "left")
  "wl" '(windmove-right :which-key "right")
  "w<right>" '(windmove-right :which-key "right")
  "wk" '(windmove-up :which-key "up")
  "w<up>" '(windmove-up :which-key "up")
  "wj" '(windmove-down :which-key "down")
  "w<down>" '(windmove-down :which-key "down")

  "t"  '(:ignore t :which-key "terminal")
  "tt" '(vterm :which-key "open")
  "tv" '(my/vterm-split-right
         :which-key "vterm vertical")
  "ts" '(my/vterm-split-below
         :which-key "vterm horizontal")
  "td" '(my/delete-window
         :which-key "delete window")
  "t." '(my/dired-here :which-key "dired here"))

;; Org mode appearance
(use-package org
  :hook (org-mode . my/org-mode-setup)
  :config
  (setq org-ellipsis " ")

  ;; Replace list hyphen with dot
  (font-lock-add-keywords
   'org-mode
   '(("^ *\\([-]\\) "
      (0 (prog1 ()
           (compose-region
            (match-beginning 1)
            (match-end 1)
            "•"))))))

  ;; Better heading sizes
  (custom-theme-set-faces
   'user

   ;; headings
   '(org-level-1 ((t (:height 1.4 :weight bold))))
   '(org-level-2 ((t (:height 1.3 :weight bold))))
   '(org-level-3 ((t (:height 1.2 :weight semi-bold))))
   '(org-level-4 ((t (:height 1.15 :weight semi-bold))))

   ;; document title
   '(org-document-title
     ((t (:height 1.5 :weight bold))))

   ;; fixed-pitch elements
   '(org-block ((t (:inherit fixed-pitch))))
   '(org-code ((t (:inherit (shadow fixed-pitch)))))
   '(org-table ((t (:inherit fixed-pitch))))
   '(org-verbatim ((t (:inherit (shadow fixed-pitch)))))
   '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-checkbox ((t (:inherit fixed-pitch))))))

(defun my/org-mode-setup ()
  ;; prose wrapping
  (visual-line-mode 1)

  ;; variable width text
  (variable-pitch-mode 1)

  ;; no line numbers in org
  (display-line-numbers-mode 0)
  (setq-local visual-fill-column-width 100)
  (setq-local visual-fill-column-center-text t))

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package visual-fill-column)

;; Corfu completion

(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-auto t)
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match 'insert) ;; Configure handling of exact matches

  ;; Enable Corfu only for certain modes. See also `global-corfu-modes'.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  :init

  ;; Recommended: Enable Corfu globally.  Recommended since many modes provide
  ;; Capfs and Dabbrev can be used globally (M-/).  See also the customization
  ;; variable `global-corfu-modes' to exclude certain modes.
  (global-corfu-mode)

  ;; Enable optional extension modes:
  ;; (corfu-history-mode)
  ;; (corfu-popupinfo-mode)
  )

(use-package emacs
  :custom
  ;; TAB cycle if there are only few candidates
  ;; (completion-cycle-threshold 3)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete)

  ;; Emacs 30 and newer: Disable Ispell completion function.
  ;; Try `cape-dict' as an alternative.
  (text-mode-ispell-word-completion nil)

  ;; Hide commands in M-x which do not apply to the current mode.  Corfu
  ;; commands are hidden, since they are not used via M-x. This setting is
  ;; useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p))

(use-package eglot
  :hook
  ((c-mode c++-mode cuda-mode) . eglot-ensure)
  (rust-mode . eglot-ensure)
  )

(use-package rust-mode)

