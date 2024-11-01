{ inputs, pkgs, ... }:
let
  stable = inputs.nixpkgs-stable.legacyPackages.${pkgs.system};
in
{
  programs.hyprland = {
    enable = true;
    package = stable.hyprland;
  };
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
