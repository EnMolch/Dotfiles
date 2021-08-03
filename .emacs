(setf inhibit-startup-screen t)
(setf inferior-lisp-program "sbcl")
(scroll-bar-mode -1)
(menu-bar-mode -1)
(setf ring-bell-function 'ignore)
(setq package-enable-at-startup nil)
(tool-bar-mode -1)
(global-display-line-numbers-mode 1)

(defun kill-other-buffers ()
"Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(setq backup-directory-alist '(("." . ".emacs_saves")))

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)
;;(global-set-key (kbd ""))

(require 'evil)
(evil-mode 1)
(evil-set-leader 'normal (kbd "SPC"))
(evil-define-key 'normal 'global (kbd "<leader>fs") 'save-buffer)
(evil-define-key 'normal 'global (kbd "<leader>ff") 'find-file)
(evil-define-key 'insert 'global (kbd "C-n") 'next-line )
(evil-define-key 'insert 'global (kbd "C-p") 'previous-line)
(evil-define-key 'normal 'global (kbd "<leader>bo") 'kill-other-buffers)

(evil-define-key 'normal 'global (kbd "<leader>wh") 'evil-window-left)
(evil-define-key 'normal 'global (kbd "<leader>wj") 'evil-window-down)
(evil-define-key 'normal 'global (kbd "<leader>wk") 'evil-window-up)
(evil-define-key 'normal 'global (kbd "<leader>wl") 'evil-window-right)
(evil-define-key 'normal 'global (kbd "<leader>wd") 'delete-window)

(require 'which-key)
(which-key-mode)

(setq lsp-keymap-prefix "<leader>l")
(require 'lsp-mode)
(require 'lsp-pyright)
(add-hook 'python-mode-hook #'lsp)

(use-package doom-modeline :ensure t)
(doom-modeline-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes '(doom-dracula))
 '(custom-safe-themes
   '("1704976a1797342a1b4ea7a75bdbb3be1569f4619134341bd5a4c1cfb16abad4" "6c386d159853b0ee6695b45e64f598ed45bd67c47f671f69100817d7db64724d" "b0e446b48d03c5053af28908168262c3e5335dcad3317215d9fdeb8bac5bacf9" "4a5aa2ccb3fa837f322276c060ea8a3d10181fecbd1b74cb97df8e191b214313" "e19ac4ef0f028f503b1ccafa7c337021834ce0d1a2bca03fcebc1ef635776bea" "e8df30cd7fb42e56a4efc585540a2e63b0c6eeb9f4dc053373e05d774332fc13" "6b1abd26f3e38be1823bd151a96117b288062c6cde5253823539c6926c3bb178" "f302eb9c73ead648aecdc1236952b1ceb02a3e7fcd064073fb391c840ef84bca" "e6a2832325900ae153fd88db2111afac2e20e85278368f76f36da1f4d5a8151e" "b7e460a67bcb6cac0a6aadfdc99bdf8bbfca1393da535d4e8945df0648fa95fb" "7a7b1d475b42c1a0b61f3b1d1225dd249ffa1abb1b7f726aec59ac7ca3bf4dae" "0466adb5554ea3055d0353d363832446cd8be7b799c39839f387abb631ea0995" "824d07981667fd7d63488756b6d6a4036bae972d26337babf7b56df6e42f2bcd" default))
 '(exwm-floating-border-color "#121212")
 '(fci-rule-color "#515151")
 '(highlight-tail-colors ((("#1d2416" "#1d2416") . 0) (("#232c30" "#202c30") . 20)))
 '(jdee-db-active-breakpoint-face-colors (cons "#171F24" "#FFFFFF"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#171F24" "#468800"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#171F24" "#777778"))
 '(objed-cursor-color "#FF5E5E")
 '(package-selected-packages
   '(sly tabbar which-key lsp-pyright jedi flycheck lsp-mode python-mode dash doom-modeline doom-themes haskell-mode evil dracula-theme ## slime))
 '(pdf-view-midnight-colors (cons "#d4d4d4" "#191919"))
 '(rustic-ansi-faces
   ["#191919" "#FF5E5E" "#468800" "#E9FDAC" "#8CDAFF" "#C586C0" "#85DDFF" "#d4d4d4"])
 '(vc-annotate-background "#191919")
 '(vc-annotate-color-map
   (list
    (cons 20 "#468800")
    (cons 40 "#7caf39")
    (cons 60 "#b2d672")
    (cons 80 "#E9FDAC")
    (cons 100 "#efd98e")
    (cons 120 "#f5b671")
    (cons 140 "#FC9354")
    (cons 160 "#e98e78")
    (cons 180 "#d78a9c")
    (cons 200 "#C586C0")
    (cons 220 "#d8789f")
    (cons 240 "#eb6b7e")
    (cons 260 "#FF5E5E")
    (cons 280 "#dd6464")
    (cons 300 "#bb6a6b")
    (cons 320 "#997071")
    (cons 340 "#515151")
    (cons 360 "#515151")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
