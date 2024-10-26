{
  config = {
    ## Highlght on yank
    autoGroups = {
      yankhighlight.clear = true;
    };

    autoCmd = [
      {
        event = [ "TextYankPost" ];
        pattern = [ "*" ];
        group = "yankhighlight";
        callback = {
          __raw = "function()
            vim.highlight.on_yank()
          end";
        };
      }
    ];

    opts = {
      background = "dark";
      termguicolors = true;
      signcolumn = "yes";
      cursorcolumn = true;
    };

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavor = "mocha";
        integrations = {
          fzf = true;
          indent_blankline = {
            enabled = true;
            scope_color = "mauve";
            colored_indent_levels = true;
          };
          nvim_surround = true;
          lsp_trouble = true;
          aerial = true;
          cmp = true;
          dap = {
            enabled = true;
            enable_ui = true;
          };
          dap_ui = true;
          diffview = true;
          fidget = true;
          gitsigns = true;
          harpoon = true;
          headlines = true;
          hop = true;
          leap = true;
          markdown = true;
          mason = true;
          mini.enabled = true;

          native_lsp = {
            enabled = true;
            virtual_text = {
              errors = [ "italic" ];
              hints = [ "italic" ];
              warnings = [ "italic" ];
              information = [ "italic" ];
            };
            underlines = {
              errors = [ "underline" ];
              hints = [ "underline" ];
              warnings = [ "underline" ];
              information = [ "underline" ];
            };
            inlay_hints = {
              background = true;
            };
          };
          navic = {
            enabled = true;
          };
          neogit = true;
          neotree = false;
          neotest = true;
          noice = true;
          notify = true;
          overseer = true;
          rainbow_delimiters = true;
          sandwich = true;
          semantic_tokens = true;
          symbols_outline = true;
          telescope = {
            enabled = true;
            style = "nvchad";
          };
          treesitter = true;
          ufo = true;
          which_key = true;
        };
      };
    };
  };
}
