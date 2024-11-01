vim.g.firenvim_config = {
  localSettings = {
    [".*"] = {
      cmdline = "neovim",
      content = "text",
      priority = 0,
      selector = "textarea",
      takeover = "never"
    }
  }
}
