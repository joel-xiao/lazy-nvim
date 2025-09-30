return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Volar 用于 Vue 文件
        volar = {
          filetypes = { "vue" },
          init_options = {
            vue = { hybridMode = true }, -- 必须开启，处理 template + script
          },
          on_attach = function(client, bufnr)
            -- 高亮光标下符号
            if client.server_capabilities.documentHighlightProvider then
              local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
              vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
              vim.api.nvim_create_autocmd({ "CursorHold" }, {
                group = group,
                buffer = bufnr,
                callback = vim.lsp.buf.document_highlight,
              })
              vim.api.nvim_create_autocmd({ "CursorMoved" }, {
                group = group,
                buffer = bufnr,
                callback = vim.lsp.buf.clear_references,
              })
            end
          end,
        },

        -- vtsls 用于 TS/JS 文件
        vtsls = {
          filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
          init_options = {
            hostInfo = "neovim",
          },
          settings = {
            vtsls = {
              autoUseWorkspaceTsdk = true,
              enableMoveToFileCodeAction = true,
            },
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = { completeFunctionCalls = true },
            },
            javascript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = { completeFunctionCalls = true },
            },
          },
          on_attach = function(client, bufnr)
            -- 高亮光标下符号
            if client.server_capabilities.documentHighlightProvider then
              local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
              vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
              vim.api.nvim_create_autocmd({ "CursorHold" }, {
                group = group,
                buffer = bufnr,
                callback = vim.lsp.buf.document_highlight,
              })
              vim.api.nvim_create_autocmd({ "CursorMoved" }, {
                group = group,
                buffer = bufnr,
                callback = vim.lsp.buf.clear_references,
              })
            end
          end,
        },
      },
    },
  },
}
