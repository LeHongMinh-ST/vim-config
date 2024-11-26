return {

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    opts = {},
  },
  -- Dashboard plugin
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
          ██╗     ███████╗    ██╗  ██╗ ██████╗ ███╗   ██╗ ██████╗     ███╗   ███╗██╗███╗   ██╗██╗  ██╗
          ██║     ██╔════╝    ██║  ██║██╔═══██╗████╗  ██║██╔════╝     ████╗ ████║██║████╗  ██║██║  ██║
          ██║     █████╗      ███████║██║   ██║██╔██╗ ██║██║  ███╗    ██╔████╔██║██║██╔██╗ ██║███████║
          ██║     ██╔══╝      ██╔══██║██║   ██║██║╚██╗██║██║   ██║    ██║╚██╔╝██║██║██║╚██╗██║██╔══██║
          ███████╗███████╗    ██║  ██║╚██████╔╝██║ ╚████║╚██████╔╝    ██║ ╚═╝ ██║██║██║ ╚████║██║  ██║
          ╚══════╝╚══════╝    ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝     ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      -- Đảm bảo `opts.config` tồn tại trước khi sử dụng
      opts = opts or {}

      opts.config = opts.config or {}
      opts.config.header = vim.split(logo, "\n")

      -- Trả về cấu hình đã sửa đổi
      return opts
    end,
  },
}
