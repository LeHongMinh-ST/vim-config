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
--
-- vim.api.nvim_exec(
--   [[
--     autocmd FileType php inoremap <Leader>\  <Esc>:lua IPhpInsertUse()<CR>
--     autocmd FileType php noremap <Leader>\ :call PhpInsertUse()<CR>
-- ]],
--   false
-- )

-- -- keymaps.set("n", "gD", vim.lsp.buf.declaration, otps)
--
-- function _G.set_terminal_keymaps()
--   local opts = { buffer = 0 }
--   vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
--   vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
--   vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
--   vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
--   vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
--   vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
--   vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
-- end
--
-- -- if you only want these mappings for toggle term use term://*toggleterm#* instead
-- vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
