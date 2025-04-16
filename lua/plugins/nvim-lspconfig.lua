if true then return {} end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {

      servers = {
        -- Vue3 (Volar)
        volar = {
          init_options = {
            vue = {
              hybridMode = false,
            },
          },
        },

        -- HTML
        html = {
          filetypes = { "html" },
        },

        -- CSS/SCSS
        cssls = {
          filetypes = { "css", "scss" },
          settings = {
            css = {
              validate = true,
            },
            scss = {
              validate = true,
            },
          },
        },

        -- JavaScript/TypeScript
        tsserver = {
          root_dir = function()
            return vim.fn.getcwd()
          end,
          single_file_support = false,
          settings = {
            completions = {
              completeFunctionCalls = true,
            },
          },
        },

        -- Emmet 支持
        emmet_ls = {
          filetypes = { "html", "css", "scss" },
          init_options = {
            html = {
              options = {
                -- 对单标签使用自闭合标签
                ["bem.enabled"] = true,
              },
            },
          },
        },
      },
    },
  },
}
