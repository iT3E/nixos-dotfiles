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
      "lua/utils.lua" = builtins.readFile ./config/lua/utils.lua;
    };
  };
}