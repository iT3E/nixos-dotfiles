{
  config = {
    keymaps = [
    # {
    #   mode = "n";
    #   key = "<leader>fc";
    #   action.__raw = ''
    #     function()
    #       require("telescope.builtin").find_files {
    #         prompt_title = "Config Files",
    #         cwd = vim.fn.stdpath "config",
    #         follow = true,
    #       }
    #     end
    #   '';
    #   options = {
    #     desc = "Find config files";
    #     silent = true;
    #   };
    # }
    {
      mode = "n";
      key = "<leader>fF";
      action.__raw = ''
        function()
          require("telescope.builtin").find_files({ hidden = true, no_ignore = true})
        end
      '';
      options = {
        desc = "Find all files";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>fT";
      action.__raw = ''
        function()
          require("telescope.builtin").colorscheme({ enable_preview = true })
        end
      '';
      options = {
        desc = "Find theme";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>fW";
      action.__raw = ''
        function()
          require("telescope.builtin").live_grep {
            additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
          }
        end
      '';
      options = {
        desc = "Find words in all files";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>f?";
      action.__raw = ''
        function()
          require("telescope.builtin").live_grep { grep_open_files=true }
        end
      '';
      options = {
        desc = "Find words in all open buffers";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>fe";
      action = "<cmd>Telescope file_browser<CR>";
      options = {
        desc = "File Explorer";
      };
    }
    {
      mode = "n";
      key = "<leader>fO";
      action = "<cmd>Telescope frecency<CR>";
      options = {
        desc = "Find Frequent Files";
      };
    }
    {
      mode = "n";
      key = "<leader>fu";
      action = "<cmd>Telescope undo<CR>";
      options = {
        desc = "List undo history";
      };
    }
    {
      mode = "n";
      key = "<leader>fM";
      action = "<cmd>Telescope manix<CR>";
      options = {
        desc = "Search manix";
      };
    }
    {
      mode = "n";
      key = "<leader>fw";
      action = "<cmd>Telescope live_grep_args<CR>";
      options = {
        desc = "Live grep (args)";
      };
    }
      {
        mode = "n";
        key = "<leader>f'";
        action = ":Telescope marks<CR>";
        options.desc = "View marks";
      }
      {
        mode = "n";
        key = "<leader>f/";
        action = ":Telescope current_buffer_fuzzy_find<CR>";
        options.desc = "Fuzzy find in current buffer";
      }
      {
        mode = "n";
        key = "<leader>f<CR>";
        action = ":Telescope resume<CR>";
        options.desc = "Resume action";
      }
      {
        mode = "n";
        key = "<leader>fa";
        action = ":Telescope autocommands<CR>";
        options.desc = "View autocommands";
      }
      {
        mode = "n";
        key = "<leader>fC";
        action = ":Telescope commands<CR>";
        options.desc = "View commands";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = ":Telescope buffers<CR>";
        options.desc = "View buffers";
      }
      {
        mode = "n";
        key = "<leader>fc";
        action = ":Telescope grep_string<CR>";
        options.desc = "Grep string";
      }
      {
        mode = "n";
        key = "<leader>fd";
        action = ":Telescope diagnostics<CR>";
        options.desc = "View diagnostics";
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = ":Telescope find_files<CR>";
        options.desc = "Find files";
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = ":Telescope help_tags<CR>";
        options.desc = "View help tags";
      }
      {
        mode = "n";
        key = "<leader>fk";
        action = ":Telescope keymaps<CR>";
        options.desc = "View keymaps";
      }
      {
        mode = "n";
        key = "<leader>fm";
        action = ":Telescope man_pages<CR>";
        options.desc = "View man pages";
      }
      {
        mode = "n";
        key = "<leader>fo";
        action = ":Telescope oldfiles<CR>";
        options.desc = "View old files";
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = ":Telescope registers<CR>";
        options.desc = "View registers";
      }
      {
        mode = "n";
        key = "<leader>fs";
        action = ":Telescope lsp_document_symbols<CR>";
        options.desc = "Search symbols";
      }
      {
        mode = "n";
        key = "<leader>fq";
        action = ":Telescope quickfix<CR>";
        options.desc = "Search quickfix";
      }
      {
        mode = "n";
        key = "<leader>fw";
        action = ":Telescope live_grep<CR>";
        options.desc = "Live grep";
      }
      {
        mode = "n";
        key = "<leader>gB";
        action = ":Telescope git_branches<CR>";
        options.desc = "View git branches";
      }
      {
        mode = "n";
        key = "<leader>gC";
        action = ":Telescope git_commits<CR>";
        options.desc = "View git commits";
      }
      {
        mode = "n";
        key = "<leader>gs";
        action = ":Telescope git_status<CR>";
        options.desc = "View git status";
      }
      {
        mode = "n";
        key = "<leader>gS";
        action = ":Telescope git_stash<CR>";
        options.desc = "View git stashes";
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
    ];
  };
}
