-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- When running remotely over SSH, use OSC 52 to access the local clipboard.
-- Locally, nvim's built-in pbcopy/pbpaste support is used instead.
if vim.env.SSH_TTY or vim.env.SSH_CLIENT then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end
