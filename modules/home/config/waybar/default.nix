{ ... }: 
{
  imports =  [ (import ./config/waybar.nix)   ]
          ++ [ (import ./config/settings.nix) ]
          ++ [ (import ./config/style.nix)    ];
}
