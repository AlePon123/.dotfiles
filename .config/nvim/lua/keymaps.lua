local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then 
      options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

--Show diagnostic popup on cursor hold
vim.cmd[[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })]]

--move around lsp Warnings/Errors
map('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
map('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })

map('v', '<C-c>', '"+y') --yank to system clipboard
map('i', '<C-v>', '<Esc>"+p') --paste from system clipboard
map('n', '<C-s>', '<cmd>w<CR>', { noremap = true }) --save file
map('n', '<Space>','<cmd>nohl<CR>', { noremap = true }) --nohl 

map('v', 'q', '<')
map('v', 'e', '>')

-- Easier Moving between splits
map('n','<C-J>', '<C-W><C-J>', { noremap = true })
map('n','<C-K>', '<C-W><C-K>', { noremap = true })
map('n','<C-L>', '<C-W><C-L>', { noremap = true })
map('n','<C-H>', '<C-W><C-H>', { noremap = true })

-- Easier Moving between tabs
map('n', '<C-r>', '<cmd>lua require("bufferline").cycle(-1)<CR>', { noremap = true })
map('n', '<C-l>', '<cmd>lua require("bufferline").cycle(1)<CR>', { noremap = true })
map('n', 'H', '<cmd>lua require("bufferline").move(-1)<CR>', { noremap = true })
map('n', 'L', '<cmd>lua require("bufferline").move(1)<CR>', { noremap = true })
