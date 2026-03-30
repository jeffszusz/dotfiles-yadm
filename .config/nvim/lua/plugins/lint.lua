return {
  "mfussenegger/nvim-lint",
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        prepend_args = { "--config", vim.fn.expand("~/.markdownlint-cli2.yaml") },
      },
    },
  },
}
