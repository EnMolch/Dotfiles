require'lualine'.setup{
    options = {
        icons_enabled = true,
        theme = 'tokyonight',
        section_separators = {'', ''},
        component_separators = {'', ''},
        disabled_filetypes = {},
    },
    sections= {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {'filename'},
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = {  },
      lualine_b = {  },
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {  },
      lualine_z = {  },
    },
}

-- --config for lualine
--let g:lualine = {
    --\'options' : {
    --\  'theme' : 'tokyonight',
    --\  'section_separators' : {'', ''},
    --\  'component_separators' : {'', ''},
    --\  'disabled_filetypes' : {},
    --\  'icons_enabled' : v:true,
    --\},
    --\'sections' : {
    --\  'lualine_a' : { {'mode', {'upper': v:true,},}, },
    --\  'lualine_b' : { {'branch', {'icon': '',}, }, },
    --\  'lualine_c' : { {'filename', {'file_status': v:true,},}, },
    --\  'lualine_x' : { 'encoding', 'fileformat', 'filetype' },
    --\  'lualine_y' : { 'progress' },
    --\  'lualine_z' : { 'location'  },
    --\},
    --\'inactive_sections' : {
    --\  'lualine_a' : {  },
    --\  'lualine_b' : {  },
    --\  'lualine_c' : { 'filename' },
    --\  'lualine_x' : { 'location' },
    --\  'lualine_y' : {  },
    --\  'lualine_z' : {  },
    --\},
        --\}
--lua require("lualine").setup()

