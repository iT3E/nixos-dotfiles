{
  pkgs,
  inputs,
  self,
  ...
}:
{
  configure-gtk = pkgs.callPackage ./configure-gtk/default.nix { };
  tokyonight-gtk-theme = pkgs.callPackage ./tokyonight-gtk-theme/default.nix { };
  tokyonight-icon-theme = pkgs.callPackage ./tokyonight-icon-theme/default.nix { };
  nvim-plugins = pkgs.callPackage ./nvim-plugins/default.nix { };
  neovim = (inputs.nixvim.legacyPackages.x86_64-linux.makeNixvimWithModule {
    inherit pkgs;
    module = { config, lib, ... }: {
      imports = [(import ../modules/home/config/nvim {
        inherit pkgs;
        nvim-plugins = pkgs.callPackage ./nvim-plugins/default.nix { };
      })];
    };
  });
}
