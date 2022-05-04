rust_tools = require"rust-tools"
local lsp = require "ale.lsp"
rust_tools.setup {
        tools = { -- rust-tools options
          autoSetHints = true,

          hover_with_actions = true,

          runnables = {
            use_telescope = true,
          },

          debuggables = {
            use_telescope = true,
          },
          inlay_hints = {
            only_current_line = false,
            only_current_line_autocmd = "CursorHold",
            show_parameter_hints = true,
            parameter_hints_prefix = "<-",
            other_hints_prefix = "->",
            highlight = "Comment",
          },

          hover_actions = {
            border = {
              { "╭", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╮", "FloatBorder" },
              { "│", "FloatBorder" },
              { "╯", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╰", "FloatBorder" },
              { "│", "FloatBorder" },
            },
            auto_focus = false,
          },
        },

    server = {
      on_attach = lsp.on_attach,
      on_init = lsp.on_init,
      capabilities = lsp.capabilities,

      flags = {
        debounce_text_changes = false,
      },
      settings = {
        ["rust-analyzer"] = {
          assist = {
            importGranularity = "last",
            importPrefix = "by_self",
          },
          cargo = {
            loadOutDirsFromCheck = true,
          },
          procMacro = {
            enable = true,
          },
        },
      },
    },
}
