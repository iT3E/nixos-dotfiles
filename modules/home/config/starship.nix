{ lib, inputs, ... }: 
let
  # Add this debug line
  starshipPath = builtins.trace "Starship path: ${inputs.catppuccin-starship}" inputs.catppuccin-starship;
in
{
  programs.starship = {
    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;

    settings = {
      # right_format = "$cmd_duration";
      
      directory = {
        format = "[ ](bold #89b4fa)[ $path ]($style)";
        style = "bold #b4befe";
      };

      character = {
        success_symbol = "[ ](bold #89b4fa)[ ➜](bold green)";
        error_symbol = "[ ](bold #89b4fa)[ ➜](bold red)";
      };

      cmd_duration = {
        format = "[󰔛 $duration]($style)";
        disabled = false;
        style = "bg:none fg:#f9e2af";
        show_notifications = false;
        min_time_to_notify = 60000;
      };        

      palette = "catppuccin_mocha";
    } // (builtins.fromTOML (builtins.readFile "${starshipPath}/themes/mocha.toml"));
  };
}
