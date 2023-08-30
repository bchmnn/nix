{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      toggleterm-nvim
      nvim-tree-lua
      (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
      nvim-lspconfig
    ];
    extraPackages = with pkgs; [
      nil
      nixpkgs-fmt
    ];
    extraLuaConfig = ''
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- set termguicolors to enable highlight groups
      vim.opt.termguicolors = true

      local set = vim.opt
      set.tabstop = 2
      set.shiftwidth = 2
      set.softtabstop = 2
      set.expandtab = true
      -- needed for toggleterm
      set.hidden = true

      -- nvim-tree setup
      local nvimtree = require('nvim-tree')
      local nvimtreeapi = require('nvim-tree.api')
      local function nvimtree_on_attach(bufnr)
        local api = require "nvim-tree.api"

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        vim.keymap.set('n', '<C-t>', api.tree.toggle, {})
        vim.keymap.set('n', '?',     api.tree.toggle_help, opts('Help'))
      end
      nvimtree.setup({
        on_attach = nvimtree_on_attach,
      })
      vim.keymap.set('n', '<C-t>', nvimtreeapi.tree.toggle, {})

      -- telescope setup
      local telescope = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
      vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
      vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
      vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})

      -- toggleterm setup
      local toggleterm = require('toggleterm')
      toggleterm.setup{
        open_mapping = [[<c-\>]],
        hide_numbers = false,
        autochdir = true,
        direction = 'float',
        float_opts = {
          border = 'curved',
        },
      }

      -- nvim-treesitter
      local treesitter = require('nvim-treesitter.configs')
      treesitter.setup {
        indent = {
          enable = true
        },
        highlight = {
          enable = true
        },
      }

      -- nvim-lspconfig
      local lspconfig = require('lspconfig')
      lspconfig.nil_ls.setup {
        settings = {
          ['nil'] = {
            formatting = {
              command = { "nixpkgs-fmt" },
            },
          },
        },
      }

      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          -- vim.keymap.set('n', '<space>wl', function()
          --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          -- end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
    '';
  };
}
