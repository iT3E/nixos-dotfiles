{ username, config, ... }:
{
  sops = {
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";

    defaultSopsFile = ../../../secrets.yaml;
    defaultSymlinkPath = "/run/user/1000/secrets";
    defaultSecretsMountPoint = "/run/user/1000/secrets.d";

    secrets = {
      openai_api_key = {
        # sopsFile = ./secrets.yml.enc; # optionally define per-secret files
        path = "${config.sops.defaultSymlinkPath}/openai_api_key";
      };
      git_work_username = {
        # sopsFile = ./secrets.yml.enc; # optionally define per-secret files
        path = "${config.sops.defaultSymlinkPath}/git_work_username";
      };
      git_work_email = {
        # sopsFile = ./secrets.yml.enc; # optionally define per-secret files
        path = "${config.sops.defaultSymlinkPath}/git_work_email";
      };
    };
  };
}
