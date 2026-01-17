---@diagnostic disable: undefined-global
vim.wo.number = true
vim.o.clipboard = "unnamedplus"
vim.o.linebreak = true
vim.o.mouse = "a"
vim.o.autoindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.scrolloff = 4
vim.o.sidescrolloff = 8
vim.o.cursorline = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.hlsearch = false
vim.opt.termguicolors = true
vim.o.whichwrap = "bs<>[]hl"
vim.o.numberwidth = 4
vim.o.swapfile = false
vim.o.smartindent = true
vim.o.backspace = "indent,eol,start"
vim.o.pumheight = 10
vim.o.conceallevel = 0
vim.wo.signcolumn = "yes"
vim.o.fileencoding = "utf-8"
vim.o.cmdheight = 1
vim.o.breakindent = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true
vim.o.completeopt = "menuone,noselect"
vim.opt.shortmess:append("c")
vim.opt.iskeyword:append("-")
vim.opt.formatoptions:remove({ "c", "r", "o" })
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")
vim.opt.scrolloff = 6
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.wo.relativenumber = true
-- Blinking cursor shenanigans
vim.opt.guicursor = {
  "n-v-c:block-Cursor/lCursor-blinkon500-blinkoff500",
  "i-ci-ve:ver25-Cursor/lCursor-blinkon500-blinkoff500",
  "r-cr:hor20-Cursor/lCursor-blinkon500-blinkoff500",
  "o:hor50-Cursor/lCursor-blinkon500-blinkoff500",
}
vim.opt.fillchars:append({
  vert = "│",
  horiz = "─",
  horizup = "┴",
  horizdown = "┬",
  vertleft = "┤",
  vertright = "├",
  verthoriz = "┼",
})

vim.o.statusline = table.concat({
  " %f",
  "%m ",
  "%=",
  " %l:%c ",
})

vim.opt.fillchars:append({
  stl = "─",
  stlnc = "─",
})

-- Remember where we left off
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local last_pos = vim.fn.line("'\"")
    if last_pos > 0 and last_pos <= vim.fn.line("$") then
      vim.fn.setpos(".", vim.fn.getpos("'\""))
    end
  end,
})

-- Disable formatting in markdown code blocks
vim.g.vim_markdown_conceal = 0
vim.g.vim_markdown_conceal_code_blocks = 0

vim.o.laststatus = 2

-- FileType-specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.textwidth = 120
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "zig",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.textwidth = 120
  end,
})

-- Force a clean refresh after Zellij pane closes / resizes / focus changes
do
  local timer = vim.loop.new_timer()
  local function bounce()
    timer:stop()
    timer:start(60, 0, function()
      vim.schedule(function()
        vim.cmd("silent! redrawstatus!")
        vim.cmd("silent! redrawtabline")
      end)
    end)
  end

  vim.api.nvim_create_autocmd(
    { "VimResized", "WinEnter", "WinClosed", "TabEnter", "FocusGained" },
    { callback = bounce }
  )
end
