{
  pkgs,
  host,
  lib,
  ...
}:
{
  networking = {
    hostName = lib.mkMerge [
      (lib.mkIf (host == "desktop") "nixos-desktop")
      (lib.mkIf (host == "xps") "nixos-xps")
    ];
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" ];
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
      ];
      allowedUDPPorts = [ ];
      # allowedUDPPortRanges = [
      # { from = 4000; to = 4007; }
      # { from = 8000; to = 8010; }
      # ];
    };
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
