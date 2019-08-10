local wibox         = require("wibox")
local gears         = require("gears")
local beautiful     = require("beautiful")
local naughty       = require("naughty")

local temperature_right = {}

local function worker(args)
	local widget = wibox.layout.fixed.vertical()
	local headline = wibox.widget.textbox('Temps')
	widget:add(headline)
	local table = wibox.layout.grid.vertical(3)
	widget:add(table)
	local icon_timer = timer({timeout = 5})


	local function update_table()
		local temp_max = 0
		local input_row_fh = assert(io.popen("sensors | grep '°C' | sed -n 's/\\([a-zA-Z]\\{4\\}\\).*\\(.\\): *+\\([[:digit:]]*\\.[[:digit:]]*\\).*/\\1\\2:\\3/p'", "r"))
		table:reset()

		for line in input_row_fh:lines() do
			local splitted = gears.string.split(line, ':')
			local device = splitted[1]
			local temp = tonumber(splitted[2])

			local alert = ''
			if temp > 60 then
				alert = ' hot'
			end
			local dtext = wibox.widget.textbox(device)
			dtext.forced_width = 51
			local ttext = wibox.widget.textbox('<span foreground="#e5e8e4"> ' .. temp .. '</span>')
			ttext.forced_width = 51
			local atext = wibox.widget.textbox(alert)
			atext.forced_width = 51

			table:add(dtext)
			table:add(ttext)
			table:add(atext)

		end
		io.close(input_row_fh)
	end

	update_table()
	icon_timer:connect_signal("timeout", update_table)
	icon_timer:start()

	return widget
end

return setmetatable(temperature_right, {__call = function(_,...) return worker(...) end})