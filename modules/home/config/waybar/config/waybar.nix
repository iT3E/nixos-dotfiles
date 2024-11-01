{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
  };
  programs.waybar.package =
    (pkgs.waybar.override {
      wireplumberSupport = false;
    }).overrideAttrs
      (oa: {
        mesonFlags = (oa.mesonFlags or [ ]) ++ [ "-Dexperimental=true" ];
      });
}
