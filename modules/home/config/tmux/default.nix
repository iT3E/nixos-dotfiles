{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./config/tmux.conf;
    # Optional but recommended settings
    terminal = "tmux-256color";
    clock24 = true;
    # You can add other tmux settings here if you don't want them in tmux.conf
    # For example:
    # shortcut = "a"; # Changes prefix key from C-b to C-a
    # baseIndex = 1;  # Start windows numbering at 1
  };
}
