return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters_by_ft = {
      php = { "phpcs" },
    },
    linters = {
      phpcs = {
        cmd = "phpcs",
        args = { "--ignore=CommentingRules" },
        stdin = false,
      },
    },
  },
}
