-- ~/.config/nvim/lua/custom/todo/init.lua

local M = {}

-- Function to find the closest Monday (or current day if it's Monday)
local function get_closest_monday()
  local current_time = os.date("*t")
  local day_of_week = current_time.wday -- 1 = Sunday, 2 = Monday, ... 7 = Saturday

  local days_to_subtract = (day_of_week == 1) and 6 or (day_of_week - 2)

  -- Create a new date object for the closest Monday
  local monday_time = os.time({
    year = current_time.year,
    month = current_time.month,
    day = current_time.day - days_to_subtract,
    hour = 0,
    min = 0,
    sec = 0
  })

  return monday_time
end

-- Function to generate content for the todo file
local function generate_todo_content(monday_time)
  local content = {}

  for i = 0, 6 do
    local day_time = monday_time + i * 86400 -- 86400 seconds = 1 day
    local day_str = os.date("### %A, %B %d, %Y", day_time)
    table.insert(content, day_str)
    table.insert(content, "")
    table.insert(content, "- [ ]")
    table.insert(content, "")
  end

  return table.concat(content, "\n")
end

-- Function to ensure directory exists
local function ensure_directory_exists(dir_path)
  local cmd = "mkdir -p " .. dir_path
  vim.fn.system(cmd)
end

-- Function to create or open the todo file
function M.open_todo()
  -- Get base directory
  local base_dir = vim.fn.expand("~/notes/todo")

  -- Get current year
  local year = os.date("%Y")
  local year_dir = base_dir .. "/" .. year

  -- Ensure the year directory exists
  ensure_directory_exists(year_dir)

  -- Get the closest Monday
  local monday_time = get_closest_monday()

  -- Format the file name (MM-DD-YYYY.md)
  local file_name = os.date("%m-%d-%Y.md", monday_time)
  local file_path = year_dir .. "/" .. file_name

  -- Check if the file exists, create it if it doesn't
  local file = io.open(file_path, "r")
  if not file then
    -- File doesn't exist, create it
    file = io.open(file_path, "w")
    if file then
      file:write(generate_todo_content(monday_time))
      file:close()
    else
      vim.notify("Failed to create todo file: " .. file_path, vim.log.levels.ERROR)
      return
    end
  else
    -- File exists, close it
    file:close()
  end

  -- Open the file in a floating window
  local width = math.floor(vim.o.columns * 0.35)
  local height = math.floor(vim.o.lines * 0.7)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, "filetype", "markdown")

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded"
  })

  -- Set some window-local options
  vim.api.nvim_win_set_option(win, "winblend", 0)

  -- Load the file content into the buffer
  vim.api.nvim_command("edit " .. file_path)
end

-- Set up the command and mapping
function M.setup()
  vim.api.nvim_create_user_command("Todo", M.open_todo, {})
  vim.api.nvim_set_keymap("n", "<leader>td", ":Todo<CR>", { noremap = true, silent = true })
end

return M
