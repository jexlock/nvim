local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- Nice fuzzy file finder
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            require("rose-pine").setup()
        end
    })

    use('EdenEast/nightfox.nvim')
    use('sainnhe/everforest')

    -- Syntax highlighting
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    -- File pin quick access
    use('ThePrimeagen/harpoon')
    -- Fancy undo
    use('mbbill/undotree')
    -- Go on git
    use('airblade/vim-gitgutter')
    use('tpope/vim-fugitive')
    -- Dev nice things
    use('nvim-lua/popup.nvim')
    use('tpope/vim-surround')
    use { 'nvim-tree/nvim-tree.lua', tag = 'nightly' }
    use('windwp/nvim-autopairs')

    -- Enable comment/uncomment blocks
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            { 'williamboman/mason.nvim' }, -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional
            { 'nvimtools/none-ls.nvim' },
            { 'WhoIsSethDaniel/mason-tool-installer.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' }, -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'hrsh7th/cmp-buffer' }, -- Optional
            { 'hrsh7th/cmp-path' }, -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' }, -- Optional
            { 'onsails/lspkind.nvim'},

            -- Snippets
            { 'L3MON4D3/LuaSnip' }, -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    }
    use ('nvim-tree/nvim-web-devicons')
    -- Status bar
    use ('nvim-lualine/lualine.nvim')

    -- Javascript/Typescript
    use('pangloss/vim-javascript')
    use('leafgarland/typescript-vim')
    use('maxmellon/vim-jsx-pretty')
    use('peitalin/vim-jsx-typescript')
    -- Writing Mode
    use('junegunn/goyo.vim')
    use('preservim/vim-pencil')


    -- Automatically set up your configuration after cloning packer.nvim
    if packer_bootstrap then
        require('packer').sync()
    end
end)
