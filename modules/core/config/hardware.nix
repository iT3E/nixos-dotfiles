{ pkgs, ... }:
{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    graphics = {
      enable = true;
    };
    # opengl = {
    #     enable = true;
    #   };
  };
  hardware.enableRedistributableFirmware = true;
}
