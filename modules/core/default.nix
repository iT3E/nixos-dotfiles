{ pkgs, inputs, nixpkgs, self, username, host, system, ...}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./bootloader.nix
    ./hardware.nix
    ./xserver.nix
    ./network.nix
    ./pipewire.nix
    ./program.nix
    ./security.nix
    ./services.nix
    ./system.nix
    ./wayland.nix
    ./virtualization.nix
  ];

  home.packages = with pkgs; [
    self.legacyPackages.${system}.neovim
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username host; };
    users.${username} = {
      # home.packages = with pkgs; [
      #   self.legacyPackages.${system}.neovim
      # ];
      imports = 
        if (host == "desktop") then 
          [ ./../home/default.desktop.nix ] 
        else [ ./../home/default.nix ];
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;
    };
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
  nix.settings.allowed-users = [ "${username}" ];
}
