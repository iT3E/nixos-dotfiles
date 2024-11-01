{ inputs, pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    package = inputs.nixpkgs-stable.legacyPackages.${pkgs.system}.hyprland;
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      inputs.nixpkgs-stable.legacyPackages.${pkgs.system}.xdg-desktop-portal-hyprland
      inputs.nixpkgs-stable.legacyPackages.${pkgs.system}.xdg-desktop-portal-gtk
    ];
  };

  environment.systemPackages = with pkgs; [
    # xwaylandvideobridge
  ];
}
