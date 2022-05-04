vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append "c"

local nvim_lsp = require"lspconfig"
local lspkind = require "lspkind"
local tabnine = require('cmp_tabnine.config')
local compare = require('cmp.config.compare')

lspkind.init()

local cmp = require "cmp"
cmp.setup {
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
        ["<C-space>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        })
    },
    formatting = {
        format = lspkind.cmp_format {
          with_text = true,
          menu = {
            buffer = "[buf]",
            nvim_lsp = "[LSP]",
            cmp_tabnine = "[TabNine]",
            nvim_lua = "[vim]", 
            path = "[path]",
            luasnip = "[snip]",
          },
        },
    },
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,

        function(entry1, entry2)
          local _, entry1_under = entry1.completion_item.label:find "^_+"
          local _, entry2_under = entry2.completion_item.label:find "^_+"
          entry1_under = entry1_under or 0
          entry2_under = entry2_under or 0
          if entry1_under > entry2_under then
            return false
          elseif entry1_under < entry2_under then
            return true
          end
        end,

        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    experimental = {
        ghost_text = true,
    },
    sources = {
       { name = 'nvim_lsp_signature_help' },
       { name = 'nvim_lsp' },
       { name = "nvim_lua" },
       { name = 'path' },
       { name = 'luasnip' }, 
       { name = 'buffer', keyword_length = 3 },
    },
}

_ = vim.cmd [[
  augroup CmpZsh
    au!
    autocmd Filetype zsh lua require'cmp'.setup.buffer { sources = { { name = "zsh" }, } }
  augroup END
]]

local Group = require("colorbuddy.group").Group
local Color = require("colorbuddy.color").Color
local g = require("colorbuddy.group").groups
local s = require("colorbuddy.style").styles
local c = require("colorbuddy.color").colors

Color.new('GruvBoxOrange', '#fe8019')
Color.new('GruvBoxGreen', '#b8bb26')

Group.new("CmpItemAbbr", c.GruvBoxGreen)
Group.new("CmpItemAbbrDeprecated", c.red)
Group.new("CmpItemAbbrMatchFuzzy", g.CmpItemAbbr.fg:dark(), nil, s.italic)
Group.new("CmpItemKind", c.GruvBoxOrange)
Group.new("CmpItemMenu", c.gray)
