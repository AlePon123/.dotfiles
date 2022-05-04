local opt = vim.opt

opt.pumblend = 17
opt.wildmode = "longest:full"
opt.wildoptions = "pum"

opt.updatetime = 300
opt.termguicolors = true
opt.showmode = false
opt.showcmd = true
opt.cmdheight = 1 
opt.incsearch = true 
opt.showmatch = true 
opt.relativenumber = true 
opt.number = true 
opt.ignorecase = true 
opt.smartcase = true 
opt.hidden = true 
opt.cursorline = true 
opt.equalalways = false 
opt.splitright = true 
opt.splitbelow = true
opt.updatetime = 300
opt.hlsearch = true 
opt.scrolloff = 10 

-- Tabs
opt.autoindent = true
opt.cindent = true
opt.wrap = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.breakindent = true
opt.showbreak = string.rep(" ", 3) 
opt.linebreak = true

opt.foldmethod = "marker"
opt.foldlevel = 0
opt.modelines = 1

opt.belloff = "all" 

opt.clipboard = "unnamedplus"

opt.inccommand = "split"
opt.swapfile = false 
opt.shada = { "!", "'1000", "<50", "s10", "h" }

opt.mouse = "n"
opt.formatoptions = opt.formatoptions
  - "a" 
  - "t" 
  + "c" 
  + "q" 
  - "o" 
  + "r" 
  + "n" 
  + "j" 
  - "2" 

opt.joinspaces = false 

opt.fillchars = { eob = "~" }
