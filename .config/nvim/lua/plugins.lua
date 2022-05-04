vim.cmd[[packadd packer.nvim]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use { 'lewis6991/impatient.nvim',
        config = function()
          require('impatient')
        end
    }
    --colorscheme 
    use 'morhetz/gruvbox'
    use 'nvim-lua/plenary.nvim'

    --completions
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-cmdline'
    use { 'tzachar/cmp-tabnine', run='./install.sh' }
    use "lukas-reineke/cmp-under-comparator"
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
    use 'tjdevries/cyclist.vim'

    --Dap
    use 'mfussenegger/nvim-dap'
    use "rcarriga/nvim-dap-ui"
    use "theHamsta/nvim-dap-virtual-text"
    use "nvim-telescope/telescope-dap.nvim"

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

    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-media-files.nvim'
    use "nvim-telescope/telescope-file-browser.nvim" 
    use "nvim-telescope/telescope-fzy-native.nvim"
  

    --fzf
    use { "junegunn/fzf", run='./install.sh' }
    use { "junegunn/fzf.vim" }

    --discord presence
    use 'andweeb/presence.nvim'

    use 'kyazdani42/nvim-web-devicons' 

    use 'akinsho/nvim-bufferline.lua'

    --rust
    use 'simrat39/rust-tools.nvim'
    use 'rust-lang/rust.vim'

    --GIT
    use 'TimUntersberger/neogit'
    use 'sindrets/diffview.nvim'
    use "tamago324/lir-git-status.nvim"

    --comment
    use "numToStr/Comment.nvim"

    --treesitter stuf   
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use "nvim-treesitter/playground"

    use "haringsrob/nvim_context_vt"
end)
