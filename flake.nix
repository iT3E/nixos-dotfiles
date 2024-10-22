{
  description = "iT3E's NixOS configurations";

  inputs = {
    # nixpkgs and unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # flake-parts - very lightweight flake framework
    # https://flake.parts
    flake-parts.url = "github:hercules-ci/flake-parts";

    # home-manager - home user modules
    # https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";
  
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
  
    nix-gaming.url = "github:fufexan/nix-gaming";

    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };

    # sops-nix - secrets with `sops`
    # https://github.com/Mic92/sops-nix
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Disko - declarative disk partitioning and formatting
    # https://github.com/nix-community/disko
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NUR - Nix User Repository
    # https://github.com/nix-community/NUR
    nur.url = "github:nix-community/NUR";

    # nvfetcher - tool to automate nix packages updates
    # https://github.com/berberman/nvfetcher
    nvfetcher = {
      url = "github:berberman/nvfetcher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixvim - Neovim distribution built around Nix modules
    # https://github.com/nix-community/nixvim
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Catppuccin for Nix - Soothing pastel theme for Nix
    # https://github.com/catppuccin/nix
    catppuccin.url = "github:catppuccin/nix";

    # nixGL - A wrapper tool for nix OpenGL application
    # https://github.com/nix-community/nixGL
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

outputs = { nixpkgs, self, ...} @ inputs:
  let
    username = "it";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
  in
  {
    formatter.${system} = pkgs.nixfmt-rfc-style;
    legacyPackages.${system} = import ./packages { inherit inputs self pkgs; };

    nixosConfigurations = {

      desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        formatter = pkgs.nixfmt-rfc-style;
        legacyPackages = import ./packages { inherit inputs self pkgs; };
        modules = [ ./hosts/desktop ];
        specialArgs = { host="desktop"; inherit self inputs username ; };
      };
      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        formatter = pkgs.nixfmt-rfc-style;
        legacyPackages = import ./packages { inherit inputs self pkgs; };
        modules = [ ./hosts/laptop ];
        specialArgs = { host="laptop"; inherit self inputs username ; };
      };
       vm = nixpkgs.lib.nixosSystem {
        inherit system;
        formatter.${system} = pkgs.nixfmt-rfc-style;
        legacyPackages.${system} = import ./packages { inherit inputs self pkgs; };
        modules = [ ./hosts/vm ];
        specialArgs = { host="vm"; inherit self inputs username ; };
      };
    };
  };
}


### budimanjojo outputs ###
#
#
#   outputs =
#     { flake-parts, ... }@inputs:
#     let
#       # function to make `pkgs` for defined system with my overlays
#       mkPkgsWithSystem =
#         system:
#         import inputs.nixpkgs {
#           inherit system;
#           overlays = builtins.attrValues (import ./overlays { inherit inputs; });
#           config = {
#             allowUnfree = true;
#             allowUnfreePredicate = _: true;
#           };
#         };
#
#       flakeLib = import ./flakeLib.nix { inherit inputs mkPkgsWithSystem; };
#     in
#     inputs.flake-parts.lib.mkFlake { inherit inputs; } {
#       # systems for which you want to build the `perSystem` attributes
#       systems = [ "x86_64-linux" ];
#
#       # everything below `perSystem` will be enumerated and have `${system}`
#       # added in the middle by `flake-parts`
#       perSystem =
#         {
#           system,
#           inputs',
#           self',
#           pkgs,
#           ...
#         }:
#         {
#           # override pkgs used by everything in `perSystem` to have my overlays
#           _module.args.pkgs = mkPkgsWithSystem system;
#           # accessible via `nix fmt` to format code
#           formatter = pkgs.nixfmt-rfc-style;
#           # accessible via `nix build .#<name>`
#           legacyPackages = import ./packages { inherit inputs' self' pkgs; };
#           # accessible via `nix develop`
#           devShells.default = import ./shell.nix { inherit inputs' pkgs; };
#         };
#
#       # all the other flake outputs those don't require `${system}`
#       # string will be here and handled by `flake-parts`
#       flake = {
#         nixosConfigurations = {
#           # this is a NixOS live CD that has SSH enabled and some of my stuffs baked in
#           # build with `nix build .#nixosConfigurations.livecd.config.system.build.isoImage`
#           nixos-livecd = flakeLib.mkSystem {
#             hostname = "nixos-livecd";
#             homeUsers = [ ];
#             baseModules = [ ./system/hosts ];
#           };
#           iT3E-main = flakeLib.mkSystem { hostname = "iT3E-main"; };
#           iT3E-nas = flakeLib.mkSystem {
#             hostname = "iT3E-nas";
#             extraModules = [ inputs.disko.nixosModules.disko ];
#           };
#         };
#
#         homeConfigurations = {
#           "iT3E@it3E-ubuntu" = flakeLib.mkHome { hostname = "iT3E-ubuntu"; };
#         };
#       };
#     };
# }
