{ pkgs, inputs, nixpkgs, self, username, host, system, ...}:
# let
#   neovimconfig = import ../modules/home/nvim;
#   nvim = inputs.nixvim.legacyPackages.x86_64-linux.makeNixvimWithModule {
#     inherit pkgs;
#     module = neovimconfig;
#   };
# in
# {
#   home.packages = with pkgs; [
#     nvim
#   ];
#
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.nixvim.homeManagerModules.nixvim
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
