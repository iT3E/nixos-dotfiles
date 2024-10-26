{
  config = {
    keymaps = {
      "<leader>f'" = {
        action = "marks";
        options.desc = "View marks";
      };
      "<leader>f/" = {
        action = "current_buffer_fuzzy_find";
        options.desc = "Fuzzy find in current buffer";
      };
      "<leader>f<CR>" = {
        action = "resume";
        options.desc = "Resume action";
      };
      "<leader>fa" = {
        action = "autocommands";
        options.desc = "View autocommands";
      };
      "<leader>fC" = {
        action = "commands";
        options.desc = "View commands";
      };
      "<leader>fb" = {
        action = "buffers";
        options.desc = "View buffers";
      };
      "<leader>fc" = {
        action = "grep_string";
        options.desc = "Grep string";
      };
      "<leader>fd" = {
        action = "diagnostics";
        options.desc = "View diagnostics";
      };
      "<leader>ff" = {
        action = "find_files";
        options.desc = "Find files";
      };
      "<leader>fh" = {
        action = "help_tags";
        options.desc = "View help tags";
      };
      "<leader>fk" = {
        action = "keymaps";
        options.desc = "View keymaps";
      };
      "<leader>fm" = {
        action = "man_pages";
        options.desc = "View man pages";
      };
      "<leader>fo" = {
        action = "oldfiles";
        options.desc = "View old files";
      };
      "<leader>fr" = {
        action = "registers";
        options.desc = "View registers";
      };
      "<leader>fs" = {
        action = "lsp_document_symbols";
        options.desc = "Search symbols";
      };
      "<leader>fq" = {
        action = "quickfix";
        options.desc = "Search quickfix";
      };
      "<leader>fw" = {
        action = "live_grep";
        options.desc = "Live grep";
      };
      # "<leader>gC" = {
      #   action = "git_bcommits";
      #   options.desc = "View git bcommits";
      # };
      "<leader>gB" = {
        action = "git_branches";
        options.desc = "View git branches";
      };
      "<leader>gC" = {
        action = "git_commits";
        options.desc = "View git commits";
      };
      "<leader>gs" = {
        action = "git_status";
        options.desc = "View git status";
      };
      "<leader>gS" = {
        action = "git_stash";
        options.desc = "View git stashes";
      };
    };
  };
}
