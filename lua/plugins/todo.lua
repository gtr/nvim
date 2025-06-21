return {
  "todo",
  name = "todo",
  dir = vim.fn.stdpath("config") .. "/lua/custom/todo",
  dev = true,
  config = function()
    require("custom.todo").setup()
  end,
}

