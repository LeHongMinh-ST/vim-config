return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters_by_ft = {
      php = { "phpcs" },
    },
    linters = {
      phpcs = {
        args = { "--ignore=CommentingRules" },
        stdin = false,
        stream = "stdout",
        parser = require("lint.parser").from_errorformat("%E%f:%l:%c: %m"),
      },
    },
    hooks = {
      ["lint-done"] = function(result)
        -- Tắt thông báo từ phpcs bằng cách không hiển thị thông báo
        if result and result.linter == "phpcs" then
          vim.notify = function() end
        end
      end,
    },
  },
}
