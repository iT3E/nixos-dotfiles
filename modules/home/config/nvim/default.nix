{ pkgs, nvim-plugins ? null }:
{
  imports = [
    (import ./config/plugins.nix { inherit nvim-plugins; })
    ./config/general.nix
    ./config/appearance.nix
    ./config/autocmds.nix
    ./config/keymaps.nix
  ];
  config = {
    extraFiles = {
      "lua/utils.lua" = builtins.readFile ./lua/utils.lua;
    };
  };
}
