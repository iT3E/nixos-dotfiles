{ nvim-plugins ? null }:
{
  imports = [
    ./config/plugins.nix
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
  _module.args.nvim-plugins = nvim-plugins;
}
