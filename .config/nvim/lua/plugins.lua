
vim.cmd[[packadd packer.nvim]]
return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'

    --completion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-cmdline'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip' 

    --lsp's
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind-nvim'
    use 'nvim-lua/lsp-status.nvim'
    use 'nvim-lua/lsp_extensions.nvim'
    use 'j-hui/fidget.nvim'
    use {
        'ericpubu/lsp_codelens_extensions.nvim',
        requires = { 'mfussenegger/nvim-dap' },
        config = function()
            require('codelens_extensions').setup()
        end,
    }
    
    --TJ plugins
    use 'tjdevries/colorbuddy.nvim'
    use 'tjdevries/gruvbuddy.nvim'
    use 'tjdevries/express_line.nvim'
    
    -- Pretty colors
    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require 'colorizer'.setup()
        end,
        run = ':ColorizerToggle'
    }
    --XkbSwitch
    use {
        'lyokha/vim-xkbswitch',
        config = function()
          vim.g.XkbSwitchEnabled = 1
          vim.g.XkbSwitchIMappings = { 'ru' }
        end,
    }

    --fzf
    use { "junegunn/fzf", run = "./install --all" }
    use { "junegunn/fzf.vim" }
    --discord presence
    use 'andweeb/presence.nvim'

    use 'kyazdani42/nvim-web-devicons' 
    use 'kyazdani42/nvim-tree.lua'
    use 'akinsho/nvim-bufferline.lua'

    --rust
    use "simrat39/rust-tools.nvim"

    use "numToStr/Comment.nvim"

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
end)
