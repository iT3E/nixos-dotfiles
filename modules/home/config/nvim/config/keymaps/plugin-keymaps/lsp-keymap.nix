{
  config = {
    keymaps = [
      {
        mode = "v";
        key = "<leader>lf";
        action.__raw = ''
          function()
            vim.lsp.buf.format({
              async = true,
              range = {
                ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
                ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
              }
            })
          end
        '';
        options = {
          desc = "Format selection";
          silent = true;
        };
      }
    ];
  };
}
