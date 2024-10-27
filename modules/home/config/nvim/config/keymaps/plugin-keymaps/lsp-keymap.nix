{
  config = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>l[";
        action = "goto_prev";
        options = {
          desc = "Prev";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>l]";
        action = "goto_next";
        options = {
          desc = "Next";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>lH";
        action = "open_float";
        options = {
          desc = "Diagnostic Hover";
          silent = true;
        };
      }
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
      {
        mode = "n";
        key = "<leader>lp";
        action.__raw = "peek_definition";
        options = {
          desc = "Preview definition";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>lP";
        action.__raw = "peek_type_definition";
        options = {
          desc = "Preview type definition";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>la";
        action = "code_action";
        options = {
          desc = "Code Action";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ld";
        action = "definition";
        options = {
          desc = "Definition";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>lD";
        action = "references";
        options = {
          desc = "References";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>lf";
        action = "format";
        options = {
          desc = "Format";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>lh";
        action = "hover";
        options = {
          desc = "Lsp Hover";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>li";
        action = "implementation";
        options = {
          desc = "Implementation";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>lr";
        action = "rename";
        options = {
          desc = "Rename";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>lt";
        action = "type_definition";
        options = {
          desc = "Type Definition";
          silent = true;
        };
      }
    ];

    which-key.settings.spec = [
      {
        __unkeyed = "<leader>l";
        group = "LSP";
        icon = " ";
      }
      {
        __unkeyed = "<leader>la";
        desc = "Code Action";
      }
      {
        __unkeyed = "<leader>ld";
        desc = "Definition";
      }
      {
        __unkeyed = "<leader>lD";
        desc = "References";
      }
      {
        __unkeyed = "<leader>lf";
        desc = "Format";
      }
      {
        __unkeyed = "<leader>l[";
        desc = "Prev";
      }
      {
        __unkeyed = "<leader>l]";
        desc = "Next";
      }
      {
        __unkeyed = "<leader>lt";
        desc = "Type Definition";
      }
      {
        __unkeyed = "<leader>li";
        desc = "Implementation";
      }
      {
        __unkeyed = "<leader>lh";
        desc = "Lsp Hover";
      }
      {
        __unkeyed = "<leader>lH";
        desc = "Diagnostic Hover";
      }
      {
        __unkeyed = "<leader>lr";
        desc = "Rename";
      }
    ];
  };
}
