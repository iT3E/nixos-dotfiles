{ inputs, self, ... }:
{
  imports = [
    # inputs.home-manager.nixosModules.home-manager
    # inputs.nixvim.homeManagerModules.nixvim
    ./config/bat.nix
    ./config/btop.nix
    ./config/cava.nix
    ./config/discord.nix
    ./config/floorp
    ./config/firefox
    ./config/fuzzel.nix
    ./config/gaming.nix
    ./config/git.nix
    ./config/gtk.nix
    ./config/hyprland
    ./config/tmux
    ./config/kitty.nix
    ./config/lazygit.nix
    ./config/swaync
    ./config/micro.nix
    # ./config/nvim
    ./config/packages.nix
    ./config/retroarch.nix
    ./config/scripts/scripts.nix
    ./config/starship.nix
    # ./config/steam.nix
    ./config/swaylock.nix
    ./config/waybar
    ./config/zsh.nix
  ];
}
