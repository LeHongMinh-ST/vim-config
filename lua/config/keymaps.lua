-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymaps = vim.keymap
local otps = { noremap = true, silent = true }

-- Increment/decrement
keymaps.set("n", "+", "<C-a>")
keymaps.set("n", "-", "<C-x>")

-- Delete a word
keymaps.set("n", "dw", "vb_d")

-- SelectAll
keymaps.set("n", "<C-a>", "gg<S-v>G")

-- JumpList
keymaps.set("n", "<C-m>", "<C-i>", otps)

-- -- New tab
-- keymaps.set("n", "te", ":tabedit", otps)
-- keymaps.set("n", "<tab>", ":tabnext<Return>", otps)
-- keymaps.set("n", "<s-tab>", ":tabprev<Return>", otps)
--
-- Split window
keymaps.set("n", "ss", ":split<Return>", otps)
keymaps.set("n", "sv", ":vsplit<Return>", otps)

-- Move window
keymaps.set("n", "sh", "<C-w>h")
keymaps.set("n", "sk", "<C-w>k")
keymaps.set("n", "sj", "<C-w>j")
keymaps.set("n", "sl", "<C-w>l")

-- Resiz window
keymaps.set("n", "<C-w><left>", "<C-w><")
keymaps.set("n", "<C-w><right>", "<C-w>>")
keymaps.set("n", "<C-w><up>", "<C-w>+")
keymaps.set("n", "<C-w><down>", "<C-w>-")

-- Diagnostics
keymaps.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end)

-- vim.keymap.set("n", "<leader>rn", function()
--   return ":IncRename " .. vim.fn.expand("<cword>")
-- end, { expr = true })

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
-- function IPhpInsertUse()
--   vim.api.nvim_feedkeys("a", "n", true)
--   vim.api.nvim_command("call PhpInsertUse()")
-- end
-- all vim helper functions here

vim.keymap.set("n", "<leader>ce", function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
  if #diagnostics > 0 then
    local message = diagnostics[1].message
    vim.fn.setreg("+", message)
    print("Copied diagnostic: " .. message)
  else
    print("No diagnostic at cursor")
  end
end, { noremap = true, silent = true })

-- go to errors in a file :/
vim.keymap.set("n", "<leader>ne", vim.diagnostic.goto_next) -- next err
vim.keymap.set("n", "<leader>pe", vim.diagnostic.goto_prev) -- previous err
