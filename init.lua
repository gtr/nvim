require("main.keymaps")
require("main.options")
require("main.snippets")
require("main.rza").setup()

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require("plugins.gitsigns"),
  require("plugins.autocomplete"),
  require("plugins.lsp"),
  require("plugins.telescope"),
  require("plugins.alpha"),
  require("plugins.tmux"),
  require("plugins.flash"),
  require("plugins.comment"),
  require("plugins.python"),
  require("plugins.conform"),
  require("plugins.treesitter"),
  require("plugins.indent-blankline"),
  require("plugins.other"),
  require("plugins.yazi"),
})
