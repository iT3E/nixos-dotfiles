{ inputs, pkgs, ... }:
let
  stable = inputs.nixpkgs-stable.legacyPackages.${pkgs.system};
in
{
  programs.hyprland = {
    enable = true;
    package = stable.hyprland;
  };
  services.xdg-desktop-portal.enable = false;
  services.xdg-desktop-portal-hyprland.enable = false;
  services.xdg-desktop-portal-gtk.enable = false;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      stable.xdg-desktop-portal-hyprland
      stable.xdg-desktop-portal-gtk
    ];
  };

  environment.systemPackages = with pkgs; [
    # xwaylandvideobridge
  ];
}
