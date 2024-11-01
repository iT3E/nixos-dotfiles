{ pkgs, host, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.kernelPackages = pkgs.linuxPackages_6_6;
  boot.loader.systemd-boot.extraEntries =
    if (host == "desktop") then
      {
        "arch.conf" = ''
          title Arch
          efi   /EFI/endeavouros/grubx64.efi
        '';
      }
    else
      { };
}
