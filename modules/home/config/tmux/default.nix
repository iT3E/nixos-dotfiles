{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./config/tmux.conf;
    terminal = "screen-256color";

    # Plugins
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      {
          plugin = catppuccin;
          extraConfig = ''
            set -g @catppuccin_flavor 'mocha'
            set -g @catppuccin_window_status_style "rounded"

            # Status bar icons configuration
            set -g @catppuccin_status_modules_right "application session date_time"
            set -g @catppuccin_status_left_separator "█"
            set -g @catppuccin_status_right_separator "█"

            # For rounded separators, use these instead:
            # set -g @catppuccin_status_left_separator ""
            # set -g @catppuccin_status_right_separator ""

            # Center alignment
            set -g @catppuccin_status_justify "centre"

            # Icon settings
            set -g @catppuccin_icon_window_last "󰖰"
            set -g @catppuccin_icon_window_current "󰖯"
            set -g @catppuccin_icon_window_zoom "󰁌"
            set -g @catppuccin_icon_window_mark "󰃀"
            set -g @catppuccin_icon_window_silent "󰂛"
            set -g @catppuccin_icon_window_activity "󰖲"
            set -g @catppuccin_icon_window_bell "󰂞"
          '';
        }
      # {
      #   plugin = power-theme;
      #   extraConfig = "set -g @themepack 'powerline/default/green'";
      # }
      resurrect
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
    ];
  };
}
