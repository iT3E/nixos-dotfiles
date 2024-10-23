{ inputs, ...}:
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
    ./config/homemanager.nix
  ];
}
