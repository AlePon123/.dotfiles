local ls = require "luasnip"
local types = require "luasnip.util.types"
local s = ls.s
local sn = ls.sn
local fmt = require("luasnip.extras.fmt").fmt
local c = ls.choice_node
local d = ls.dynamic_node
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


ls.add_snippets (nil, {
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
            fn {name}({args}){_return} {{
                {insert}
            }}
            ]],
            {
                name = i(1, "name"),
                args = i(2),
                _return = c(3, {
                   t"",
                   {t" -> ", i(1)},
                }),
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
})

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
