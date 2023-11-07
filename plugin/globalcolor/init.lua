os.execute("mkdir -p " .. vim.fn.stdpath('state') .. "/plugin")

local globalcolor = {}

-- TODO this filename should be configurable
local color_file = vim.fn.stdpath('state') .. '/plugin/globalcolor'
local color_set = vim.api.nvim_create_augroup('globalcolor', {
	clear = true,
})
vim.api.nvim_create_autocmd('ColorScheme', {
	group = color_set,
	callback = function(ev)
		local file = io.open(color_file, 'w')
		if not file then
			-- TODO this should be configurable
			print("colorscheme " .. ev.match .. " failed to save")
			return
		end

		file:write(ev.match)
		file:close()
		-- TODO this should be an error loglevel
		print("colorscheme " .. ev.match .. " saved")
	end
})

-- TODO make this a global function that can be bound
local file = io.open(color_file, 'r')
if not file then return end
local color = file:read("*a")
if not color then return end
-- TODO default color option
-- TODO lazy integration option (lazy load everything except selected color)
vim.cmd.colorscheme(color)

return globalcolor
