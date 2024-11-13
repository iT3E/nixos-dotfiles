{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    # swww
    swaybg
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast # screenshots
    swappy # screenshot edit
    hyprpicker
    grim
    slurp
    wl-clip-persist
    wf-recorder
    glib
    wayland
    direnv
  ];
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.nixpkgs.legacyPackages.${pkgs.system}.hyprland;
    xwayland = {
      enable = true;
    };
    systemd.enable = true;
  };
}
