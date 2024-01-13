return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, { "nil" })
    vim.list_extend(opts.ensure_installed, { "prisma-language-server" })
  end,
}
