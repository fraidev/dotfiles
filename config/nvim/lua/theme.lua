local colors = {
    -- bg = "#202328",
    -- bg = "#000000",
    bg = "#292C33",
    -- bg = "none",
    fg = "#bbc2cf",
    aqua = "#3affdb",
    beige = "#f5c06f",
    blue = "#51afef",
    brown = "#905532",
    cyan = "#008080",
    darkblue = "#081633",
    darkorange = "#f16529",
    green = "#98be65",
    grey = "#8c979a",
    lightblue = "#5fd7ff",
    lightgreen = "#31b53e",
    magenta = "#c678dd",
    orange = "#d4843e",
    pink = "#cb6f6f",
    purple = "#834f79",
    red = "#ae403f",
    salmon = "#ee6e73",
    violet = "#a9a1e1",
    white = "#eff0f1",
    yellow = "#f09f17",
    black = "#202328"
}

local icons = {
    -- system icons
    linux = " ",
    macos = " ",
    windows = " ",
    -- diagnostic icons
    -- error = "",
    error = " ",
    warning = "",
    warning_sign = " ",
  
    info = "",
    info_sign = " ",
    -- hint = "",
    hint = "󰠠 ",
    -- hint = "",
    lsp = "",
    line = "☰",
    -- git icons
    git = "",
    unstaged = "●",
    staged = "✓",
    unmerged = "",
    renamed = "➜",
    untracked = "★",
    ignored = "◌",
    modified = "",
    deleted = "",
    added = "",
    -- file icons
    arrow_open = "",
    arrow_closed = "",
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink_open = "",
    file = "",
    symlink = "",
    file_readonly = "",
    file_modified = "",
    -- misc
    devil = "",
    bsd = "",
    ghost = ""
}

return {
    colors = colors,
    icons = icons
}
