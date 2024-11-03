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
  hardware.enableRedistributableFirmware = true;
  hardware.opengl.enable = true;
}
