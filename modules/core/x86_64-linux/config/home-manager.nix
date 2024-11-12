{
  pkgs,
  inputs,
  username,
  host,
  self,
  ...
}:

let
  hostConfig = {
    "desktop" = ../../../home/default.desktop.nix;
    "xps" = ../../../home/default.xps.nix;
    "mac" = ../../../home/default.mac.nix;
  };
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs username host;
    };
    users.${username} = {
      imports = [ (hostConfig.${host}) ];
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;
    };
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [
      "networkmanager"
      "wheel"
      "bluetooth"
      "audio"
      "input"
    ];
    shell = pkgs.zsh;
  };

  nix.settings.allowed-users = [ "${username}" ];
}
