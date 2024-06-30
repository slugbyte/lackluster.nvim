# LACKLUSTER THEME BEGIN
color_lack="#708090"
color_luster="#deeeed"
color_orange="#ffaa88"
color_green="#789978"
color_blue="#7788AA"
color_red="#D70000"
color_black="#000000"
color_gray1="#080808"
color_gray2="#191919"
color_gray3="#2a2a2a"
color_gray4="#444444"
color_gray5="#555555"
color_gray6="#7a7a7a"
color_gray7="#aaaaaa"
color_gray8="#cccccc"
color_gray9="#DDDDDD"

# by default window names will just be their index
set-option -g automatic-rename              on
set-option -g automatic-rename-format       "#I"

# set to 12 for a 12-hour clock
set-option -g clock-mode-style              24 
set-option -g clock-mode-colour             "$color_gray6"

# NOTE: color variable expansion only works in double quotes
set-option -g status-fg                     "$color_luster"
set-option -g status-bg                     "$color_gray2"
set-option -g copy-mode-current-match-style "fg=$color_gray1,bg=$color_gray8"
set-option -g copy-mode-match-style         "fg=$color_gray1,bg=$color_gray8"
set-option -g menu-selected-style           "fg=$color_gray1,bg=$color_luster"
set-option -g menu-style                    "fg=$color_luster,bg=$color_gray1"
set-option -g message-style                 "bg=$color_gray6,fg=$color_gray1" # command in vi-insert mode
set-option -g message-command-style         "bg=$color_gray6,fg=$color_gray4" # command in vi-normal mode
set-option -g mode-style                    "bg=$color_gray8,fg=$color_gray1"
set-option -g pane-active-border-style      "fg=$color_gray1"
set-option -g pane-border-lines             "heavy"
set-option -g pane-border-style             "fg=$color_gray1"
set-option -g pane-border-style             "fg=$color_gray5"
set-option -g popup-border-lines            "rounded"
set-option -g status-right-style            "fg=$color_gray6"
set-option -g window-status-current-style   "fg=$color_gray8"
set-option -g window-status-style           "fg=$color_gray6"
set -g default-terminal "${TERM}"
set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0

# display the window index number or index-number:name if has a name
set-option -g window-status-format         '#{?#{==:#W,},#I,#I:#W}'
set-option -g window-status-current-format '#{?#{==:#W,},#I,#I:#W}'

# status right will show the time in 24 hour format and if there is more than one
# server session the current session name will be there too
set-option -g status-right                 ' #{?#{>:#{server_sessions},1},(#{session_name}),} #(date +"%H:%M") '
set-option -g status-left                  ' '
# LACKLUSTER THEME END
