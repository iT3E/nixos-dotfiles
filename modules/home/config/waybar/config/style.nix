{ lib, host, ... }:
let
  custom = {
    font = "JetBrainsMono Nerd Font";
    font_size = if host == "desktop" then "18px" else "12px";
    font_weight = "bold";
    text_color = "#cdd6f4";
    secondary_accent = "89b4fa";
    tertiary_accent = "f5f5f5";
    background = "11111B";
    opacity = "0.98";
    workspaces_font_size = if host == "desktop" then "27px" else "18px";
    workspaces_button_padding_left = if host == "desktop" then "12px" else "6px";
    workspaces_button_padding_right = if host == "desktop" then "12px" else "6px";
    custom_launcher_font_size = if host == "desktop" then "30px" else "20px";
    custom_launcher_padding_left = if host == "desktop" then "20px" else "10px";
    custom_launcher_padding_right = if host == "desktop" then "25px" else "15px";
  };
in
{
  programs.waybar.style = ''

    * {
        border: none;
        border-radius: 0px;
        padding: 0;
        margin: 0;
        min-height: 0px;
        font-family: ${custom.font};
        font-weight: ${custom.font_weight};
        opacity: ${custom.opacity};
    }

    window#waybar {
        background: none;
    }

    #workspaces {
        font-size: ${custom.workspaces_font_size};
        padding-left: 15px;

    }
    #workspaces button {
        color: ${custom.text_color};
        padding-left:  ${custom.workspaces_button_padding_left};
        padding-right:  ${custom.workspaces_button_padding_right};
    }
    #workspaces button.empty {
        color: #6c7086;
    }
    #workspaces button.active {
        color: #b4befe;
    }

    #tray, #pulseaudio,  #cpu, #memory, #clock, #battery, #custom-notification {
        font-size: ${custom.font_size};
        color: ${custom.text_color};
    }

    #cpu {
        padding-left: 15px;
        padding-right: 9px;
        margin-left: 7px;
    }
    #memory {
        padding-left: 9px;
        padding-right: 9px;
    }
    #pulseaudio {
        padding-left: 15px;
        padding-right: 9px;
        margin-left: 7px;
    }
    #battery {
        padding-left: 9px;
        padding-right: 9px;
    }
    custom-notification {
        padding-left: 20px;
        padding-right: 20px;
    }

    #clock {
        padding-left: 9px;
        padding-right: 15px;
    }

    #custom-launcher {
        font-size: ${custom.custom_launcher_font_size};
        color: #b4befe;
        font-weight: ${custom.font_weight};
        padding-left: ${custom.custom_launcher_padding_left};
        padding-right: ${custom.custom_launcher_padding_right};
    }
  '';
}
