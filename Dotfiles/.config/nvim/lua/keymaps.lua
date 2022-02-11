local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then 
      options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('v', '<C-c>', '"+y') --copy to system clipboard
map('i', '<C-v>', '<Esc>"+p')
map('n', '<C-s>', ':w<CR>', {noremap = true})
map('v', 'q', '<', {noremap = true})
map('v', 'e', '>', {noremap = true})

