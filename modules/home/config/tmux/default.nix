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

            # Clear the status bar
            set -g status-left ""
            set -g status-right ""

            # Center the window status
            set -g status-justify centre

            # Set rounded separators
            set -g @catppuccin_window_left_separator "◖"
            set -g @catppuccin_window_right_separator "◗"

            # Customize window appearance
            set -g @catppuccin_window_default_text "#W"
            set -g @catppuccin_window_current_text "#W"

            # Ensure there's enough space
            set -g status-left-length 100
            set -g status-right-length 100
          '';
        }
      {
        plugin = resurrect;
        extraConfig = ''
            set -g @resurrect-save-command-strategy 'ps'
            set -g @resurrect-hook-post-save-all 'sed -E "s|:/nix/store/[^ ]+/bin/nvim.*nvim-ruby'\'''([[:space:]]+([^[:space:]]+))?|:nvim \\2|" -i <full-path-to-resurrect-dir>/last'
            set -g @resurrect-processes '"~nvim"'
        '';
      }
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
