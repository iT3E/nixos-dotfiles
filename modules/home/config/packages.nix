{
  inputs,
  pkgs,
  self,
  ...
}:
{
  home.packages = (
    with pkgs;
    [
      ((import ../../../packages { inherit inputs pkgs self; }).neovim)
      (citrix_workspace.overrideAttrs (oldAttrs: {
        buildInputs = oldAttrs.buildInputs ++ [ libogg ];
        runtimeDependencies = oldAttrs.runtimeDependencies ++ [ libogg ];
        autoPatchelfIgnoreMissingDeps = [ "libogg.so.0" ];
      }))
      entr # perform action when file change
      fd # find replacement
      file # Show file information
      fzf # fuzzy finder
      google-chrome
      gifsicle # gif utility
      gimp
      gtrash # rm replacement, put deleted files in system trash
      hexdump
      jdk17 # java
      lazygit
      libreoffice
      nemo-with-extensions # file manager
      nitch # systhem fetch util
      nix-prefetch-github
      prismlauncher # minecraft launcher
      ripgrep # grep replacement
      # tdf                               # cli pdf viewer
      todo # cli todo list
      yazi # terminal file manager
      zenity
      winetricks
      wineWowPackages.wayland

      # C / C++
      gcc
      gnumake

      # Python
      python3

      bleachbit # cache cleaner
      cmatrix
      gparted # partition manager
      ffmpeg
      imv # image viewer
      killall
      libnotify
      man-pages # extra man pages
      mpv # video player
      ncdu # disk space
      openssl
      pamixer # pulseaudio command line mixer
      pavucontrol # pulseaudio volume controle (GUI)
      playerctl # controller for media players
      wl-clipboard # clipboard utils for wayland (wl-copy, wl-paste)
      cliphist # clipboard manager
      poweralertd
      qalculate-gtk # calculator
      unzip
      wget
      xdg-utils
      xxd
      inputs.alejandra.defaultPackage.${system}
    ]
  );
}
