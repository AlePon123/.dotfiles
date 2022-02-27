local imap = require('ale.keymap').imap
local nmap = require('ale.keymap').nmap
local vmap = require('ale.keymap').vmap

vim.g.mapleader = " "

--move around lsp Warnings/Errors
nmap{'g[', ':lua vim.diagnostic.goto_prev(}<CR>', { noremap = true, silent = true }}
nmap{'g]', ':lua vim.diagnostic.goto_next(}<CR>', { noremap = true, silent = true }}

vmap { '<C-c>', '"+y', { noremap = true } } --yank to system clipboard
imap { '<C-v>', '<Esc>"+p', } --paste from system clipboard
nmap { '<C-s>', ':w<CR>', { noremap = true } } --save file
nmap { '<Space>', ':nohl<CR>', { noremap = true } } --nohl

--save and source for nvim filetype
nmap { 
    '<Space>t', 
    function ()
        if vim.bo.filetype == 'lua' or vim.bo.filetype == 'vim' then 
            vim.cmd[[w]]
            vim.cmd[[so %]]
        else 
            print "Not nvim filetype"
        end
    end,
} 

vmap { 'q', '<' }
vmap { 'e', '>' }

-- Easier Moving between splits
nmap { '<C-J>', '<C-W><C-J>',  { noremap = true } }
nmap { '<C-K>', '<C-W><C-K>',  { noremap = true } }
nmap { '<C-L>', '<C-W><C-L>',  { noremap = true } }
nmap { '<C-H>', '<C-W><C-H>',  { noremap = true } }

--Easier Moving between tabs
nmap { '<C-r>', ':lua require("bufferline").cycle(1)<CR>',  { noremap = true } }
nmap { '<C-q>', ':lua require("bufferline").cycle(-1)<CR>',   { noremap = true } }
