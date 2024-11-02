{
  inputs,
  username,
  host,
  self,
  ...
}:
{
  imports = [ (import ./default.nix) ] ++ [ (import ./config/nvidia.nix) ];
  # ++ [(import ./rider.nix)]                     # C# JetBrain editor
  # ++ [(import ./steam.nix)]
  # ++ [(import ./unity.nix)];
}
