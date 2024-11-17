{
  imports = [
    ./plugin-keymaps/telescope-keymap.nix
    ./plugin-keymaps/lsp-keymap.nix
    ./plugin-keymaps/lazygit-keymap.nix
    ./plugin-keymaps/harpoon-keymap.nix
  ];
  config = {
    plugins.which-key = {
      enable = true;
      settings = {
        spec = [
          {
            __unkeyed-1 = "<leader>b";
            group = "buffers";
            desc = "buffers";
          }
          {
            __unkeyed-1 = "<leader>f";
            group = "file/find";
            desc = "file/find";
          }
          {
            __unkeyed-1 = "<leader>h";
            group = "harpoon";
            desc = "harpoon";
          }
          {
            __unkeyed-1 = "<leader>u";
            group = "ui";
            desc = "ui";
          }
          {
            __unkeyed-1 = "<leader>y";
            group = "yank";
            desc = "yank";
          }
          {
            __unkeyed-1 = "<leader>g";
            group = "git";
            desc = "git";
          }
          {
            __unkeyed-1 = "<leader>c";
            group = "code";
            desc = "code";
          }
          {
            __unkeyed-1 = "<leader>e";
            group = "explorer";
            desc = "explorer";
          }
          {
            __unkeyed-1 = "<leader>s";
            group = "search";
            desc = "search";
          }
          {
            __unkeyed-1 = "<leader>x";
            group = "diagnostics";
            desc = "diagnostics";
          }
          {
            __unkeyed-1 = "<leader>w";
            group = "window";
            desc = "window";
          }
          {
            __unkeyed-1 = "<leader>l";
            group = "lsp";
            desc = "lsp";
          }
        ];
        # Using telescope for spelling
        plugins.spelling.enabled = false;
      };
    };

    extraConfigLua = ''
      -- Space is <Leader>
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "
      vim.keymap.set("", "<Space>", "<Nop>", { silent = true })
      -- Debug print
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          print("Leader key is: '" .. vim.inspect(vim.g.mapleader) .. "'")
        end
      })
    '';
    keymaps = [
      # Remove highlighting on <ESC>
      {
        mode = "n";
        key = "<Esc>";
        action = ":nohlsearch<CR>";
        options = {
          desc = "Remove highlighting";
          silent = true;
          noremap = true;
        };
      }
      ## Open new split
      {
        mode = "n";
        key = "<Leader>w-";
        action = ":new<CR>";
        options.desc = "Open new horizontal split";
      }
      {
        mode = "n";
        key = "<Leader>w|";
        action = ":vnew<CR>";
        options.desc = "Open new vertical split";
      }

      ## lspconfig
      {
        mode = "n";
        key = "<Leader>lr";
        action = ":LspRestart<CR>";
        options.desc = "Restart LSP";
      }

      ## FzfLua
      # {
      #   mode = "n";
      #   key = "<Leader>fz";
      #   action = ":FzfLua<CR>";
      # }
      # {
      #   mode = "n";
      #   key = "<Leader>ff";
      #   action = ":FzfLua files<CR>";
      # }
      # {
      #   mode = "n";
      #   key = "<Leader>fg";
      #   action = ":FzfLua live_grep<CR>";
      # }
      # {
      #   mode = "n";
      #   key = "<Leader>fc";
      #   action = ":FzfLua git_commit<CR>";
      # }
      # {
      #   mode = "n";
      #   key = "<Leader>fb";
      #   action = ":FzfLua buffers<CR>";
      # }
      # {
      #   mode = "n";
      #   key = "<Leader>fh";
      #   action = ":FzfLua help_tags<CR>";
      # }
      # {
      #   mode = "n";
      #   key = "<Leader>fk";
      #   action = ":FzfLua keymaps<CR>";
      # }
      # {
      #   mode = "n";
      #   key = "<Leader>fe";
      #   action = ":FzfLua lsp_document_diagnostics<CR>";
      # }
      # {
      #   mode = "n";
      #   key = "<Leader>fr";
      #   action = ":FzfLua lsp_references<CR>";
      # }
      # {
      #   mode = "n";
      #   key = "<Leader>fd";
      #   action = ":FzfLua lsp_typedefs<CR>";
      # }

      ## Trouble
      {
        mode = "n";
        key = "<Leader>xx";
        action = ":TroubleToggle<CR>";
      }
      {
        mode = "n";
        key = "<Leader>xr";
        action = ":TroubleToggle lsp_references<CR>";
      }

      ## oil.nvim
      {
        mode = "n";
        key = "<C-f>";
        action.__raw = "function()
          if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(0), 'filetype') == 'oil' then
            return require('oil').close()
          else
            return require('oil').open_float(require('utils').current_path())
          end
        end";
      }

      ## null-ls
      {
        mode = "n";
        key = "<Leader>pp";
        action.__raw = "function()
          if vim.fn.has('nvim-0.8') == 1 then
            return vim.lsp.buf.format()
          else
            return vim.lsp.buf.formatting()
          end
        end";
        options.desc = "Fix document formatting";
      }
      {
        mode = "v";
        key = "<Leader>pp";
        action.__raw = "function()
          return vim.lsp.buf.range_formatting()
        end";
        options.desc = "Fix document formatting";
      }

      ## FTerm
      {
        mode = [
          "n"
          "t"
        ];
        key = "<C-t>";
        action.__raw = "function()
          return require('FTerm').toggle()
        end";
        options.desc = "Toggle floating terminal";
      }
      {
        mode = "n";
        key = "<Leader>unh";
        action = ":Telescope notify<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Search Notification History";
        };
      }

      # Yanks
      {
        mode = "n";
        key = "<Leader>yp";
        action.__raw = ''
          function()
            local path = vim.fn.expand('%:~:.')
            vim.fn.setreg('+', path)
            require('notify')('Yanked relative path')
          end
        '';
        options = {
          noremap = true;
          silent = true;
          desc = "Relative Path";
        };
      }
      {
        mode = "n";
        key = "<Leader>yf";
        action.__raw = ''
          function()
            local path = vim.fn.expand('%:p')
            vim.fn.setreg('+', path)
            require('notify')('Yanked full path')
          end
        '';
        options = {
          noremap = true;
          silent = true;
          desc = "Full Path";
        };
      }
      {
        mode = "n";
        key = "<Leader>ya";
        action = "<cmd>%y<cr>";
        options = {
          noremap = true;
          silent = true;
          desc = "Buffer Contents";
        };
      }

      # Notif history
      {
        mode = "n";
        key = "<Leader>unh";
        action = ":Telescope notify<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Search Notification History";
        };
      }

      # UI actions
      {
        mode = "n";
        key = "<leader>ud";
        action.__raw = ''
          function()
            vim.b.disable_diagnostics = not vim.b.disable_diagnostics
            if vim.b.disable_diagnostics then
              vim.diagnostic.disable(0)
            else
              vim.diagnostic.enable(0)
            end
            vim.notify(string.format("Buffer Diagnostics %s", vim.b.disable_diagnostics and "disabled" or "enabled"), "info")
          end
        '';
        options = {
          noremap = true;
          silent = true;
          desc = "Buffer Diagnostics toggle";
        };
      }
      {
        mode = "n";
        key = "<leader>uD";
        action.__raw = ''
          function()
            vim.g.disable_diagnostics = not vim.g.disable_diagnostics
            if vim.g.disable_diagnostics then
              vim.diagnostic.disable()
            else
              vim.diagnostic.enable()
            end
            vim.notify(string.format("Global Diagnostics %s", vim.g.disable_diagnostics and "disabled" or "enabled"), "info")
          end
        '';
        options = {
          noremap = true;
          silent = true;
          desc = "Global Diagnostics toggle";
        };
      }
      {
        mode = "n";
        key = "<leader>uf";
        action.__raw = ''
          function()
            vim.cmd('FormatToggle!')
            vim.notify(string.format("Buffer Autoformatting %s", bool2str(not vim.b[0].disable_autoformat), "info"))
          end
        '';
        options = {
          noremap = true;
          silent = true;
          desc = "Buffer Autoformatting toggle";
        };
      }
      {
        mode = "n";
        key = "<leader>uF";
        action.__raw = ''
          function()
            vim.g.disable_autoformat = not vim.g.disable_autoformat
            vim.notify(string.format("Global Autoformatting %s", vim.g.disable_autoformat and "disabled" or "enabled"), "info")
          end
        '';
        options = {
          noremap = true;
          silent = true;
          desc = "Global Autoformatting toggle";
        };
      }
      {
        mode = "n";
        key = "<leader>uS";
        action.__raw = ''
          function()
            if vim.g.spell_enabled then vim.cmd('setlocal nospell') end
            if not vim.g.spell_enabled then vim.cmd('setlocal spell') end
            vim.g.spell_enabled = not vim.g.spell_enabled
            vim.notify(string.format("Spell %s", vim.g.spell_enabled and "enabled" or "disabled"), "info")
          end
        '';
        options = {
          noremap = true;
          silent = true;
          desc = "Spell toggle";
        };
      }
      {
        mode = "n";
        key = "<leader>uw";
        action.__raw = ''
          function()
            vim.wo.wrap = not vim.wo.wrap
            vim.notify(string.format("Wrap %s", vim.wo.wrap and "enabled" or "disabled"), "info")
          end
        '';
        options = {
          noremap = true;
          silent = true;
          desc = "Word Wrap toggle";
        };
      }
      {
        mode = "n";
        key = "<leader>uh";
        action.__raw = ''
          function()
            local curr_foldcolumn = vim.wo.foldcolumn
            if curr_foldcolumn ~= "0" then vim.g.last_active_foldcolumn = curr_foldcolumn end
            vim.wo.foldcolumn = curr_foldcolumn == "0" and (vim.g.last_active_foldcolumn or "1") or "0"
            vim.notify(string.format("Fold Column %s", vim.wo.foldcolumn ~= "0" and "enabled" or "disabled"), "info")
          end
        '';
        options = {
          noremap = true;
          silent = true;
          desc = "Fold Column toggle";
        };
      }
      {
        mode = "n";
        key = "<leader>uc";
        action.__raw = ''
          function()
            vim.g.cmp_enabled = not vim.g.cmp_enabled
            vim.notify(string.format("Completions %s", vim.g.cmp_enabled and "enabled" or "disabled"), "info")
          end
        '';
        options = {
          noremap = true;
          silent = true;
          desc = "Completions toggle";
        };
      }
    ];
  };
}
