{inputs, pkgs, config, ...}: 
let
  neovimconfig = import ./modules/home/nvim;
  nvim = inputs.nixvim.legacyPackages.x86_64-linux.makeNixvimWithModule {
    inherit pkgs;
    module = neovimconfig;
  };
in
{
  home.packages = with pkgs; [
    nvim
  ];

  imports =
        inputs.nixvim.homeManagerModules.nixvim
       [(import ./bat.nix)]                       # better cat command
    ++ [(import ./btop.nix)]                      # resouces monitor 
    ++ [(import ./cava.nix)]                      # audio visualizer
    ++ [(import ./discord.nix)]                   # discord with catppuccin theme
    ++ [(import ./floorp/floorp.nix)]             # firefox based browser
    ++ [(import ./fuzzel.nix)]                    # launcher
    ++ [(import ./gaming.nix)]                    # packages related to gaming
    ++ [(import ./git.nix)]                       # version control
    ++ [(import ./gtk.nix)]                       # gtk theme
    ++ [(import ./hyprland)]                      # window manager
    ++ [(import ./tmux)]                          # multiplexer
    ++ [(import ./kitty.nix)]                     # terminal
    ++ [(import ./swaync/swaync.nix)]             # notification deamon
    ++ [(import ./micro.nix)]                     # nano replacement
    ++ [(import ./nvim)]                          # neovim editor
    ++ [(import ./packages.nix)]                  # other packages
    ++ [(import ./retroarch.nix)]
    ++ [(import ./scripts/scripts.nix)]           # personal scripts
    ++ [(import ./starship.nix)]                  # shell prompt
    ++ [(import ./swaylock.nix)]                  # lock screen
    ++ [(import ./waybar)]                        # status bar
    ++ [(import ./zsh.nix)];                      # shell
}
