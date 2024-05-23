
(setq native-comp-async-report-warnings-errors nil)

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
 '(package-selected-packages
   '(ido-vertical-mode org-roam company dashboard rainbow-mode rainbow-delimiters rainbow-delimeters org-bullets switch-window smex)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;Disable auto-backup files
(setq make-backup-files nil)

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

;; Enable ido-mode, better file suggestion when C-x C-f
;; Obtained from Uncle Dave tutorial https://youtu.be/JWMxvY2dFYA?si=P5VLijIeK09U5NDB
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)

;; Enable ido suggestion vertically
(use-package ido-vertical-mode
  :ensure t
  :init	(ido-vertical-mode 1))
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

;; enable smex for a better usage of M-x
;; (use-package smex
;;   :ensure t
;;   :init (smex-initialize)
;;   :bind("M-x" . smex))

;; Turn off windows ring sound effect
;; Obtained from https://emacs.stackexchange.com/questions/28906/how-to-switch-off-the-sounds
(set-message-beep 'silent)

;; Improve buffer selection
;; Obtained from Uncle Dave tutorial https://youtu.be/JWMxvY2dFYA?si=P5VLijIeK09U5NDB
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-x b") 'ibuffer)
(setq ibuffer-expert t)

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

;; Improve how bullets look in org-mode
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; kill all buffers
;; Obtained from Uncle Dave https://youtu.be/crDdqZWgZw8?si=ty5RNqoJw65-qpEo
(defun kill-all-buffers()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))
(global-set-key (kbd "C-M-S-k") 'kill-all-buffers)

;; Make main menu nicer
;; Obtained from Uncle Dave https://youtu.be/LB3GOLoJEws?si=DPkE4L1F1QEhNPNw
;; use-package with package.el:
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

;; Auto-completion
(use-package company
  :ensure t
  :init
  (add-hook ' after-init-hook 'global-company-mode))

;; RETURN will follow links in org-mode files
;; Obtained from Reddit https://www.reddit.com/r/emacs/comments/kpoiqi/how_to_follow_links_in_orgmode_without_using_mouse/
(setq org-return-follows-link  t)

;; Use org-roam to use org-mode as a neural network
;; Obtained from Chris Maiorama https://youtu.be/KlYctaKMixA?si=WZ0ve1Qc9qOHuUEs
;; Obtained from System Crafters https://youtu.be/AyhPmypHDEw?si=gDCA0kejoGAWjOq7 https://systemcrafters.net/build-a-second-brain-in-emacs/getting-started-with-org-roam/
(use-package org-roam
  :ensure t
  :init(setq org-roam-v2-ack t)
  :config(org-roam-db-autosync-enable)
  :bind(
	:map org-mode-map("C-M-i" . completion-at-point)))
(setq org-roam-directory (file-truename "~/org-roam"))
(setq org-roam-completion-everywhere t)
(global-set-key (kbd "C-c n l") 'org-roam-buffer-toggle)
(global-set-key (kbd "C-c n f") 'org-roam-node-find)
(global-set-key (kbd "C-c n i") 'org-roam-node-insert)
(global-set-key (kbd "C-c a") 'org-agenda)

;; Enable SPC in mini buffer
;; Obtained from Reddit https://www.reddit.com/r/emacs/comments/x7ml9w/how_to_enable_spaces_in_minibuffer_especially_for/
(define-key minibuffer-local-completion-map (kbd "SPC") 'self-insert-command)

;; Implement indentation in org-mode for all lines
;; Obtained from https://orgmode.org/manual/Hard-indentation.html
(setq org-adapt-indentation t
      org-hide-leading-stars t
      org-odd-levels-only t)

;; Play sound on startup
;; Function obtained from https://www.gnu.org/software/emacs/manual/html_node/elisp/Sound-Output.html
;; Samsung Windows XP startup sound
(play-sound (list 'sound :file (expand-file-name "~/.emacs.d/media/startup_sound.wav")))

