if not pcall(require, "colorbuddy") then
  return
end

require("colorbuddy").colorscheme "gruvbox"
require("colorizer").setup()

local c = require("colorbuddy.color").colors
local Group = require("colorbuddy.group").Group
local g = require("colorbuddy.group").groups
local s = require("colorbuddy.style").styles
local Color = require("colorbuddy").Color
Color.new('diagnostic_red','#ff0000')
Group.new("DiagnosticVirtualTextError", c.diagnostic_red, nil, s.bold)
Group.new("DiagnosticSignError", c.Diagnostic_red, nil, s.bold)
Group.new("DiagnosticFloatingError", c.Diagnostic_red,nil,nil)

Group.new("StatuslineError1", c.red:light():light(), g.Statusline)
Group.new("StatuslineError2", c.red:light(), g.Statusline)
Group.new("StatuslineError3", c.red, g.Statusline)
Group.new("StatuslineError3", c.red:dark(), g.Statusline)
Group.new("StatuslineError3", c.red:dark():dark(), g.Statusline)
