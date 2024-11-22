{
  config = {
    keymaps = [
      {
        mode = "n";
        key = "<Leader>w-";
        action = ":new<CR>";
        options.desc = "Open new horizontal split";
      }
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
