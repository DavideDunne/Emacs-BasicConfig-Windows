;; This is the basic emacs config, as seen in the video by Uncle Dave https://youtu.be/8Zkte37UOnA?si=R2B3iHLMgFb9-zwL
;; Remove the tool bar (file, edit, etc) and menu bar (the bar with icons)
;; init.el, should be in ~/.emacs.d/init.el
;; in windows it should be in C:\Users\user\AppData\Roaming\.emacs.d
(tool-bar-mode -1)
(menu-bar-mode -1)

;; To customize theme with UI: M-x customize-themes
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tango-dark))
 '(package-selected-packages '(switch-window smex)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Add melpa package manager source
;; https://melpa.org/#/getting-started
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; make sure all packages are updated
;; obtained from tutorial by Uncle Dave https://youtu.be/mBPQI71XaXU?si=-SWZLDxG8z2b4LNG
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Disable emacs main menu
;; https://youtu.be/4ZAKItc16OE?si=vrWHSbUqSKNcsUk5
(setq inhibit-startup-message t)

;; Emacs will start in the file explorer buffer
;; It will start in home directory, in windows it should be C:\Users\user\AppData\Roaming
(find-file "~/")

;; Enable ido-mode, better file suggestion when C-x C-f
;; Obtained from Uncle Dave tutorial https://youtu.be/JWMxvY2dFYA?si=P5VLijIeK09U5NDB
(setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)

;; Turn off windows ring sound effect
;; Obtained from https://emacs.stackexchange.com/questions/28906/how-to-switch-off-the-sounds
(set-message-beep 'silent)

;; Improve buffer selection
;; Obtained from Uncle Dave tutorial https://youtu.be/JWMxvY2dFYA?si=P5VLijIeK09U5NDB
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-x b") 'ibuffer)
(setq ibuffer-expert t)

;; Play sound on startup
;; Function obtained from https://www.gnu.org/software/emacs/manual/html_node/elisp/Sound-Output.html
;; Samsung Windows XP startup sound
(play-sound (list 'sound :file (expand-file-name "~/.emacs.d/media/startup_sound.wav")))

;; Disable creation of backup files
;; Obtained from Xah http://xahlee.info/emacs/emacs/emacs_set_backup_into_a_directory.html
(setq make-backup-files nil)

;; Open init.el, config
;; C-c e
;; Obtained from Uncle Dave https://youtu.be/3DcmEvOKUj0?si=B4XYnIB5R55-F_ww
(defun config-visit()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "C-c e") 'config-visit)

;; Apply config changes to emacs
;; C-c r
;; Obtained from Uncle Dave https://youtu.be/3DcmEvOKUj0?si=B4XYnIB5R55-F_ww
(defun config-reload()
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/init.el")))
(global-set-key (kbd "C-c r") 'config-reload)

;; Improve emacs window select
;; Obtained from https://github.com/dimitri/switch-window/blob/master/README.md#configure-and-usage
(use-package switch-window :ensure t)
(global-set-key (kbd "C-x o") 'switch-window)
(global-set-key (kbd "C-x 1") 'switch-window-then-maximize)
(global-set-key (kbd "C-x 2") 'switch-window-then-split-below)
(global-set-key (kbd "C-x 3") 'switch-window-then-split-right)
(global-set-key (kbd "C-x 0") 'switch-window-then-delete)
(global-set-key (kbd "C-x 4 d") 'switch-window-then-dired)
(global-set-key (kbd "C-x 4 f") 'switch-window-then-find-file)
(global-set-key (kbd "C-x 4 m") 'switch-window-then-compose-mail)
(global-set-key (kbd "C-x 4 r") 'switch-window-then-find-file-read-only)
(global-set-key (kbd "C-x 4 C-f") 'switch-window-then-find-file)
(global-set-key (kbd "C-x 4 C-o") 'switch-window-then-display-buffer)
(global-set-key (kbd "C-x 4 0") 'switch-window-then-kill-buffer)

;; Show line number
;; Obtained from https://www.emacswiki.org/emacs/LineNumbers
(global-display-line-numbers-mode 1)
