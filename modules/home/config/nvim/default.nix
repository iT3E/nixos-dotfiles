{ nvim-plugins ? null, ... }:
{
  imports = [
    ./config/plugins.nix
    ./config/general.nix
    ./config/appearance.nix
    ./config/autocmds.nix
    ./config/keymaps.nix
  ];
  _module.args = {
    inherit nvim-plugins;
  };
  config = {
    extraFiles = {
      "lua/utils.lua" = builtins.readFile ./lua/utils.lua;
    };
  };
}
