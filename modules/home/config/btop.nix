{ pkgs, lib, ... }:
{
  programs.btop = {
    enable = true;

    settings = {
      color_theme = "dracula";
      theme_background = false;
      update_ms = 500;
    };
  };

  home.packages = (
    with pkgs;
    [
    ]
    ++ lib.optionals (host == "desktop") [
      nvtopPackages.intel
    ]

  );
}
