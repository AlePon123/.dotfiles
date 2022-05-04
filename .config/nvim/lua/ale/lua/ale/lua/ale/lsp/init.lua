local nmap = require("ale.keymap").nmap
local imap = require("ale.keymap").imap
local handlers = require "ale.lsp.handlers"
-- local signs = require "ale.lsp.signs"
local status = require "ale.lsp.status"
local nvim_status = require "lsp-status"
status.activate()

local filetype_attach = setmetatable({
  go = function(client)
    vim.cmd [[
      augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
      augroup END
    ]]
  end,

  rust = function()
    vim.cmd [[
      augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
      augroup END
    ]]
  end,
}, {
  __index = function()
    return function() end
  end,
})

local custom_attach = function(client)
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")

  nvim_status.on_attach(client)

nmap { 'ca',
  function()
    local opts = {
      winblend = 10,
      border = true,
      previewer = false,
      shorten_path = false,
    }
    require("telescope.builtin").lsp_code_actions(opts)
    end,
  { silent = true }
}
  nmap { "ha", "<cmd>lua vim.lsp.buf.hover()<CR>" }
  nmap { "<space>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>" }
  nmap { "<c-l>", "<cmd>lua vim.lsp.buf.signature_help()<CR>" }
  nmap { "gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>" }
  nmap { "gr", "<cmd>lua vim.lsp.buf.references()<CR>" }
  nmap { "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>" }
  nmap { "gd", "<cmd>lua vim.lsp.buf.definition()<CR>" }
  nmap { "gD", "<cmd>lua vim.lsp.buf.declaration<CR>" }

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

  if client.resolved_capabilities.code_lens then
    vim.cmd [[
      augroup lsp_document_codelens
        au! * <buffer>
        autocmd BufEnter ++once         <buffer> lua require"vim.lsp.codelens".refresh()
        autocmd BufWritePost,CursorHold <buffer> lua require"vim.lsp.codelens".refresh()
      augroup END
    ]]
  end

  filetype_attach[filetype](client)
end

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, nvim_status.capabilities)
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)

updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

return {
  on_attach = custom_attach,
  on_init = custom_init,
  capabilities = updated_capabilities,
}
