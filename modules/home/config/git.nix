{ pkgs, ... }: 
{
  programs.git = {
    enable = true;
    
    userName = "iT3E";
    userEmail = "26583558+iT3E@users.noreply.github.com";
    
    extraConfig = { 
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };

  # home.packages = [ pkgs.gh pkgs.git-lfs ];
}
