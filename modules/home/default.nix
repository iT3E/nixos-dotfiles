{ inputs, ...}:
{
  imports = [
    # inputs.home-manager.nixosModules.home-manager
    # inputs.nixvim.homeManagerModules.nixvim
    ./config/bat.nix
    ./config/btop.nix
    ./config/cava.nix
    ./config/discord.nix
    ./config/floorp
    ./config/fuzzel.nix
    ./config/gaming.nix
    ./config/git.nix
    ./config/gtk.nix
    ./config/hyprland
    ./config/tmux
    ./config/kitty.nix
    ./config/swaync
    ./config/micro.nix
    ./config/nvim
    ./config/packages.nix
    ./config/retroarc.nix
    ./config/scripts/scripts.nix
    ./config/starship.nix
    ./config/swaylock.nix
    ./config/waybar.nix
    ./config/zsh.nix
  ];
}

