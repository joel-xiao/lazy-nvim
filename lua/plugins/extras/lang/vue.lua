return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "vue",
      root = { "vue.config.js" },
    })
  end,

  -- depends on the typescript extra
  { import = "lazyvim.plugins.extras.lang.typescript" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "vue", "css" } },
  },

  -- Add LSP servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vue_ls = {
          -- 确保 vue_ls 能找到 TypeScript 依赖
          init_options = {
            typescript = {
              serverPath = vim.fn.stdpath("data") .. "/lsp_servers/vtsls/node_modules/typescript/lib",
            },
          },
          -- 让 vue_ls 处理 Vue 文件的文档高亮
          on_attach = function(client, bufnr)
            if client.server_capabilities.documentHighlightProvider then
              local group = vim.api.nvim_create_augroup("vue_ls_highlight", { clear = true })
              vim.api.nvim_create_autocmd("CursorHold", {
                buffer = bufnr,
                group = group,
                callback = vim.lsp.buf.document_highlight,
              })
              vim.api.nvim_create_autocmd("CursorMoved", {
                buffer = bufnr,
                group = group,
                callback = vim.lsp.buf.clear_references,
              })
            end
          end,
        },
        vtsls = {
          -- 为 vtsls 添加 on_attach 隔离 Vue 文件
          on_attach = function(client, bufnr)
            -- 如果是 Vue 文件，禁用 vtsls 的文档高亮
            if vim.bo[bufnr].filetype == "vue" then
              client.server_capabilities.documentHighlightProvider = false
            end
          end,
        },
      },
    },
  },

  -- Configure tsserver plugin
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      table.insert(opts.servers.vtsls.filetypes, "vue")
      LazyVim.extend(opts.servers.vtsls, "settings.vtsls.tsserver.globalPlugins", {
        {
          name = "@vue/typescript-plugin",
          location = LazyVim.get_pkg_path("vue-language-server", "/node_modules/@vue/language-server"),
          languages = { "vue" },
          configNamespace = "typescript",
          enableForWorkspaceTypeScriptVersions = true,
        },
      })
    end,
  },
}
