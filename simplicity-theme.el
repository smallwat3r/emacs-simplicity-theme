;;; simplicity-theme.el --- A dark minimalist Emacs 24 theme.

;; Copyright (C) 2021 Matthieu Petiteau

;; Author: Matthieu Petiteau <mpetiteau.pro@gmail.com>
;; Keywords: color, theme, minimal
;; X-URL: http://github.com/smallwat3r/emacs-simplicity-theme
;; URL: http://github.com/smallwat3r/emacs-simplicity-theme

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; A dark minimalist Emacs 24 theme.
;; Most of the colors have been turned off, which gets rid of any
;; distraction and improve focus on reading and writing code after
;; getting used to it.

;;; Code:
(unless (>= emacs-major-version 24)
  (error "Requires Emacs 24 or later"))

(deftheme simplicity "A dark minimalist theme")

(defgroup simplicity-theme nil
  "Simplicity theme."
  :group 'faces
  :prefix "simplicity-"
  :link '(url-link :tag "GitHub" "http://github.com/smallwat3r/emacs-simplicity-theme")
  :tag "Simplicity theme")

;;;###autoload
(defcustom simplicity-override-colors-alist '()
  "Place to override default theme colors.
You can override a subset of the theme's default colors by
defining them in this alist."
  :group 'simplicity-theme
  :type '(alist
          :key-type (string :tag "Name")
          :value-type (string :tag " Hex")))

(defvar simplicity-default-colors-alist
  '(("simplicity-foreground"    . "#e5e5e5")
    ("simplicity-background"    . "#050505")
    ("simplicity-cyan"          . "#97FFEB")
    ("simplicity-yellow"        . "#f2ff2a")
    ("simplicity-red"           . "#ff25a9")
    ("simplicity-green"         . "#47d400")
    ("simplicity-magenta"       . "#d409fb")
    ("simplicity-orange"        . "#ff5f00")
    ("simplicity-blue"          . "#68afff")
    ("simplicify-menu-bg"       . "#fffcb9")
    ("simplicity-comment-slate" . "#595959")
    ("simplicity-dark-slate"    . "#403D3D")
    ("simplicity-mid-gray"      . "#555555")
    ("simplicity-string"        . "#bdbdbd")
    ("simplicity-mode-back"     . "#1A1A1A")
    ("simplicity-menu-bg"       . "#fffcb9")
    ("simplicity-search-2-fg"   . "#010029"))
  "List of Simplicity colors.")

