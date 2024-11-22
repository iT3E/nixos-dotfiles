{ config, lib, ... }:
{
  plugins = {
    harpoon = {
      enable = true;

      keymapsSilent = true;

      keymaps = {
        addFile = "<leader>ha";
        toggleQuickMenu = "<leader>hm";
        navFile = {
          "1" = "<c-h><c-h>";
          "2" = "<c-h><c-j>";
          "3" = "<c-h><c-k>";
          "4" = "<c-h><c-l>";
        };
      };
    };

    which-key.settings.spec = [
      {
        __unkeyed = "<leader>h";
        group = "Harpoon";
        icon = "󱡀 ";
      }
      {
        __unkeyed = "<leader>ha";
        desc = "Add";
      }
      {
        __unkeyed = "<leader>hm";
        desc = "QuickMenu";
      }
      {
        __unkeyed = "<c-h><c-h>";
        desc = "1";
      }
      {
        __unkeyed = "<c-h><c-j>";
        desc = "2";
      }
      {
        __unkeyed = "<c-h><c-k>";
        desc = "3";
      }
      {
        __unkeyed = "<c-h><c-l>";
        desc = "4";
      }
    ];
  };
}
