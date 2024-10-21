{ pkgs, ... }:
{  
  hardware = {
    bluetooth = {
      enable = true;
      poweronBoot = true;
    };

    # graphics = {
    #   enable = true;
    #   extraPackages = with pkgs; [
    #
    #   ];
    # };
  };
  hardware.enableRedistributableFirmware = true;
}
