---@diagnostic disable: undefined-global
require("main.keymaps")
require("main.options")
require("main.snippets")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

if vim.fn.getenv("KITTY_WINDOW_ID") == nil and vim.fn.executable("kitty") == 1 then
  local window_id = vim.fn.system("kitty @ ls | head -n1 | cut -d: -f1")
  window_id = vim.trim(window_id)
  if window_id ~= "" then
    vim.env.KITTY_WINDOW_ID = window_id
  end
end

require("lazy").setup({
  {
    dir = "~/gtr/rza",
    name = "rza",
    priority = 1000, -- load before other plugins
    config = function()
      vim.cmd.colorscheme("rza")
    end,
  },
  require("plugins.gitsigns"),
  require("plugins.autocomplete"),
  require("plugins.barbecue"),
  require("plugins.lsp"),
  require("plugins.telescope"),
  require("plugins.alpha"),
  require("plugins.tmux"),
  require("plugins.flash"),
  require("plugins.comment"),
  require("plugins.conform"),
  require("plugins.treesitter"),
  require("plugins.surround"),
  require("plugins.indent-blankline"),
  require("plugins.other"),
  require("plugins.noice"),
  require("plugins.oil"),
  require("plugins.typst"),
  require("plugins.latex"),
  require("plugins.markdown-preview"),
  require("custom.todo").setup(),
})
