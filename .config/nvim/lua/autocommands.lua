vim.cmd [[ autocmd CursorHold * lua require('lsp-status').update_current_function()]]
vim.cmd [[ autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })]]

