{ pkgs, ... }:
{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket,Gateway";
          Experimental = true;
          KernelExperimental = true;
          MultiProfile = "multiple";
        };
        Policy = {
          AutoEnable = true;
        };
      };
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
