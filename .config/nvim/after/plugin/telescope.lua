local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

require('telescope').load_extension('media_files')
require('telescope').load_extension('file_browser')
require('telescope').load_extension('fzy_native')

local nmap = require('ale.keymap').nmap
local actions = require "telescope.actions"
local tele_utils = require "telescope.utils"
local action_state = require "telescope.actions.state"

local devicons = require"nvim-web-devicons"
local entry_display = require("telescope.pickers.entry_display")

local filter = vim.tbl_filter
local map = vim.tbl_map

telescope.setup {
  defaults = {

    prompt_prefix = "> ",
    selection_caret = "> ",

    path_display = { "smart" },
    selection_strategy = "reset",
    sorting_strategy = "descending",
    scroll_strategy = "cycle",
    color_devicons = true,
    layout_strategy = "horizontal",

    layout_config = {
      width = 0.95,
      height = 0.85,
      prompt_position = "top",

      horizontal = {
        preview_width = function(_, cols, _)
            if cols > 200 then
              return math.floor(cols * 0.4)
            else
              return math.floor(cols * 0.6)
            end
          end,
        },
      vertical = {
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },

      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
    },

    mappings = {
      i = {

      },

      n = {
        ["<esc>"] = actions.close,
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
      },
    },
  },
  pickers = {
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },
    file_browser = {
    },
  },
  history = {
      path = "~/.local/share/nvim/telescope_history",
      limit = 100,
  },
}


function gen_from_buffer_like_leaderf(opts)
  opts = opts or {}
  local default_icons, _ = devicons.get_icon("file", "", {default = true})

  local bufnrs = filter(function(b)
    return 1 == vim.fn.buflisted(b)
  end, vim.api.nvim_list_bufs())

  local max_bufnr = math.max(unpack(bufnrs))
  local bufnr_width = #tostring(max_bufnr)

  local max_bufname = math.max(
    unpack(
      map(function(bufnr)
        return vim.fn.strdisplaywidth(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p:t"))
      end, bufnrs)
    )
  )

  local displayer = entry_display.create {
    separator = " ",
    items = {
      { width = bufnr_width },
      { width = 4 },
      { width = vim.fn.strwidth(default_icons) },
      { width = max_bufname },
      { remaining = true },
    },
  }

  local make_display = function(entry)
    return displayer {
      {entry.bufnr, "TelescopeResultsNumber"},
      {entry.indicator, "TelescopeResultsComment"},
      {entry.devicons, entry.devicons_highlight},
      entry.file_name,
      {entry.dir_name, "Comment"}
    }
  end

  return function(entry)
    local bufname = entry.info.name ~= "" and entry.info.name or "[No Name]"
    local hidden = entry.info.hidden == 1 and "h" or "a"
    local readonly = vim.api.nvim_buf_get_option(entry.bufnr, "readonly") and "=" or " "
    local changed = entry.info.changed == 1 and "+" or " "
    local indicator = entry.flag .. hidden .. readonly .. changed

    local dir_name = vim.fn.fnamemodify(bufname, ":p:h")
    local file_name = vim.fn.fnamemodify(bufname, ":p:t")

    local icons, highlight = devicons.get_icon(bufname, string.match(bufname, "%a+$"), { default = true })

    return {
      valid = true,

      value = bufname,
      ordinal = entry.bufnr .. " : " .. file_name,
      display = make_display,

      bufnr = entry.bufnr,

      lnum = entry.info.lnum ~= 0 and entry.info.lnum or 1,
      indicator = indicator,
      devicons = icons,
      devicons_highlight = highlight,

      file_name = file_name,
      dir_name = dir_name,
    }
  end
end


--mappings telescope
nmap { "ff",
  function()
    local opts = {
      sorting_strategy = "ascending",
      scroll_strategy = "cycle",
      layout_config = {
          width = 0.9,
          height = 0.8,

          horizontal = {
            width = { padding = 0.15 },
          },
          vertical = {
            preview_height = 0.75,
          },
      },
      attach_mappings = function(prompt_bufnr, map)
        local current_picker = action_state.get_current_picker(prompt_bufnr)

        local modify_cwd = function(new_cwd)
          local finder = current_picker.finder

          finder.path = new_cwd
          finder.files = true
          current_picker:refresh(false, { reset_prompt = true })
        end

        map("i", "-", function()
          modify_cwd(current_picker.cwd .. "/..")
        end)

        map("i", "~", function()
          modify_cwd(vim.fn.expand "~")
        end)

        map("n", "yy", function()
          local entry = action_state.get_selected_entry()
          vim.fn.setreg("+", entry.value)
        end)

        return true
      end,
    }
    require("telescope").extensions.file_browser.file_browser(opts)
  end
}

nmap { "fo",
  function()
    local opts = {
      layout_config = {
          width = 0.9,
          height = 0.8,

          horizontal = {
            width = { padding = 0.15 },
          },
          vertical = {
            preview_height = 0.75,
          },
      },
      find_command = { "rg", "--no-ignore", "--files" },
    }
    require("telescope.builtin").find_files(opts)
  end
}

nmap { "fg","<cmd>lua require('telescope.builtin').live_grep()<cr>" }
nmap { "fb",
  function()
        local opts = {}
        opts.attach_mappings = function(prompt_bufnr,map)
          local delete_buf = function()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            vim.api.nvim_buf_delete(selection.bufnr, { force = true })
          end
          map('n','d', delete_buf)
        return true
        end
        opts.entry_maker = gen_from_buffer_like_leaderf(opts)
        -- opts.layout_config = {
        --   width = 0.9,
        --   height = 0.8,
        --
        --   horizontal = {
        --     width = { padding = 0.15 },
        --   },
        --   vertical = {
        --     preview_height = 0.75,
        --   },
        -- }
   require('telescope.builtin').buffers(opts)
  end
}
nmap { "fh","<cmd>lua require('telescope.builtin').help_tags()<cr>" }

--edit nvim
nmap { "<space>ev",
  function() 
    local opts = {
      cwd = '~/.config/nvim/',
      prompt_title = "nvim",
      shorten_path = false,
      layout_strategy = "flex",

      layout_config = {
        width = 0.9,
        height = 0.8,

        horizontal = {
          width = { padding = 0.15 },
        },
        vertical = {
          preview_height = 0.75,
        },
      },
    }
   require('telescope.builtin').find_files(opts)
  end
}

nmap { "<space>df",
  function() 
    local opts = {
      cwd = '~/.config/',

      prompt_title = "dotfiles",
      shorten_path = false,
      layout_strategy = "flex",

      layout_config = {
        width = 0.9,
        height = 0.8,

        horizontal = {
          width = { padding = 0.15 },
        },
        vertical = {
          preview_height = 0.75,
        },
      },
    }
   require('telescope.builtin').find_files(opts)
  end
}

