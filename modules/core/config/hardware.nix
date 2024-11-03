{ pkgs, ... }:
{  
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    graphics = {
      enable = true;
      extraPackages = with pkgs; [
      ];
    };
    # opengl = {
    #     enable = true;
    #   };
  };
  hardware.enableRedistributableFirmware = true;
}
