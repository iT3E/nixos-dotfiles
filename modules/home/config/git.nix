{ pkgs, config, ... }:
{
  programs.git = {
    enable = true;

    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "store";
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";

      # Personal account - default
      url."git@github.com:".insteadOf = "https://github.com/";

      # Work account configuration
      "url \"git@github.com-work:\"".insteadOf = "https://github.com-work/";

      # Conditional includes based on repository path
      "includeIf \"gitdir:/home/it/git-work/\"" = {
        path = "/home/it/.config/git/work.gitconfig";
      };

      # Add personal includeIf
      "includeIf \"gitdir:/home/it/git-personal/\"" = {
        path = "/home/it/.config/git/personal.gitconfig";
      };
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

  home.activation = {
    generateWorkGitConfig = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      cat > ~/.config/git/work.gitconfig << EOF
      [user]
        name = $(cat ${config.sops.secrets.git_work_username.path})
        email = $(cat ${config.sops.secrets.git_work_email.path})
      EOF
    '';

    generatePersonalGitConfig = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      cat > ~/.config/git/personal.gitconfig << EOF
      [user]
        name = iT3E
        email = 26583558+iT3E@users.noreply.github.com
      EOF
    '';
  };

  # SSH config to handle multiple GitHub accounts
  home.file.".ssh/config".text = ''
    # Personal GitHub account
    Host github.com
      HostName github.com
      User git
      IdentityFile ~/.ssh/id_ed25519_pers

    # Work GitHub account
    Host github.com-work
      HostName github.com
      User git
      IdentityFile ~/.ssh/id_ed25519_work
  '';

  home.packages = [ pkgs.gh ]; # pkgs.git-lfs ];
}
