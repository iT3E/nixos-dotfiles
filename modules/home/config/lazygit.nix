{
  programs.lazygit = {
    enable = true;

    settings = {
      gui = {
        authorColors = {
          "user.fullName" = "#c6a0f6";
          "dependabot[bot]" = "#eed49f";
        };
        branchColors = {
          main = "#ed8796";
          master = "#ed8796";
          dev = "#8bd5ca";
        };
      };
      git = {
        overrideGpg = true;
      };
    };
  };

  home.shellAliases = {
    lg = "lazygit";
  };
}
