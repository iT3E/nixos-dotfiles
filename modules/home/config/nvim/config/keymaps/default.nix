{ config, pkgs, lib, ... }:
{
  imports = [
    ./plugin-keymaps/telescope-keymap.nix
  ];
  config = {
    plugins.which-key = {
        enable = true;
        settings = {
          spec = [
            {
              __unkeyed-1 = "<leader>w";
              proxy = "<C-w>";
              group = "windows";
            }
            {
              __unkeyed-1 = "<c-w>c";
              desc = "Close current window";
            }
            {
              __unkeyed-1 = "<c-w>H";
              desc = "Move current window to the far left";
            }
            {
              __unkeyed-1 = "<c-w>J";
              desc = "Move current window to the very bottom";
            }
            {
              __unkeyed-1 = "<c-w>K";
              desc = "Move current window to the very top";
            }
            {
              __unkeyed-1 = "<c-w>L";
              desc = "Move current window to the far right";
            }

            {
              __unkeyed-1 = "<leader>b";
              group = "buffers";
              desc = "buffers";
            }

            {
              __unkeyed-1 = "<leader>r";
              group = "refactoring";
            }

            {
              __unkeyed-1 = "<leader>f";
              group = "files";
            }
            {
              __unkeyed-1 = "<leader>u";
              group = "utils";  
              desc = "utils";
            }
            {
              __unkeyed-1 = "<leader>y";
              group = "yank";  
              desc = "yank";
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
      ## Open new split
      {
        mode = "n";
        key = "<Leader>s";
        action = ":new<CR>";
        options.desc = "Open new horizontal split";
      }
      {
        mode = "n";
        key = "<Leader>v"; action = ":vnew<CR>";
        options.desc = "Open new vertical split";
      }

      ## Tab navigation
      {
        mode = "n";
        key = "<Leader>tn";
        action = ":tabnew<CR>";
        options.desc = "Create new tab";
      }
      {
        mode = "n";
        key = "<Leader>tq";
        action = ":tabclose<CR>";
        options.desc = "Close current tab";
      }
      {
        mode = "n";
        key = "<Leader>th";
        action = ":tabprev<CR>";
        options.desc = "Go to the previous tab";
      }
      {
        mode = "n";
        key = "<Leader>tl";
        action = ":tabnext<CR>";
        options.desc = "Go to the next tab";
      }
      {
        mode = "n";
        key = "<Leader>te";
        action = ":tabedit <C-r>=expand('%:p:h')<CR>/";
        options.desc = "Open new tab with current buffer's path";
      }

      ## Indent or de-indent
      {
        mode = "n";
        key = "<Tab>";
        action.__raw = "function() return require('utils').always_working_indent_line() end";
        options.desc = "Add indentation";
      }
      {
        mode = "n";
        key = "<S-Tab>";
        action = "<<";
        options.desc = "De-indentation";
      }
      {
        mode = "v";
        key = "<Tab>";
        action = ">gv";
        options.desc = "Add indentation";
      }
      {
        mode = "v";
        key = "<S-Tab>";
        action = "<gv";
        options.desc = "De-indentation";
      }

      ## lspconfig
      {
        mode = "n";
        key = "<Leader>lr";
        action = ":LspRestart<CR>";
        options.desc = "Restart LSP";
      }

      ## FzfLua
      {
        mode = "n";
        key = "<Leader>fz";
        action = ":FzfLua<CR>";
      }
      {
        mode = "n";
        key = "<Leader>ff";
        action = ":FzfLua files<CR>";
      }
      {
        mode = "n";
        key = "<Leader>fg";
        action = ":FzfLua live_grep<CR>";
      }
      {
        mode = "n";
        key = "<Leader>fc";
        action = ":FzfLua git_commit<CR>";
      }
      {
        mode = "n";
        key = "<Leader>fb";
        action = ":FzfLua buffers<CR>";
      }
      {
        mode = "n";
        key = "<Leader>fh";
        action = ":FzfLua help_tags<CR>";
      }
      {
        mode = "n";
        key = "<Leader>fk";
        action = ":FzfLua keymaps<CR>";
      }
      {
        mode = "n";
        key = "<Leader>fe";
        action = ":FzfLua lsp_document_diagnostics<CR>";
      }
      {
        mode = "n";
        key = "<Leader>fr";
        action = ":FzfLua lsp_references<CR>";
      }
      {
        mode = "n";
        key = "<Leader>fd";
        action = ":FzfLua lsp_typedefs<CR>";
      }

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

      ## b64.nvim
      {
        mode = "v";
        key = "<Leader>be";
        action = ":<C-u>lua require('b64').encode()<CR>";
        options.desc = "Encode text with base64";
      }
      {
        mode = "v";
        key = "<Leader>bd";
        action = ":<C-u>lua require('b64').decode()<CR>";
        options.desc = "Decode base64 encoded text";
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
    ];
  };
}
