local imap = require('ale.keymap').imap
local nmap = require('ale.keymap').nmap
local vmap = require('ale.keymap').vmap

vim.g.mapleader = " "

vmap { '<C-c>', '"+y', { noremap = true } } --yank to system clipboard
imap { '<C-v>', '<Esc>"+p', } --paste from system clipboard
nmap { '<C-s>', ':w<CR>', { noremap = true } } --save file
nmap { ',', ':nohl<CR>', { noremap = true } } --nohl

-- save and source nvim config 
nmap {
    '<Space>t',
    function ()
      vim.cmd[[ source $MYVIMRC ]]
    end,
}

nmap { '<S-j>', 'jjjjj' }
nmap { '<S-k>', 'kkkkk' }

vmap { 'q', '<gv' }
vmap { 'e', '>gv' }

-- Easier Moving between splits
nmap { '<C-J>', '<C-W><C-J>',  { noremap = true } }
nmap { '<C-K>', '<C-W><C-K>',  { noremap = true } }
nmap { '<C-L>', '<C-W><C-L>',  { noremap = true } }
nmap { '<C-H>', '<C-W><C-H>',  { noremap = true } }

--Easier Moving between tabs
nmap { '<C-r>', ':lua require("bufferline").cycle(1)<CR>',  { noremap = true } }
nmap { '<C-q>', ':lua require("bufferline").cycle(-1)<CR>',   { noremap = true } }
