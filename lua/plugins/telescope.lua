local actions = require("telescope.actions")
local entry_display = require("telescope.pickers.entry_display")

local grep_picker = {
  preview = true,
  only_sort_text = true, -- don't include the filename in the search results
}

return {
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.4",
    -- dependencies = "nvim-lua/plenary.nvim",
    lazy = true,
    opts = {
      -- theme = "vscode", -- custom field
      defaults = {
        wrap_results = true,
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.5 },
          vertical = { mirror = false },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 100,
        },
        mappings = {
          i = {
            ["<Tab>"] = actions.move_selection_next,
            ["<S-Tab>"] = actions.move_selection_previous,
          },
          n = {
            ["<Tab>"] = actions.move_selection_next,
            ["<S-Tab>"] = actions.move_selection_previous,
          },
        },
        file_ignore_patterns = {
          "node_modules/",
          ".git/",
          -- rust
          "**/debug/",
          "target/release/",
          -- yarn
          ".yarn/*",
        },
      },
      pickers = {
        find_files = {
          no_ignore = false,
          hidden = true,
        },
        oldfiles = {
          cwd_only = true,
        },
        live_grep = grep_picker,
        grep_string = grep_picker,
        buffers = {
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer,
            },
          },
        },
        commands = {
          entry_maker = function(entry)
            local displayer = entry_display.create({
              separator = " ",
              items = {
                { remaining = true },
                { remaining = true },
              },
            })

            ---@diagnostic disable-next-line: unused-local
            local function make_display(_entry)
              return displayer({ entry.name, { entry.definition:gsub("\n", " "), "Comment" } })
            end

            return {
              value = entry,
              ordinal = entry.name,
              display = make_display,
            }
          end,
        },
      },
    },
    config = function(_, opts)
      -- vscode like find files
      if opts.theme == "vscode" then
        local theme = require("telescope.themes")["get_dropdown"]
        if theme then
          opts.defaults = theme(opts.defaults)
        end
        opts.defaults.preview = false
      end

      if vim.fn.executable("rg") then
        -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/init.lua#LL87C36-L87C36
        opts.defaults.vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob=!.git/",
        }
      end

      require("telescope").setup(opts)
    end,
    -- dependencies = {
    --   {
    --     "nvim-telescope/telescope-fzf-native.nvim",
    --     enabled = vim.fn.executable("fzf"),
    --     build = "make",
    --     config = function()
    --       require("telescope").load_extension("fzf")
    --     end,
    --   },
    -- },

    lsp_handlers = {
      definition = require("telescope.builtin").lsp_definitions,
    },
  },
}
