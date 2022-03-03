local ls = require "luasnip"
local types = require "luasnip.util.types"
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local c = ls.choice_node
local t = ls.text_node
local i = ls.insert_node

ls.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { "<-", "Error" } },
          },
        },
    },
}


ls.snippets = {
    rust = {
        s("struct", fmt(
            [[
            #[derive(Debug, Clone, PartialEq,)] 
            struct {name} {{
                {insert}
            }}
            ]],
            {   
                name = i(1,"name"),
                insert = i(0)
            }
            )
        ),
        s("enum", fmt(
            [[
            #[derive(Debug,Clone, PartialEq)] 
            enum {name} {{
                {insert}
            }}
            ]], 
            {
               name = i(1),
                insert = i(0)
            }
            )
        ),
        s("trait", fmt(
            [[
            trait {name} {{
                {insert}
            }}
            ]],
            {
                name = i(1,"name"),
                insert = i(0)
            }
            )
        ),
        s("f", fmt(
            [[
            fn {name}({args}) {{
                {insert}
            }}

            ]],
            {
                name = i(1),
                args = i(2),
                insert = i(0),
            }
            )
        ),
        s("rf", fmt(
            [[
            fn {name}({args}) -> {_type} {{
                {insert}
            }}
            ]],
            {
                name = i(1),
                args = i(2),
                _type = i(3,"type"),
                insert = i(0),
            }
            )
        ),
        s("pr", fmt(
            [[
            println!("{inner}", {args});
            ]],
            {
                inner = i(1),
                args = i(0),
            }
            )
        )
    },
}

--source snippets
vim.keymap.set("n", "<S-m>", ":source ~/.config/nvim/after/plugin/luasnip.lua<CR>")

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set("i", "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)
