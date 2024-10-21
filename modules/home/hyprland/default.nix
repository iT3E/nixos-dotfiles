{ inputs, ... }: 
{
  imports = [ (import ./config/hyprland.nix) ]
    ++ [ (import ./config/config.nix) ]
    ++ [ (import ./config/hyprlock.nix) ]
    ++ [ (import ./config/variables.nix) ]
    ++ [ inputs.hyprland.homeManagerModules.default ];
}
