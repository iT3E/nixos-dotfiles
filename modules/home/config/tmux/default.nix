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

            # Use catppuccin's window status format
            set -g window-status-current-format "#[fg=#{@thm_bg},bg=#{@thm_blue}] #W #[fg=#{@thm_blue},bg=#{@thm_bg}]"
            set -g window-status-format "#[fg=#{@thm_fg},bg=#{@thm_gray}] #W #[fg=#{@thm_gray},bg=#{@thm_bg}]"
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
