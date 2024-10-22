{ pkgs, ... }: 
let
  nixvimConfig = {
    imports = [
      ./config/plugins.nix
      ./config/general.nix
      ./config/appearance.nix
      ./config/autocmds.nix
      ./config/keymaps.nix
    ];

    enable = true;

    vim.extraFiles."lua/utils.lua" = builtins.readFile ./config/lua/utils.lua;
  };
in nixvimConfig
