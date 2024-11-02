{
  config,
  lib,
  pkgs,
  ...
}:

let
  # use the latest possible nvidia package
  nvStable = config.boot.kernelPackages.nvidiaPackages.stable.version;
  nvBeta = config.boot.kernelPackages.nvidiaPackages.beta.version;

  nvidiaPackage =
    if (lib.versionOlder nvBeta nvStable) then
      config.boot.kernelPackages.nvidiaPackages.stable
    else
      config.boot.kernelPackages.nvidiaPackages.beta;
in
{
  boot.blacklistedKernelModules = [ "nouveau" ];

  environment.systemPackages = with pkgs; [
    nvfancontrol
    nvtopPackages.nvidia
    mesa
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
    vulkan-extension-layer
  ];

  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    opengl = {
      enable = true;
    }
    nvidia = {
      package = nvidiaPackage;
      modesetting.enable = true;

      powerManagement = {
        enable = false;
        finegrained = false;
      };

      open = true;
      nvidiaSettings = true;
      nvidiaPersistenced = true;
      # forceFullCompositionPipeline = true;
    };

    # graphics = {
    #   extraPackages = with pkgs; [ nvidia-vaapi-driver ];
    #   extraPackages32 = with pkgs.pkgsi686Linux; [ nvidia-vaapi-driver ];
    # };
  };
}
