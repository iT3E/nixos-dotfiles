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
            # Configure Catppuccin
            set -g @catppuccin_flavor "macchiato"
            set -g @catppuccin_status_background "none" # none == default
            set -g @catppuccin_pane_status_enabled "off"
            set -g @catppuccin_pane_border_status "off"

            # status left look and feel
            set -g status-left-length 80
            set -g status-left ""
            set -ga status-left "#[fg=#{@thm_green}]#{?client_prefix,#[bg=#{@thm_crust}]#[reverse]#[bold] 󰕮 #S , 󰕮 #[fg=#{@thm_fg}]#S}"
            set -ga status-left "#[bg=default,fg=#{@thm_overlay_0},none] | "
            set -ga status-left "#[fg=#{@thm_maroon}]󰆍 #[fg=#{@thm_fg}]#{pane_current_command}"
            set -ga status-left "#[bg=default,fg=#{@thm_overlay_0},none] | "
            set -ga status-left "#[fg=#{@thm_blue}]󰝰 #[fg=#{@thm_fg}]#{=/-32/...:#{s|$USER|~|:#{b:pane_current_path}}}"
            set -ga status-left "#[fg=#{@thm_overlay_0},none]#{?window_zoomed_flag, │ ,}"
            set -ga status-left "#[fg=#{@thm_yellow}]#{?window_zoomed_flag,󰖯 #[fg=#{@thm_fg}]zoom,}"

            # status right look and feel
            set -g status-right-length 80
            set -g status-right ""
            set -ga status-right "#[fg=#{@thm_pink}]#{?#{>=:10%,#{battery_percentage}},#[bg=#{@thm_crust}]#[reverse]#[bold] #{battery_icon} #{battery_percentage} ,#{battery_icon} #[fg=#{@thm_fg}]#{battery_percentage}}"
            set -ga status-right "#[bg=default,fg=#{@thm_overlay_0}, none] | "
            set -ga status-right "#[fg=#{@thm_blue}]󰃶 #[fg=#{@thm_fg}]%Y-%m-%d"
            set -ga status-right "#[bg=default,fg=#{@thm_overlay_0}, none] "
            set -ga status-right "#[fg=#{@thm_blue}]󰅐 #[fg=#{@thm_fg}]%H:%M"
            set -ga status-right "#[fg=#{@thm_overlay_0}, none] "

            # Configure Tmux
            set -g status-position top
            set -g status-style "bg=default"
            set -g status-justify "absolute-centre"

            # pane border look and feel
            setw -g pane-border-status top
            setw -g pane-border-format ""
            setw -g pane-active-border-style "bg=default,fg=#{@thm_overlay_0}"
            setw -g pane-border-style "bg=default,fg=#{@thm_surface_0}"
            setw -g pane-border-lines single

            # window look and feel
            set -wg automatic-rename on
            set -g automatic-rename-format "Window"

            set -g window-status-format "#I#{?#{!=:#{window_name},Window},: #W,}"
            set -g window-status-style "fg=#{@thm_fg}"
            set -g window-status-last-style "fg=#{@thm_peach}"
            set -g window-status-activity-style "fg=#{@thm_red},bold"
            set -g window-status-bell-style "fg=#{@thm_red},bold"
            set -gF window-status-separator "#[fg=#{@thm_overlay_0}] │ "

            set -g window-status-current-format " #I#{?#{!=:#{window_name},Window},: #W,} "
            set -g window-status-current-style "bg=#{@thm_peach},fg=#{@thm_bg},bold"
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
