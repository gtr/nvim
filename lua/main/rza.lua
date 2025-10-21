local M = {}

M.current_style = "dark"

local colors = {
  dark = {
    bg = "#000000",
    fg = "#FFFFFF",
    -- red = '#d47780',
    red = "#D9669A",
    green = "#9BBF8C",
    -- blue = '#95BDDF',
    blue = "#99C9D2",
    yellow = "#e0dca4",
    purple = "#c5a1d6",
    lavender = "#A6ABF2",
    orange = "#FAC351",
    comment = "#8c8785",
    ether = "#63605e",
    white = "#E8E3E3",
    brown = "#8c8785",
    vcs = {
      added = "#83E379",
      changed = "#DCA561",
      removed = "#E82424",
    },
    cursorLine = "#2B2E33",
  },
  light = {
    bg = "#FFFFFF",
    fg = "#383a42",
    red = "#ad443b",
    green = "#468c45",
    blue = "#2C84BC",
    yellow = "#50a14f",
    purple = "#A626A4",
    lavender = "#A6ABF2",
    orange = "#FAC351",
    comment = "#a0a1a7",
    brown = "#a0a1a7",
    ether = "#e3e3e3",
    cursorLine = "#e3e3e3",
    vcs = {
      added = "#50a14f",
      changed = "#DCA561",
      removed = "#E82424",
    },
  },
}

function M.setup(opts)
  opts = opts or {}
  local style = opts.style or M.current_style
  M.current_style = style

  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.o.background = style
  vim.g.colors_name = "rza"

  local theme = style == "light" and colors.light or colors.dark

  local highlights = {
    -- Basic highlights
    Normal = { fg = theme.fg, bg = theme.bg },
    NormalFloat = { fg = theme.fg, bg = theme.bg },
    Comment = { fg = theme.comment },

    -- Syntax highlighting
    Constant = { fg = theme.purple },
    String = { fg = theme.yellow },
    Identifier = { fg = theme.blue },
    Function = { fg = theme.yellow },
    Statement = { fg = theme.red },
    Keyword = { fg = theme.red },
    Type = { fg = theme.lavender },
    Special = { fg = theme.fg },
    Boolean = { fg = theme.lavender },
    LineNr = { fg = theme.brown },
    CursorLine = { bg = theme.cursorLine },
    CursorLineNr = { fg = theme.orange, bold = true, underline = true },
    EndOfBuffer = { fg = theme.lavender },
    Directory = { fg = theme.lavender },
    Title = { fg = theme.lavender },
    TodoFgTODO = { fg = theme.lavender },

    -- Treesitter groups
    ["@function"] = { fg = theme.purple },
    ["@function.builtin"] = { fg = theme.lavender },
    ["@keyword"] = { fg = theme.red },
    ["@string"] = { fg = theme.yellow },
    ["@variable"] = { fg = theme.white },

    -- Python
    ["@attribute.python"] = { fg = theme.red },
    ["@constant.builtin.python"] = { fg = theme.lavender },
    ["@constant.python"] = { fg = theme.blue },
    ["@constructor.python"] = { fg = theme.lavender },
    ["@function.builtin.python"] = { fg = theme.purple },
    ["@keyword.operator.python"] = { fg = theme.red },
    ["@keyword.return.python"] = { fg = theme.red },
    ["@keyword.conditional.python"] = { fg = theme.red },
    ["@number.python"] = { fg = theme.green },
    ["@number.float.python"] = { fg = theme.green },
    ["@operator.python"] = { fg = theme.red },
    ["@punctuation.bracket"] = { fg = theme.brown },
    ["@punctuation.comma"] = { fg = theme.brown },
    ["@punctuation.bracket.python"] = { fg = theme.brown },
    ["@punctuation.delimiter.python"] = { fg = theme.brown },
    ["@punctuation.special.python"] = { fg = theme.brown },
    ["@type.builtin.python"] = { fg = theme.lavender },
    ["@type.python"] = { fg = theme.lavender },
    ["@variable.member.python"] = { fg = theme.blue },
    ["@variable.parameter.python"] = { fg = theme.blue },

    -- Rust
    ["@type.builtin.rust"] = { fg = theme.lavender },
    ["@operator.rust"] = { fg = theme.red },

    -- Lua
    ["@constructor.special.lua"] = { fg = theme.brown },

    -- JSON
    ["@number.json"] = { fg = theme.green },
    ["@constant.builtin.json"] = { fg = theme.red },

    -- Markdown
    ["@markup.heading.1.markdown"] = { fg = theme.lavender, bold = true },
    ["@markup.heading.2.markdown"] = { fg = theme.lavender, bold = true },
    ["@markup.heading.3.markdown"] = { fg = theme.lavender, bold = true },
    ["@markup.heading.4.markdown"] = { fg = theme.lavender, bold = true },
    ["@markup.strong"] = { fg = theme.blue, bold = true },
    ["@markup.italic"] = { fg = theme.yellow, italic = true },
    ["@markup.raw.markdown_inline"] = { fg = theme.red },
    ["@markup.quote.markdown"] = { fg = theme.comment },
    ["@markup.list.markdown"] = { fg = theme.green },
    ["@label.markdown"] = { fg = theme.comment },
    ["@punctuation.special.markdown"] = { fg = theme.comment },
    ["@markup.list.checked.markdown"] = { fg = theme.lavender },

    -- Zig
    ["@constant.builtin.zig"] = { fg = theme.lavender },
    ["@type.builtin.zig"] = { fg = theme.lavender },
    ["@operator.zig"] = { fg = theme.red },

    -- Telescope
    TelescopeBorder = { fg = theme.fg },
    TelescopePromptBorder = { fg = theme.fg },
    TelescopeResultsBorder = { fg = theme.fg },
    TelescopePreviewBorder = { fg = theme.fg },

    -- VCS highlighting (for plugins like gitsigns)
    DiffAdd = { fg = theme.vcs.added },
    DiffChange = { fg = theme.vcs.changed },
    DiffDelete = { fg = theme.vcs.removed },

    -- Gitsigns plugin specific
    GitSignsAdd = { fg = theme.vcs.added },
    GitSignsChange = { fg = theme.vcs.changed },
    GitSignsDelete = { fg = theme.vcs.removed },
    SignAdd = { fg = theme.vcs.added, bg = theme.bg },
    SignChange = { fg = theme.vcs.changed, bg = theme.bg },
    SignDelete = { fg = theme.vcs.removed, bg = theme.bg },

    -- Alpha
    AlphaHeader = { fg = theme.fg, bg = theme.fg },
    AlphaButtons = { fg = theme.blue },
    AlphaFooter = { fg = theme.comment },

    -- Indent blank line
    IblIndent = { fg = theme.ether },

    -- Borders
    WinSeparator = { fg = theme.comment },
    VertSplit = { fg = theme.comment },

    -- TypeScript :|
    ["@tag.builtin.tsx"] = { fg = theme.lavender },
  }

  -- Apply highlights
  for group, settings in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, settings)
  end
end

function M.toggle()
  local new_style = M.current_style == "dark" and "light" or "dark"
  M.setup({ style = new_style })
end

return M
