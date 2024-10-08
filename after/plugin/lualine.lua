local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

local function place()
  local colPre = "C:"
  local col = "%c"
  local linePre = " L:"
  local line = "%l/%L"
  return string.format("%s%s%s%s", colPre, col, linePre, line)
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'iceberg_dark',--'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', {'diff', source = diff_source}, 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},--{'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {{ place, padding = { left = 1, right = 1 } }}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {{'filename',
                  file_status = true,
                  newfile_status = false,
                  path = 0,
                  shorting_target = 40,
                  symbols = {
                    modified = '[+]',
                    readonly = '[READ]',
                    unnamed = '[No name]',
                    newfile = '[New]'
                  }}},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
