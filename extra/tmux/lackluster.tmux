# This file is inspired by [zenbones tmux extra](https://github.com/mcchrish/zenbones.nvim/tree/main/extras/tmux)
set -g status-left ' #[fg=#080808,bold]#{s/root//:client_key_table} '
set -g status-right '#[fg=#080808,bold] [#S]#[fg=#080808,bold] [%d/%m] #[fg=#080808,bold][%I:%M%p] '
set -g status-style fg='#080808',bg='#DEEEED'

set -g window-status-current-style fg='#708090',bg='#DEEEED',bold

set -g pane-border-style fg='#708090'
set -g pane-active-border-style fg='#708090'

set -g message-style fg='#DEEEED',bg='#708090'

set -g display-panes-active-colour '#708090'
set -g display-panes-colour '#708090'

set -g clock-mode-colour '#708090'

set -g mode-style fg='#DEEEED',bg='#708090'
