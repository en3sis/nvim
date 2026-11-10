local M = {}

local palettes = {
  light = {
    bg = "#fcfcfc",
    surface = "#f2f3f8",
    line = "#e8eaf3",
    border = "#d4d7e7",
    fg = "#14206e",
    sub = "#575f98",
    muted = "#787fad",
    accent = "#1f35c7",
    on_accent = "#eef0f8",
    blue = "#1f35c7",
    bright_blue = "#3a4fe0",
    red = "#c8102e",
    green = "#1d7a3e",
    yellow = "#9a5800",
    magenta = "#7b3cc0",
    cyan = "#0a679e",
    selection = "#c1c7ed",
    terminal = {
      "#14206e", "#c8102e", "#1d7a3e", "#9a5800", "#1f35c7", "#7b3cc0", "#0a679e", "#575f98",
      "#787fad", "#d93a4e", "#23874a", "#a86600", "#3a4fe0", "#8e4fd4", "#147aa8", "#0e1650",
    },
  },
  dark = {
    bg = "#1e1e1e",
    surface = "#26262e",
    line = "#2d2f3d",
    border = "#3a3c4e",
    fg = "#eef0f8",
    sub = "#c9cdea",
    muted = "#8d96cd",
    accent = "#eef0f8",
    on_accent = "#14206e",
    blue = "#b3bcff",
    bright_blue = "#d0d6ff",
    red = "#ff8f87",
    green = "#7fe3a9",
    yellow = "#ffd866",
    magenta = "#f0a8ff",
    cyan = "#8ee4ff",
    selection = "#424fac",
    terminal = {
      "#0d1660", "#ff8f87", "#7fe3a9", "#ffd866", "#b3bcff", "#f0a8ff", "#8ee4ff", "#c9cdea",
      "#8d96cd", "#ffaaa3", "#a2f0c3", "#ffe596", "#d0d6ff", "#f6c6ff", "#b4eeff", "#ffffff",
    },
  },
}

local function blend(fg, bg, alpha)
  local function channel(hex, i) return tonumber(hex:sub(i, i + 1), 16) end
  local out = "#"
  for _, i in ipairs({ 2, 4, 6 }) do
    out = out .. string.format("%02x", math.floor(channel(fg, i) * alpha + channel(bg, i) * (1 - alpha) + 0.5))
  end
  return out
end

function M.palette()
  return palettes[vim.o.background == "light" and "light" or "dark"]
end

function M.system_background()
  if vim.env.TMUX then
    local theme = vim.fn.system({ "tmux", "display", "-p", "#{client_theme}" })
    if theme:match("dark") then return "dark" end
    if theme:match("light") then return "light" end
  end
  local style = vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" })
  return style:match("Dark") and "dark" or "light"
end

