local M = {}

M.current_style = 'dark'

local colors = {
  dark = {
    bg = '#000000',
    fg = '#FFFFFF',
    red = '#d47780',
    green = '#8DC48E',
    blue = '#80afd9',
    yellow = '#e0dca4',
    purple = '#c5a1d6',
    orange = '#d9ae80',
    comment = '#8c8785',
    white = '#E8E3E3',
    brown = '#8c8785',
    vcs = {
      added = '#83E379',
      changed = '#DCA561',
      removed = '#E82424',
    },
    cursorLine = '#2B2E33',
  },
  light = {
    bg = '#FFFFFF',
    fg = '#383a42',
    red = '#ad443b',
    green = '#468c45',
    blue = '#2C84BC',
    yellow = '#50a14f',
    purple = '#A626A4',
    orange = '#cc9547',
    comment = '#a0a1a7',
    brown = '#a0a1a7',
    cursorLine = '#e3e3e3',
    vcs = {
      added = '#50a14f',
      changed = '#DCA561',
      removed = '#E82424',
    },
  },
}

function M.setup(opts)
  opts = opts or {}
  local style = opts.style or M.current_style
  M.current_style = style

  vim.cmd 'highlight clear'
  if vim.fn.exists 'syntax_on' then
    vim.cmd 'syntax reset'
  end

  vim.o.background = style
  vim.g.colors_name = 'rza'

  local theme = style == 'light' and colors.light or colors.dark

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
    Type = { fg = theme.orange },
    Special = { fg = theme.fg },
    Boolean = { fg = theme.orange },
    LineNr = { fg = theme.brown },
    CursorLine = { bg = theme.cursorLine },
    CursorLineNr = { fg = theme.purple, bold = true, underline = true },
    EndOfBuffer = { fg = theme.purple },
    Directory = { fg = theme.purple },
    Title = { fg = theme.purple },

    -- Treesitter groups
    ['@function'] = { fg = theme.purple },
    ['@function.builtin'] = { fg = theme.orange },
    ['@keyword'] = { fg = theme.red },
    ['@string'] = { fg = theme.yellow },
    ['@variable'] = { fg = theme.white },

    -- Python
    ['@constant.builtin.python'] = { fg = theme.orange },
    ['@constructor.python'] = { fg = theme.orange },
    ['@function.builtin.python'] = { fg = theme.purple },
    ['@type.python'] = { fg = theme.orange },
    ['@keyword.operator.python'] = { fg = theme.red },
    ['@keyword.return.python'] = { fg = theme.red },
    ['@variable.parameter.python'] = { fg = theme.blue },
    ['@type.builtin.python'] = { fg = theme.orange },
    ['@keyword.conditional.python'] = { fg = theme.red },
    ['@operator.python'] = { fg = theme.red },
    ['@number.python'] = { fg = theme.green },
    ['@constant.python'] = { fg = theme.blue },
    ['@number.float.python'] = { fg = theme.green },
    ['@attribute.python'] = { fg = theme.red },

    ['@punctuation.bracket'] = { fg = theme.brown },
    ['@constructor.special.lua'] = { fg = theme.brown },
    ['@punctuation.special.python'] = { fg = theme.brown },
    ['@punctuation.comma'] = { fg = theme.brown },
    ['@punctuation.bracket.python'] = { fg = theme.brown },
    ['@punctuation.delimiter.python'] = { fg = theme.brown },

    -- Markdown
    ['@markup.heading.1.markdown'] = { fg = theme.purple, bold = true },
    ['@markup.heading.2.markdown'] = { fg = theme.purple, bold = true },
    ['@markup.heading.3.markdown'] = { fg = theme.purple, bold = true },
    ['@markup.heading.4.markdown'] = { fg = theme.purple, bold = true },
    ['@markup.strong'] = { fg = theme.blue },
    ['@markup.raw.markdown_inline'] = { fg = theme.red },

    -- Telescope
    TelescopeBorder = { fg = theme.fg },
    TelescopePromptBorder = { fg = theme.fg },
    TelescopeResultsBorder = { fg = theme.fg },
    TelescopePreviewBorder = { fg = theme.fg },

    -- VCS highlighting (for plugins like gitsigns)
    DiffAdd = { fg = theme.vcs.added },
    DiffChange = { fg = theme.vcs.changed },
    DiffDelete = { fg = theme.vcs.removed },

    -- Indent blank line
    IblIndent = { fg = theme.comment },

    -- Gitsigns plugin specific
    GitSignsAdd = { fg = theme.vcs.added },
    GitSignsChange = { fg = theme.vcs.changed },
    GitSignsDelete = { fg = theme.vcs.removed },
    SignAdd = { fg = theme.vcs.added, bg = theme.bg },
    SignChange = { fg = theme.vcs.changed, bg = theme.bg },
    SignDelete = { fg = theme.vcs.removed, bg = theme.bg },

    -- Mini.statusline highlight groups
    MiiniStatuslineModeNormal = { fg = theme.fg, bg = theme.bg, bold = false },
    MiniStatuslineModeInsert = { fg = theme.green, bg = theme.bg, bold = true },
    MiniStatuslineModeVisual = { fg = theme.purple, bg = theme.bg, bold = true },
    MiniStatuslineModeReplace = { fg = theme.red, bg = theme.bg, bold = true },
    MiniStatuslineModeCommand = { fg = theme.yellow, bg = theme.bg, bold = true },
    MiniStatuslineModeOther = { fg = theme.cyan, bg = theme.bg, bold = true },

    MiniStatuslineDevinfo = { fg = theme.fg, bg = theme.bg },      -- Git branch, file info
    MiniStatuslineFilename = { fg = theme.cyan, bg = theme.bg },   -- Current filename
    MiniStatuslineFileinfo = { fg = theme.yellow, bg = theme.bg }, -- File encoding, type
    MiniStatuslineInactive = { fg = theme.fg_dim, bg = theme.bg }, -- Inactive window statusline
    MiniStatuslineRuler = { fg = theme.green, bg = theme.bg },

    -- Alpha
    AlphaHeader = { fg = theme.fg, bg = theme.fg },
    AlphaButtons = { fg = theme.blue },
    AlphaFooter = { fg = theme.comment },
  }

  -- Apply highlights
  for group, settings in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, settings)
  end
end

function M.toggle()
  local new_style = M.current_style == 'dark' and 'light' or 'dark'
  M.setup({ style = new_style })
end

return M
