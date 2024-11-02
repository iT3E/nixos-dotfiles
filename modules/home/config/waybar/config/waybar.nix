{ pkgs, inputs, ... }:
let
  stable = inputs.nixpkgs-stable.legacyPackages.${pkgs.system};
in
{
  programs.waybar = {
    enable = true;
  };

  programs.waybar.package = stable.waybar.overrideAttrs (oa: {
    mesonFlags = (oa.mesonFlags or [ ]) ++ [
      "-Dexperimental=true"
      "-Dwireplumber=disabled"
      "-Dpipewire=disabled"
    ];
  });
}
