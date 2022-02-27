local b = require("bufferline")

b.setup {
    options = {
      --      mappings = false,
      diagnostics = "nvim_diagnostic",
      show_buffer_close_icons = false,
      always_show_bufferline = false
    },
    highlights = { fill = { guibg = '#282c34' }, buffer_selected = { gui = 'bold' } }
}

