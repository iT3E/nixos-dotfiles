{inputs, pkgs, config, ...}: 
let
  neovimconfig = import ../nvim;
  nvim = inputs.nixvim.legacyPackages.x86_64-linux.makeNixvimWithModule {
    inherit pkgs;
    module = neovimconfig;
  };
in
{
  home.packages = with pkgs; [
    nvim
  ];
{
  imports = [
    ./config/plugins.nix
    ./config/general.nix
    ./config/appearance.nix
    ./config/autocmds.nix
    ./config/keymaps.nix
  ];

  vim.extraFiles."lua/utils.lua" = builtins.readFile ./config/lua/utils.lua;
}
