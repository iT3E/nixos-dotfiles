{
  config = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGitCurrentFile<CR>";
        options = {
          desc = "LazyGit (current file)";
        };
      }
    ];
  };
}
