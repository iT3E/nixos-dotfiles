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
    "desktop" = ../../home/default.desktop.nix;
    "laptop" = ../../home/default.nix;
    "mac" = ../../home/default.server.nix;
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
    ];
    shell = pkgs.zsh;
  };

  nix.settings.allowed-users = [ "${username}" ];
}
