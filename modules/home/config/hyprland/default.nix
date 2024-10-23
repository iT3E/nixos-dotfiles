{ config, pkgs, inputs, ... }:

{
  imports = [
    ./config/hyprland.nix
    ./config/config.nix
    ./config/hyprlock.nix
    ./config/variables.nix
    inputs.hyprland.homeManagerModules.default
  ];
}
