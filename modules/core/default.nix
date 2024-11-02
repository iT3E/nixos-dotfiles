{ inputs, host, lib, self, ...}:
{
  imports = [
    ./config/bootloader.nix
    ./config/hardware.nix
    ./config/xserver.nix
    ./config/network.nix
    ./config/pipewire.nix
    ./config/program.nix
    ./config/security.nix
    ./config/services.nix
    ./config/system.nix
    ./config/wayland.nix
    ./config/virtualization.nix
    ./config/home-manager.nix
    (lib.mkIf (host == "desktop") ./config/nvidia.nix)
  ];
}
