{ pkgs, ... }:
{
  programs.git = {
    enable = true;

    userName = "iT3E";
    userEmail = "26583558+iT3E@users.noreply.github.com";

    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "store";
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
    };

    delta = {
      enable = true;
      options = {
        line-numbers = true;
        side-by-side = true;
        diff-so-fancy = true;
        navigate = true;
      };
    };
  };
  home.packages = [ pkgs.gh ]; # pkgs.git-lfs ];
  #test
}
