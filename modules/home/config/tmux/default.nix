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
            
            # Set rounded separators
            set -g @catppuccin_window_left_separator ""
            set -g @catppuccin_window_right_separator ""
            set -g @catppuccin_window_middle_separator "█"
            
            # Clear the status bar
            set -g status-left ""
            set -g status-right ""
            
            # Center the window status
            set -g status-justify centre
            
            # Customize window appearance
            set -g @catppuccin_window_default_text "#W"
            set -g @catppuccin_window_current_text "#W"
            
            # Ensure there's enough space
            set -g status-left-length 100
            set -g status-right-length 100
          '';
        }
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
