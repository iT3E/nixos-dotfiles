{ config, pkgs, lib, ... }:
{
  imports = [
    ./config/plugins.nix
    ./config/general.nix
    ./config/appearance.nix
    ./config/autocmds.nix
    ./config/keymaps.nix
  ];
  options = {
    nvim-plugins = lib.mkOption {
      type = lib.types.attrs;
      description = "Nvim plugins to use";
    };
  };
  config = {
    extraFiles = {
      "lua/utils.lua" = builtins.readFile ./config/lua/utils.lua;
    };
  };
}
