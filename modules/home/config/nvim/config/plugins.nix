{ config, pkgs, ... }:
let
  vimPlugins = pkgs.vimPlugins // config.nvim-plugins;
in
{
  ## I prefer writing plugin configs using lua because
  ## a) not everything can be configured with the provided nixvim modules
  ## b) I don't want to wait for upstream to merge my PR which takes forever
  ## c) LSP and syntax highlighting will work without any effort

  ## But, to configure LSP, it's easier to make use of nixvim provided module so I use that
  # imports = [ ./lsp.nix ];
  config = {
    ## load the lua snippets from nix store
    # extraConfigLua = "require('luasnip.loaders.from_lua').lazy_load({paths = '${./snippets}'})";
    extraFiles = {
      "lua/plugin-configs/_alpha.lua".text = builtins.readFile ./lua/plugin-configs/_alpha.lua;
      "lua/plugin-configs/_autopairs.lua".text = builtins.readFile ./lua/plugin-configs/_autopairs.lua;
      "lua/plugin-configs/_firenvim.lua".text = builtins.readFile ./lua/plugin-configs/_firenvim.lua;
      "lua/plugin-configs/_fzf-lua.lua".text = builtins.readFile ./lua/plugin-configs/_fzf-lua.lua;
      "lua/plugin-configs/_gitsigns.lua".text = builtins.readFile ./lua/plugin-configs/_gitsigns.lua;
      "lua/plugin-configs/_harpoon.lua".text = builtins.readFile ./lua/plugin-configs/_harpoon.lua;
      "lua/plugin-configs/_lualine.lua".text = builtins.readFile ./lua/plugin-configs/_lualine.lua;
      "lua/plugin-configs/_noice.lua".text = builtins.readFile ./lua/plugin-configs/_noice.lua;
      "lua/plugin-configs/_nvim-cmp.lua".text = builtins.readFile ./lua/plugin-configs/_nvim-cmp.lua;
      "lua/plugin-configs/_nvim-web-devicons.lua".text = builtins.readFile ./lua/plugin-configs/_nvim-web-devicons.lua;
      "lua/plugin-configs/_oil.lua".text = builtins.readFile ./lua/plugin-configs/_oil.lua;
      "lua/plugin-configs/_sad-nvim.lua".text = builtins.readFile ./lua/plugin-configs/_sad-nvim.lua;
      "lua/plugin-configs/_telescope.lua".text = builtins.readFile ./lua/plugin-configs/_telescope.lua;
      "lua/plugin-configs/_treesitter.lua".text = builtins.readFile ./lua/plugin-configs/_treesitter.lua;
      "lua/plugin-configs/_indent-blankline.lua".text = builtins.readFile ./lua/plugin-configs/_indent-blankline.lua;
      "lua/plugin-configs/_yanky.lua".text = builtins.readFile ./lua/plugin-configs/_yanky.lua;

      "queries/nix/injections.scm".text = ''
        ;; extends

        (binding
          attrpath: (attrpath (identifier) @_path)
          expression: [
            (string_expression (string_fragment) @lua)
            (indented_string_expression (string_fragment) @lua)
          ]
          (#match? @_path "^extraConfigLua(Pre|Post)?$"))

        (binding
          attrpath: (attrpath (identifier) @_path)
          expression: [
            (string_expression (string_fragment) @vim)
            (indented_string_expression (string_fragment) @vim)
          ]
          (#match? @_path "^extraConfigVim(Pre|Post)?$"))
      '';
    };

    ## dependencies needed for plugins
    extraPackages = with pkgs; [
      fd
      fzf
      ripgrep
      git
      gzip
      sad
      shellcheck
    ];

    extraPlugins = with vimPlugins; [
      {
        plugin = alpha-nvim;
        config = "lua require('plugin-configs._alpha')";
      }
      # Syntax highlighting
      ansible-vim
      {
        plugin = nvim-colorizer-lua;
        config = "lua require('colorizer').setup()";
      }
      {
        plugin = nvim-treesitter.withAllGrammars;
        config = "lua require('plugin-configs._treesitter')";
      }
      chezmoi-vim
      # Appearance
      dressing-nvim
      guihua-lua
      {
        plugin = nvim-web-devicons;
        config = "lua require('plugin-configs._nvim-web-devicons')";
      }
      {
        plugin = lualine-nvim;
        config = "lua require('plugin-configs._lualine')";
      }
      {
        plugin = indent-blankline-nvim;
        config = "lua require('plugin-configs._indent-blankline')";
      }
      # Autocompletion
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-spell
      cmp_luasnip
      lspkind-nvim
      luasnip
      friendly-snippets
      k8s-snippets
      {
        plugin = nvim-cmp;
        config = "lua require('plugin-configs._nvim-cmp')";
      }
      {
        plugin = nvim-ts-autotag;
        config = "lua require('nvim-ts-autotag').setup()";
      }
      # Fuzzy finder
      {
        plugin = fzf-lua;
        config = "lua require('plugin-configs._fzf-lua')";
      }
      {
        plugin = sad-nvim;
        config = "lua require('plugin-configs._sad-nvim')";
      }
      # System utility
      FTerm-nvim
      {
        plugin = oil-nvim;
        config = "lua require('plugin-configs._oil')";
      }
      {
        plugin = gitsigns-nvim;
        config = "lua require('plugin-configs._gitsigns')";
      }
      # Editing support
      {
        plugin = comment-nvim;
        config = "lua require('Comment').setup()";
      }
      {
        plugin = nvim-autopairs;
        config = "lua require('plugin-configs._autopairs')";
      }
      {
        plugin = nvim-surround;
        config = "lua require('nvim-surround').setup()";
      }
      {
        plugin = trim-nvim;
        config = "lua require('trim').setup()";
      }
      b64-nvim
      # Other
      {
        plugin = firenvim;
        config = "lua require('plugin-configs._firenvim')";
      }
      conform-nvim
      lazygit-nvim
      presence-nvim
      bufferline-nvim
      vim-tmux-navigator
      plenary-nvim
      telescope-fzf-native-nvim
      # harpoon
      # harpoon2
      # {
      #   plugin = harpoon2;
      #   config = "lua require('plugin-configs._harpoon')";
      # }
      {
        plugin = noice-nvim;
        config = "lua require('plugin-configs._noice')";
      }
      {
        plugin = yanky-nvim;
        config = "lua require('plugin-configs._yanky')";
      }
      {
        plugin = telescope-nvim;
        config = "lua require('plugin-configs._telescope')";
      }
    ];
  };
}
