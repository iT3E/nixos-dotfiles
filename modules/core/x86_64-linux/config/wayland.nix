{ inputs, pkgs, ... }:
let
  stable = inputs.nixpkgs-stable.legacyPackages.${pkgs.system};
in
{
  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  environment.systemPackages = with pkgs; [
    # xwaylandvideobridge
  ];
}
