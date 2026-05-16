;; Disable package.el because Nix manages packages
(setq package-enable-at-startup nil)

;; Basic UI cleanup
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Better defaults
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)

;; Use y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;; Fonts
(set-face-attribute 'default nil
                    :font "JetBrainsMono Nerd Font"
                    :height 100)
;; Autosave and backup

;; Store backup files in ~/.config/emacs/backups
(setq backup-directory-alist
      `(("." . "~/.config/emacs/backups")))

;; Store autosave files in ~/.config/emacs/autosaves
(setq auto-save-file-name-transforms
      `((".*" "~/.config/emacs/autosaves/" t)))

(setq create-lockfiles nil)

;; Packages
(require 'use-package)

;; Theme
(use-package base16-theme)
(load-theme 'base16-black-metal-marduk t)

(font-family-list)
