# THEME
# lackluster base colors

set-option -g status-fg                     "#deeeed"
set-option -g status-bg                     "#080808"
set-option -g clock-mode-colour             "#080808"
set-option -g copy-mode-current-match-style "bg=#080808,fg=#deeeed"
set-option -g copy-mode-match-style         "bg=#080808,fg=#deeeed"
set-option -g menu-selected-style           'bg=#080808,fg=#deeeed'
set-option -g menu-style                    'bg=#deeeed,fg=#080808'
set-option -g message-command-style         'bg=#080808,fg=#deeeed'
set-option -g message-style                 'bg=#deeeed,fg=#080808'
set-option -g mode-style                    'bg=#080808,fg=#deeeed'
set-option -g pane-active-border-style      "fg=#080808"
set-option -g pane-border-lines             "heavy"
set-option -g pane-border-style             "fg=#080808"
set-option -g pane-border-style             "fg=#deeeed"
set-option -g popup-border-lines            "rounded"
set-option -g status-right-style            "fg=#deeeed"
set-option -g window-status-current-style   'fg=#708090'
set-option -g window-status-style           'fg=#deeeed'

set-option -g window-status-format         '#{?#{==:#W,},#I,#I:#W}'
set-option -g window-status-current-format '#{?#{==:#W,},#I,#I:#W}'

# status right will show the time in 24 hour format and if there is more than one
# server session the current session name will be there too
set-option -g status-right                 ' #{?#{>:#{server_sessions},1},(#{session_name}),} #(date +"%H:%M") '
set-option -g status-left                  ' '
