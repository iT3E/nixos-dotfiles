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

  nvidiaPackage = config.boot.kernelPackages.nvidiaPackages.stable;

in
# if (lib.versionOlder nvBeta nvStable) then
#   config.boot.kernelPackages.nvidiaPackages.stable
# else
#   config.boot.kernelPackages.nvidiaPackages.beta;
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

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    package = nvidiaPackage;
    # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    #   version = "550.127.05";
    #   sha256_64bit = "sha256-04TzT10qiWvXU20962ptlz2AlKOtSFocLuO/UZIIauk=";
    #   sha256_aarch64 = "sha256-3wsGqJvDf8io4qFSqbpafeHHBjbasK5i/W+U6TeEeBY=";
    #   openSha256 = "sha256-r0zlWPIuc6suaAk39pzu/tp0M++kY2qF8jklKePhZQQ=";
    #   settingsSha256 = "sha256-cUSOTsueqkqYq3Z4/KEnLpTJAryML4Tk7jco/ONsvyg=";
    #   persistencedSha256 = "sha256-8nowXrL6CRB3/YcoG1iWeD4OCYbsYKOOPE374qaa4sY=";
    # };
    modesetting.enable = true;

    powerManagement = {
      enable = false;
      finegrained = false;
    };

    open = true;
    nvidiaSettings = true;
    # nvidiaPersistenced = true;
    # forceFullCompositionPipeline = true;
  };

  hardware.graphics = {
    extraPackages = with pkgs; [ nvidia-vaapi-driver ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ nvidia-vaapi-driver ];
  };
}
