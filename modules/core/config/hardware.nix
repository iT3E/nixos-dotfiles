{ pkgs, ... }:
{  
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    # graphics = {
    #   enable = true;
    #   extraPackages = with pkgs; [
    #
    #   ];
    # };
  };
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;
}
