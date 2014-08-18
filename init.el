;;; init.el --- Where all the magic begins
;;
;; Part of the Emacs Starter Kit
;;
;; This is the first thing to get loaded.
;;

;; load Org-mode from source when the ORG_HOME environment variable is set
(when (getenv "ORG_HOME")
  (let ((org-lisp-dir (expand-file-name "lisp" (getenv "ORG_HOME"))))
    (when (file-directory-p org-lisp-dir)
      (add-to-list 'load-path org-lisp-dir)
      (require 'org))))

;; load the starter kit from the `after-init-hook' so all packages are loaded
(add-hook 'after-init-hook
 `(lambda ()
    ;; remember this directory
    (setq starter-kit-dir
          ,(file-name-directory (or load-file-name (buffer-file-name))))
    ;; only load org-mode later if we didn't load it just now
    ,(unless (and (getenv "ORG_HOME")
                  (file-directory-p (expand-file-name "lisp"
                                                      (getenv "ORG_HOME"))))
       '(require 'org))
    ;; load up the starter kit
    (org-babel-load-file (expand-file-name "starter-kit.org" starter-kit-dir))))


(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

;; Use monokai-theme
(load-theme 'monokai t)

;; Display line numbers
(global-linum-mode t)

;; Disable generating #file#
(setq auto-save-default nil)

;; Disable backup file
(setq backup-inhibited t)

;; Command prompt when using M-x
(icomplete-mode 1)

;; Haml mode
(require 'haml-mode)
(add-hook 'haml-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (define-key haml-mode-map "\C-m" 'newline-and-indent)))

;; Enable ECB
(require 'ecb)
(global-set-key (kbd "C-x C-e")  'ecb-activate)

;; Open shell
(global-set-key (kbd "C-1") 'shell)

;; Enable flyspell check within auctex
(setq ispell-program-name "/usr/local/bin/aspell")

;; Go-to-line 
(global-set-key (kbd "M-g") 'goto-line)

(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist
    (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))

;; Julia mode
(load "~/.emacs.d/ESS/lisp/ess-site")
(setq inferior-julia-program-name "/Applications/Julia-0.2.1.app/Contents/Resources/julia/bin/julia")

;;; init.el ends here
(put 'upcase-region 'disabled nil)


