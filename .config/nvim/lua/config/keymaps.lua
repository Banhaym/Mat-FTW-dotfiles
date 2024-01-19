-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

local Util = require("lazyvim.util")

-- Search current word
local searching_brave = function()
  vim.fn.system({ "xdg-open", "https://search.brave.com/search?q=" .. vim.fn.expand("<cword>") })
end
map("n", "<leader>?", searching_brave, { noremap = true, silent = true, desc = "Search current word on brave search" })

-- Lazy options
map("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })
-- stylua: ignore start
map("n", "<leader>ld", function() vim.fn.system({ "xdg-open", "https://lazyvim.org" }) end, { desc = "Docs" })
map("n", "<leader>lr", function() vim.fn.system({ "xdg-open", "https://github.com/LazyVim/LazyVim" }) end, { desc = "Repo" })
map("n", "<leader>le", "<cmd>LazyExtras<cr>", { desc = "Extras" })
map("n", "<leader>lc", function() Util.news.changelog() end, { desc = "LazyVim Changelog" })
-- stylua: ignore end
map("n", "<leader>L", "<Nop>")

-- Toggle background
-- stylua: ignore
map("n", "<leader>uB", function() Util.toggle("background", false, { "light", "dark" }) end, { desc = "Toggle Background" })

-- Identation
map("n", "<", "<<", { desc = "Deindent" })
map("n", ">", ">>", { desc = "Indent" })

-- Save without formatting
map("n", "<A-s>", "<cmd>noautocmd w<CR>", { desc = "Save without formatting" })

-- Disable lazyterminal keymap
map("n", "<leader>fT", "<Nop>")

-- Cursor navigation on insert mode
map("i", "<M-h>", "<left>", { desc = "Move cursor left" })
map("i", "<M-l>", "<right>", { desc = "Move cursor left" })
map("i", "<M-j>", "<down>", { desc = "Move cursor left" })
map("i", "<M-k>", "<up>", { desc = "Move cursor left" })

-- End of the word backwards
map("n", "E", "ge")

-- Increment/decrement
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

-- Tabs
map("n", "]<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "[<tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
for i = 1, 9 do
  map("n", "<leader><tab>" .. i, "<cmd>tabn " .. i .. "<cr>", { desc = "Tab " .. i })
end

-- Buffers
map("n", "<leader>bf", "<cmd>bfirst<cr>", { desc = "First Buffer" })
map("n", "<leader>ba", "<cmd>blast<cr>", { desc = "Last Buffer" })

-- Center the screen automatically
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Toggle statusline
map("n", "<leader>uS", function()
  if vim.opt.laststatus:get() == 0 then
    vim.opt.laststatus = 3
  else
    vim.opt.laststatus = 0
  end
end, { desc = "Toggle Statusline" })

-- Plugin Info
map("n", "<leader>cif", "<cmd>LazyFormatInfo<cr>", { desc = "Formatting" })
map("n", "<leader>cic", "<cmd>ConformInfo<cr>", { desc = "Conform" })
map("n", "<leader>cir", "<cmd>LazyRoot<cr>", { desc = "Root" })

-- U for redo
map("n", "U", "<C-r>", { desc = "Redo" })

-- Move to beginning/end of line
map("n", "<a-h>", "_", { desc = "First character of Line" })
map("n", "<a-l>", "$", { desc = "Last character of Line" })

-- Copy whole text to clipboard
map("n", "<C-c>", ":%y+<CR>", { desc = "Copy whole text to clipboard", silent = true })

-- Motion
map("c", "<C-a>", "<C-b>", { desc = "Start Of Line" })
map("i", "<C-a>", "<Home>", { desc = "Start Of Line" })
map("i", "<C-e>", "<End>", { desc = "End Of Line" })

-- Select all text
map("n", "<C-a>", "gg<S-V>G", { desc = "Select all text", silent = true, noremap = true })

-- Paste options
map("i", "<C-v>", '<C-r>"', { desc = "Paste on insert mode" })
map("v", "p", '"_dP', { desc = "Paste without overwriting" })

-- Delete and change without yanking
map({ "n", "x" }, "<A-d>", '"_d', { desc = "Delete without yanking" })
map({ "n", "x" }, "<A-c>", '"_c', { desc = "Change without yanking" })

-- Deleting without yanking empty line
map("n", "dd", function()
  local is_empty_line = vim.api.nvim_get_current_line():match("^%s*$")
  if is_empty_line then
    return '"_dd'
  else
    return "dd"
  end
end, { noremap = true, expr = true, desc = "Don't yank empty line to clipboard" })

-- Search inside visually highlighted text. Use `silent = false` for it to
-- make effect immediately.
map("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })

-- Search visually selected text (slightly better than builtins in Neovim>=0.8)
map("x", "*", [[y/\V<C-R>=escape(@", '/\')<CR><CR>]])
map("x", "#", [[y?\V<C-R>=escape(@", '?\')<CR><CR>]])
