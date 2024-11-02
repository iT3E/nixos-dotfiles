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

  hardware = {
    nvidia = {
      package = nvidiaPackage;
      modesetting.enable = true;

      powerManagement = {
        enable = true;
        finegrained = false;
      };

      open = true;
      nvidiaSettings = false;
      nvidiaPersistenced = true;
      forceFullCompositionPipeline = true;
    };

    graphics = {
      extraPackages = with pkgs; [ nvidia-vaapi-driver ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ nvidia-vaapi-driver ];
    };
  };
}
