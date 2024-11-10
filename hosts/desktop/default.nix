{ pkgs, self, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core/x86_64-linux
  ];

  powerManagement.cpuFreqGovernor = "performance";
}
