
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use 'tjdevries/nlua.nvim'

    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'

    --completions & lsp's
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'onsails/lspkind-nvim'
    use 'nvim-lua/lsp-status.nvim'
    use 'nvim-lua/lsp_extensions.nvim'
    use {
          "ericpubu/lsp_codelens_extensions.nvim",
          requires = { 'mfussenegger/nvim-dap' },
          config = function()
            require("codelens_extensions").setup()
          end,
    }

    --snipets 
    use 'L3MON4D3/LuaSnip'

    --colors
    use 'tjdevries/colorbuddy.nvim'
    use 'tjdevries/gruvbuddy.nvim'

    --rust
    use "simrat39/rust-tools.nvim"

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
end)
