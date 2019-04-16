local wibox         = require("wibox")
local gears         = require("gears")
local beautiful     = require("beautiful")
local naughty       = require("naughty")

local temperature_right = {}

local function worker(args)
	local widget = wibox.layout.fixed.vertical()
	local headline = wibox.widget.textbox('HDD')
	widget:add(headline)
	local table = wibox.layout.grid.vertical(4)
	widget:add(table)
	local icon_timer = timer({timeout = 5})


	local function update_table()
		local temp_max = 0
		local input_row_fh = assert(io.popen("df -h | grep 'dev/sda2' | sed -n 's/\\([a-zA-Z]*\\)  *\\([[:digit:]]*[A-Z]\\)  *\\([[:digit:]]*[A-Z]\\)  *\\([[:digit:]]*[A-Z]\\)  *\\([[:digit:]]*[\\%]\\).*/\\1:\\2:\\3:\\4:\\5/p'", "r"))
		table:reset()

		for line in input_row_fh:lines() do
			local splitted = gears.string.split(line, ':')
			local info_device = splitted[1]
			local info_size = splitted[2]
			local info_used = splitted[3]
			local info_available = splitted[4]
			local info_percent = splitted[5]

			local label = wibox.widget.textbox('sda2')
			label.forced_width = 51
			local size = wibox.widget.textbox('<span foreground="#e5e8e4"> ' .. info_used .. '</span>')
			size.forced_width = 51
			size.align = 'right'
			local used = wibox.widget.textbox(info_size)
			used.forced_width = 51
			used.align = 'right'
			local percent = wibox.widget.textbox('<span foreground="#e5e8e4"> ' .. info_percent .. '</span>')
			percent.forced_width = 51
			percent.align = 'right'

			table:add(label)
			table:add(size)
			table:add(used)
			table:add(percent)

		end
		io.close(input_row_fh)
	end

	update_table()
	icon_timer:connect_signal("timeout", update_table)
	icon_timer:start()

	return widget
end

return setmetatable(temperature_right, {__call = function(_,...) return worker(...) end})