function M.apply()
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
  vim.g.colors_name = "en3sis"

  local p = M.palette()
  local hl = function(group, spec) vim.api.nvim_set_hl(0, group, spec) end
  local tint = function(color, alpha) return blend(color, p.bg, alpha or 0.14) end

  for i, color in ipairs(p.terminal) do vim.g["terminal_color_" .. (i - 1)] = color end

  local groups = {
    Normal = { fg = p.fg, bg = "NONE" },
    NormalNC = { fg = p.fg, bg = "NONE" },
    NormalFloat = { fg = p.fg, bg = p.surface },
    FloatBorder = { fg = p.border, bg = p.surface },
    FloatTitle = { fg = p.blue, bg = p.surface, bold = true },
    FloatFooter = { fg = p.muted, bg = p.surface },
    WinSeparator = { fg = p.border },
    VertSplit = { link = "WinSeparator" },
    EndOfBuffer = { fg = p.bg },
    NonText = { fg = p.border },
    Whitespace = { fg = p.border },
    SpecialKey = { fg = p.border },
    Conceal = { fg = p.muted },

    LineNr = { fg = p.muted },
    LineNrAbove = { fg = p.muted },
    LineNrBelow = { fg = p.muted },
    CursorLineNr = { fg = p.blue, bold = true },
    CursorLine = { bg = p.line },
    CursorColumn = { bg = p.line },
    ColorColumn = { bg = p.surface },
    SignColumn = { bg = "NONE" },
    FoldColumn = { fg = p.muted, bg = "NONE" },
    Folded = { fg = p.sub, bg = p.surface },
    Cursor = { fg = p.on_accent, bg = p.accent },
    TermCursor = { fg = p.on_accent, bg = p.accent },

    Visual = { bg = p.selection },
    VisualNOS = { bg = p.selection },
    Search = { fg = p.fg, bg = tint(p.yellow, 0.28) },
    CurSearch = { fg = p.on_accent, bg = p.accent, bold = true },
    IncSearch = { fg = p.on_accent, bg = p.accent, bold = true },
    Substitute = { fg = p.on_accent, bg = p.red },
    MatchParen = { fg = p.blue, bg = tint(p.blue, 0.16), bold = true },

    Pmenu = { fg = p.fg, bg = p.surface },
    PmenuSel = { fg = p.on_accent, bg = p.accent },
    PmenuKind = { fg = p.magenta, bg = p.surface },
    PmenuKindSel = { fg = p.on_accent, bg = p.accent },
    PmenuExtra = { fg = p.muted, bg = p.surface },
    PmenuExtraSel = { fg = p.on_accent, bg = p.accent },
    PmenuSbar = { bg = p.surface },
    PmenuThumb = { bg = p.border },
    WildMenu = { link = "PmenuSel" },

    StatusLine = { fg = p.sub, bg = p.bg },
    StatusLineNC = { fg = p.muted, bg = p.bg },
    TabLine = { fg = p.muted, bg = p.bg },
    TabLineSel = { fg = p.fg, bg = p.line, bold = true },
    TabLineFill = { bg = p.bg },
    WinBar = { fg = p.sub },
    WinBarNC = { fg = p.muted },

    ModeMsg = { fg = p.sub },
    MsgArea = { fg = p.fg },
    MoreMsg = { fg = p.blue },
    Question = { fg = p.blue },
    ErrorMsg = { fg = p.red },
    WarningMsg = { fg = p.yellow },
    Directory = { fg = p.blue, bold = true },
    Title = { fg = p.blue, bold = true },
    QuickFixLine = { bg = p.line },

    Comment = { fg = p.muted },
    Constant = { fg = p.yellow, bold = true },
    String = { fg = p.green },
    Character = { fg = p.green },
    Number = { fg = p.yellow },
    Boolean = { fg = p.yellow },
    Float = { fg = p.yellow },
    Identifier = { fg = p.fg },
    Function = { fg = p.magenta, bold = true },
    Statement = { fg = p.blue, bold = true },
    Conditional = { fg = p.blue, bold = true },
    Repeat = { fg = p.blue, bold = true },
    Label = { fg = p.blue },
    Operator = { fg = p.sub },
    Keyword = { fg = p.blue, bold = true },
    Exception = { fg = p.blue, bold = true },
    PreProc = { fg = p.cyan },
    Include = { fg = p.blue, bold = true },
    Define = { fg = p.blue },
    Macro = { fg = p.cyan },
    Type = { fg = p.cyan },
    StorageClass = { fg = p.blue },
    Structure = { fg = p.cyan },
    Typedef = { fg = p.cyan },
    Special = { fg = p.cyan },
    SpecialChar = { fg = p.yellow },
    Tag = { fg = p.blue },
    Delimiter = { fg = p.sub },
    Debug = { fg = p.red },
    Underlined = { underline = true },
    Error = { fg = p.red },
    Todo = { fg = p.on_accent, bg = p.accent, bold = true },

    ["@variable"] = { fg = p.fg },
    ["@variable.builtin"] = { fg = p.cyan, bold = true },
    ["@variable.parameter"] = { fg = p.fg },
    ["@variable.member"] = { fg = p.sub },
    ["@property"] = { fg = p.sub },
    ["@constant"] = { fg = p.yellow, bold = true },
    ["@constant.builtin"] = { fg = p.yellow, bold = true },
    ["@module"] = { fg = p.cyan },
    ["@string"] = { fg = p.green },
    ["@string.escape"] = { fg = p.yellow },
    ["@string.special"] = { fg = p.cyan },
    ["@string.special.url"] = { fg = p.blue, underline = true },
    ["@function"] = { fg = p.magenta, bold = true },
    ["@function.builtin"] = { fg = p.magenta, bold = true },
    ["@function.call"] = { fg = p.magenta, bold = true },
    ["@function.method"] = { fg = p.magenta, bold = true },
    ["@function.method.call"] = { fg = p.magenta, bold = true },
    ["@constructor"] = { fg = p.cyan },
    ["@keyword"] = { fg = p.blue, bold = true },
    ["@keyword.function"] = { fg = p.blue, bold = true },
    ["@keyword.return"] = { fg = p.blue, bold = true },
    ["@keyword.operator"] = { fg = p.blue, bold = true },
    ["@operator"] = { fg = p.sub },
    ["@punctuation"] = { fg = p.sub },
    ["@punctuation.bracket"] = { fg = p.sub },
    ["@punctuation.delimiter"] = { fg = p.sub },
    ["@type"] = { fg = p.cyan },
    ["@type.builtin"] = { fg = p.cyan },
    ["@attribute"] = { fg = p.cyan },
    ["@tag"] = { fg = p.blue },
    ["@tag.attribute"] = { fg = p.sub },
    ["@tag.delimiter"] = { fg = p.muted },
    ["@comment"] = { fg = p.muted },
    ["@markup.heading"] = { fg = p.blue, bold = true },
    ["@markup.strong"] = { bold = true },
    ["@markup.italic"] = { italic = true },
    ["@markup.link"] = { fg = p.blue },
    ["@markup.link.url"] = { fg = p.blue, underline = true },
    ["@markup.raw"] = { fg = p.magenta },
    ["@markup.list"] = { fg = p.blue },
    ["@markup.quote"] = { fg = p.sub },
    ["@diff.plus"] = { fg = p.green },
    ["@diff.minus"] = { fg = p.red },
    ["@diff.delta"] = { fg = p.yellow },

    DiagnosticError = { fg = p.red },
    DiagnosticWarn = { fg = p.yellow },
    DiagnosticInfo = { fg = p.cyan },
    DiagnosticHint = { fg = p.magenta },
    DiagnosticOk = { fg = p.green },
    DiagnosticVirtualTextError = { fg = p.red, bg = tint(p.red, 0.08) },
    DiagnosticVirtualTextWarn = { fg = p.yellow, bg = tint(p.yellow, 0.08) },
    DiagnosticVirtualTextInfo = { fg = p.cyan, bg = tint(p.cyan, 0.08) },
    DiagnosticVirtualTextHint = { fg = p.magenta, bg = tint(p.magenta, 0.08) },
    DiagnosticUnderlineError = { undercurl = true, sp = p.red },
    DiagnosticUnderlineWarn = { undercurl = true, sp = p.yellow },
    DiagnosticUnderlineInfo = { undercurl = true, sp = p.cyan },
    DiagnosticUnderlineHint = { undercurl = true, sp = p.magenta },
    LspReferenceText = { bg = p.line },
    LspReferenceRead = { bg = p.line },
    LspReferenceWrite = { bg = p.line },
    LspInlayHint = { fg = p.muted, bg = tint(p.muted, 0.08) },
    LspSignatureActiveParameter = { fg = p.blue, bold = true },

    DiffAdd = { bg = tint(p.green) },
    DiffChange = { bg = tint(p.yellow, 0.1) },
    DiffDelete = { fg = p.red, bg = tint(p.red) },
    DiffText = { bg = tint(p.yellow, 0.24) },
    Added = { fg = p.green },
    Changed = { fg = p.yellow },
    Removed = { fg = p.red },
    SpellBad = { undercurl = true, sp = p.red },
    SpellCap = { undercurl = true, sp = p.yellow },
    SpellLocal = { undercurl = true, sp = p.cyan },
    SpellRare = { undercurl = true, sp = p.magenta },

    TelescopeNormal = { link = "NormalFloat" },
    TelescopeBorder = { link = "FloatBorder" },
    TelescopeTitle = { link = "FloatTitle" },
    TelescopePromptPrefix = { fg = p.blue, bg = p.surface },
    TelescopeSelection = { fg = p.fg, bg = p.line, bold = true },
    TelescopeSelectionCaret = { fg = p.blue, bg = p.line },
    TelescopeMatching = { fg = p.blue, bold = true },

    CmpItemAbbrMatch = { fg = p.blue, bold = true },
    CmpItemAbbrMatchFuzzy = { fg = p.blue, bold = true },
    CmpItemAbbrDeprecated = { fg = p.muted, strikethrough = true },
    CmpItemKind = { fg = p.magenta },
    CmpItemMenu = { fg = p.muted },

    NoiceCmdlinePopup = { fg = p.fg, bg = "NONE" },
    NoiceCmdlinePopupBorder = { fg = p.blue, bg = "NONE" },
    NoiceCmdlinePopupBorderSearch = { link = "NoiceCmdlinePopupBorder" },
    NoiceCmdlinePopupTitle = { fg = p.muted, bg = "NONE" },
    NoiceCmdlineIcon = { fg = p.blue, bold = true },
    NoiceCmdlineIconSearch = { link = "NoiceCmdlineIcon" },
    NoicePopupmenu = { fg = p.fg, bg = "NONE" },
    NoicePopupmenuBorder = { fg = p.border, bg = "NONE" },
    NoicePopupmenuSelected = { fg = p.fg, bg = p.line, bold = true },
    NoicePopupmenuMatch = { fg = p.blue, bold = true },
    NoiceScrollbar = { bg = "NONE" },
    NoiceScrollbarThumb = { bg = p.border },

    MiniIndentscopeSymbol = { fg = p.border },
    OilDir = { fg = p.blue, bold = true },
    OilDirIcon = { fg = p.blue },
    FidgetTitle = { fg = p.blue, bold = true },
    FidgetTask = { fg = p.muted },
    LazyNormal = { link = "NormalFloat" },
    MasonNormal = { link = "NormalFloat" },

    NotifyBackground = { bg = p.bg },
    NotifyERRORBorder = { fg = p.red },
    NotifyWARNBorder = { fg = p.yellow },
    NotifyINFOBorder = { fg = p.border },
    NotifyDEBUGBorder = { fg = p.border },
    NotifyTRACEBorder = { fg = p.border },
    NotifyERRORIcon = { fg = p.red },
    NotifyWARNIcon = { fg = p.yellow },
    NotifyINFOIcon = { fg = p.blue },
    NotifyDEBUGIcon = { fg = p.muted },
    NotifyTRACEIcon = { fg = p.magenta },
    NotifyERRORTitle = { fg = p.red },
    NotifyWARNTitle = { fg = p.yellow },
    NotifyINFOTitle = { fg = p.blue },
    NotifyDEBUGTitle = { fg = p.muted },
    NotifyTRACETitle = { fg = p.magenta },

    RenderMarkdownCode = { bg = p.surface },
    RenderMarkdownCodeInline = { fg = p.magenta, bg = p.surface },
    RenderMarkdownH1Bg = { bg = tint(p.blue, 0.1) },
    RenderMarkdownH2Bg = { bg = tint(p.blue, 0.07) },
    RenderMarkdownH3Bg = { bg = tint(p.blue, 0.05) },
  }

  for group, spec in pairs(groups) do hl(group, spec) end
end

return M
