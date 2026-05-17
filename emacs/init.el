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
                    :weight 'semi-bold)

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
		eshell-mode-hook))
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
(load-theme 'base16-black-metal-gorgoroth t)

;; Main background / foreground
(set-face-attribute 'default nil
                    :background "#191919"
                    :foreground "#bbbbbb")

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


