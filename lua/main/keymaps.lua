-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

-- Save file
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", opts)
vim.keymap.set("i", "<C-s>", "<esc><cmd> w <CR>", opts)

-- Quit file
vim.keymap.set("n", "<C-q>", "<cmd> q <CR>", opts)

-- Delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Toggle RZA theme
vim.keymap.set("n", "<leader>tv", require("main.rza").toggle, { desc = "Toggle color variant" })

-- Write a new line
vim.keymap.set("n", "<C-m>", "A<Enter>", opts)
-- vim.keymap.set("n", "<C-CR>", "A<Enter>", opts)

-- Split navigation using CTRL + hjkl
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
vim.keymap.set("n", "<C-j", "<C-w>j", { desc = "Move to below split" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
vim.keymap.set("i", "<C-k>", "<C-w>k", { desc = "Move to above split" })
vim.keymap.set("i", "<C-j", "<C-w>j", { desc = "Move to below split" })
vim.keymap.set("i", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("i", "<C-l>", "<C-w>l", { desc = "Move to right split" })


-- Resize splits using Option/Alt + []
vim.keymap.set("n", "<M-]>", "<cmd>vertical resize +2<CR>", { desc = "Increase width" })
vim.keymap.set("n", "<M-[>", "<cmd>vertical resize -2<CR>", { desc = "Decrease width" })

-- Swap lines
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { silent = true, noremap = true })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { silent = true, noremap = true })

-- Format line width to 120 characters
vim.keymap.set('n', '<leader>f', '<cmd> :set textwidth=120 <CR> ggVGgq')

-- Go to defintion in new vsplit
vim.api.nvim_set_keymap('n', 'gdv', '<cmd>vsplit | lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })

-- Copy relative file path to system clipboard
vim.keymap.set('n', '<leader>yr', function()
  -- Get the current working directory
  local cwd = vim.fn.getcwd()
  local absolute_path = vim.fn.expand('%:p')

  -- Remove the cwd from the absolute path to get the relative path
  -- Note: We add a / to the end of cwd to ensure proper path separation
  local relative_path = absolute_path:sub(#cwd + 2)

  vim.fn.setreg('+', relative_path)
  print('Yanked relative path: ' .. relative_path)
end, { desc = 'Yank relative file path to clipboard' })


-- Make all c, d, and s commands use the black hole register.
-- I know this isn't the ~vim way~ but I don't think it makes sense... sue me!!!
vim.keymap.set({ 'n', 'v' }, 'c', '"_c', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'd', '"_d', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 's', '"_s', { noremap = true })
vim.keymap.set('n', 'C', '"_C', { noremap = true })
vim.keymap.set('n', 'D', '"_D', { noremap = true })
vim.keymap.set('n', 'S', '"_S', { noremap = true })

-- Make all windows equal size
vim.keymap.set('n', '<leader>we', '<C-w>=', { noremap = true, desc = 'Make all windows equal size' })