(defmacro simplicity-with-color-variables (&rest body)
  "`let' bind all colors defined in `simplicity-colors-alist' around BODY.
Also bind `class' to ((class color) (min-colors 89))."
  (declare (indent 0))
  `(let ((class '((class color) (min-colors 89)))
         ,@(mapcar (lambda (cons)
                     (list (intern (car cons)) (cdr cons)))
                   (append simplicity-default-colors-alist
                           simplicity-override-colors-alist)))
     ,@body))

(simplicity-with-color-variables
  (custom-theme-set-faces
   'simplicity

   ;; -------------- Frame ---------------
   ;; General
   `(default
      ((t (:background ,simplicity-background
           :foreground ,simplicity-foreground))))
   `(cursor
     ((t (:background ,simplicity-cyan
          :foreground ,simplicity-background))))
   `(hl-line ((t (:background ,simplicity-background))))
   `(fringe ((t (:background ,simplicity-background))))
   ;; Modeline
   `(mode-line-inactive
     ((t (:box nil
          :foreground ,simplicity-mid-gray
          :background ,simplicity-background))))
   `(mode-line
     ((t (:box nil
          :foreground ,simplicity-foreground
          :background ,simplicity-mode-back))))

   ;; -------------- Code ----------------
   ;; Highlight region color
   `(region
     ((t (:foreground ,simplicity-foreground
          :background ,simplicity-dark-slate))))
   ;; Dir-ed search prompt
   `(minibuffer-prompt ((default (:foreground ,simplicity-foreground))))
   ;; Builtins
   `(font-lock-builtin-face ((t (:foreground ,simplicity-foreground))))
   ;; Constants
   `(font-lock-constant-face ((t (:foreground ,simplicity-foreground))))
   ;; Comments
   `(font-lock-comment-face ((t (:foreground ,simplicity-comment-slate))))
   ;; Function names
   `(font-lock-function-name-face ((t (:foreground ,simplicity-foreground))))
   ;; Keywords
   `(font-lock-keyword-face ((t (:foreground ,simplicity-foreground))))
   ;; Strings
   `(font-lock-string-face ((t (:foreground ,simplicity-string))))
   ;; Variables
   `(font-lock-variable-name-face ((t (:foreground ,simplicity-foreground))))
   `(font-lock-type-face ((t (:foreground ,simplicity-foreground))))
   `(font-lock-warning-face ((t (:foreground ,simplicity-red :bold t))))
   ;; Paren
   `(show-paren-match
     ((t (:foreground ,simplicity-background
          :background ,simplicity-menu-bg))))
   `(show-paren-mismatch
     ((t (:foreground ,simplicity-red
          :weight bold))))
   ;; Line number
   `(line-number
     ((t (:background nil
          :foreground ,simplicity-comment-slate))))
   `(line-number-current-line
     ((t (:background nil
          :foreground ,simplicity-foreground))))
   ;; Search
   `(isearch
     ((t (:foreground ,simplicity-background
          :background ,simplicity-yellow
          :weight bold))))
   `(isearch-fail
     ((t (:foreground ,simplicity-red
          :bold t))))
   `(lazy-highlight
     ((t (:foreground ,simplicity-background
          :background ,simplicity-yellow
          :weight bold))))

   ;; ------------ Packages --------------
   ;; Ivy
   `(ivy-minibuffer-match-face-2
     ((t (:foreground ,simplicity-search-2-fg
          :background ,simplicity-cyan))))
   `(ivy-current-match
     ((t (:background ,simplicity-menu-bg
          :distant-foreground ,simplicity-background
          :weight bold))))
   `(ivy-posframe
     ((t (:background ,simplicity-menu-bg
          :foreground ,simplicity-foreground
          :weight bold))))
   ;; Flycheck
   `(flycheck-posframe-error-face ((t (:foreground ,simplicity-red))))
   `(flycheck-posframe-warning-face ((t (:foreground ,simplicity-yellow))))
   `(flycheck-posframe-info-face ((t (:foreground ,simplicity-green))))
   ;; Company
   `(company-tooltip
     ((t (:foreground ,simplicity-foreground
          :background ,simplicity-dark-slate))))
   `(company-tooltip-common
     ((t (:foreground ,simplicity-red
          :background ,simplicity-dark-slate))))
   `(company-tooltip-selection
     ((t (:background ,simplicity-dark-slate
          :foreground ,simplicity-red))))
   `(company-scrollbar-bg ((t (:background ,simplicity-dark-slate))))
   `(company-scrollbar-fg ((t (:background ,simplicity-foreground))))
   `(company-tooltip-annotation
     ((t (:background ,simplicity-dark-slate
          :foreground ,simplicity-green))))
   `(company-tooltip-annotation-selection
     ((t (:background ,simplicity-dark-slate
          :foreground ,simplicity-green))))
   ;; vTerm
   `(vterm-color-black
     ((t (:background ,simplicity-background
          :foreground ,simplicity-dark-slate))))
   `(vterm-color-blue
     ((t (:background ,simplicity-background
          :foreground ,simplicity-blue))))
   `(vterm-color-cyan
     ((t (:background ,simplicity-background
          :foreground ,simplicity-cyan))))
   `(vterm-color-default
     ((t (:background ,simplicity-background
          :foreground ,simplicity-foreground))))
   `(vterm-color-green
     ((t (:background ,simplicity-background
          :foreground ,simplicity-green))))
   `(vterm-color-inverse-video
     ((t (:background ,simplicity-background
          :inverse-video t))))
   `(vterm-color-magenta
     ((t (:background ,simplicity-background
          :foreground ,simplicity-magenta))))
   `(vterm-color-red
     ((t (:background ,simplicity-background
          :foreground ,simplicity-red))))
   `(vterm-color-white
     ((t (:background "white"
          :foreground "white"))))
   `(vterm-color-yellow
     ((t (:background ,simplicity-background
          :foreground ,simplicity-yellow))))
   ;; rainbow-delimiters
   `(rainbow-delimiters-depth-1-face ((t (:foreground ,simplicity-blue))))
   `(rainbow-delimiters-depth-2-face ((t (:foreground ,simplicity-green))))
   `(rainbow-delimiters-depth-3-face ((t (:foreground ,simplicity-magenta))))
   `(rainbow-delimiters-depth-4-face ((t (:foreground ,simplicity-cyan))))
   `(rainbow-delimiters-depth-5-face ((t (:foreground ,simplicity-yellow))))
   `(rainbow-delimiters-depth-6-face ((t (:foreground ,simplicity-red))))
   ;; dired
   `(dired-directory
     ((t (:background ,simplicity-background
          :foreground ,simplicity-orange))))
   `(dired-header
     ((t (:background ,simplicity-background
          :foreground ,simplicity-yellow))))
   ;; diredfl
   `(diredfl-dir-name ((t (:inherit dired-directory))))
   `(diredfl-dir-heading ((t (:inherit dired-header))))
   `(diredfl-exec-priv
     ((t (:background ,simplicity-background
          :foreground ,simplicity-red))))
   `(diredfl-executable-tag
     ((t (:background ,simplicity-background
          :foreground ,simplicity-cyan))))
   `(diredfl-read-priv
     ((t (:background ,simplicity-background
          :foreground ,simplicity-green))))
   `(diredfl-write-priv
     ((t (:background ,simplicity-background
          :foreground ,simplicity-magenta))))
   `(diredfl-no-priv
     ((t (:background ,simplicity-background
          :foreground ,simplicity-foreground))))
   `(diredfl-rare-priv
     ((t (:background ,simplicity-background
          :foreground ,simplicity-magenta))))
   `(diredfl-other-priv
     ((t (:background ,simplicity-background
          :foreground ,simplicity-yellow))))
   `(diredfl-dir-priv
     ((t (:background ,simplicity-background
          :foreground ,simplicity-orange))))
   `(diredfl-date-time
     ((t (:background ,simplicity-background
          :foreground ,simplicity-foreground))))
   `(diredfl-file-name
     ((t (:background ,simplicity-background
          :foreground ,simplicity-foreground))))
   `(diredfl-file-suffix
     ((t (:background ,simplicity-background
          :foreground ,simplicity-yellow))))
   `(diredfl-number
     ((t (:background ,simplicity-background
          :foreground ,simplicity-foreground))))
   `(diredfl-flag-mark
     ((t (:background ,simplicity-background
          :foreground ,simplicity-magenta))))
   ;; git-gutter
   `(git-gutter-fr:added ((t (:background ,simplicity-green))))
   `(git-gutter-fr:modified ((t (:background ,simplicity-yellow))))
   `(git-gutter-fr:deleted ((t (:background ,simplicity-red))))
   ))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name)))
  (when (not window-system)
    (custom-set-faces '(default ((t (:background nil)))))))

(provide-theme 'simplicity)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; simplicity-theme.el ends here
