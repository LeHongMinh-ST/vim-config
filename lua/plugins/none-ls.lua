return {
  "nvimtools/none-ls.nvim",
  optional = true,
  opts = function(_, opts)
    local nls = require("null-ls")
    opts.sources = opts.sources
      or {
        nls.builtins.diagnostics.phpcs.with({
          extra_args = { "--ignore=CommentingRules" },
        }),
      }
    table.insert(opts.sources, nls.builtins.formatting.prettier)
  end,
}
