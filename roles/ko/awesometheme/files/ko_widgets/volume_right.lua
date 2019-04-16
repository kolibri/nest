local wibox         = require("wibox")
local gears         = require("gears")
local beautiful     = require("beautiful")
local naughty       = require("naughty")

local volume_right = {}

local function worker(args)

	local widget = wibox.layout.fixed.vertical()
	local headline = wibox.widget.textbox('Vol')
	widget:add(headline)
	local table = wibox.layout.grid.vertical(3)
	widget:add(table)

	local icon_timer = timer({timeout = 1})
	local function get_volume_info()
		local interface = 'Master'

		-- hacky way to get stereo channels volume percent ( read only 6'th line)
		local input_row_fh = assert(io.popen("amixer sget "..interface.." | sed -n '5s/^\\(.*\\)\\[\\([0-9]\\{1,3\\}\\)%\\(.*\\)$/\\2/p'", "r"))
		local value = input_row_fh:read("*n")
		io.close(input_row_fh)

		local input_row_fh = assert(io.popen("amixer sget "..interface.." | sed -n '5s/^\\(.*\\)\\[\\(on\\|off\\)\\]\\(.*\\)$/\\2/p'", "r"))
		local muted = true
		if "on" == input_row_fh:read("*l") then
			muted = false
		end
		io.close(input_row_fh)
		
		local info = {
			value = value,
			muted = muted
		}

		return info
	end


	local function update_table()
		local infos = get_volume_info()
		table:reset()

		local label = wibox.widget.textbox("mastr")
		label.forced_width = 51
		local value = wibox.widget.textbox('<span foreground="#e5e8e4"> ' .. infos.value .. '</span>')
		value.forced_width = 51

		local mutedVal = ''
		if infos.muted then 
			mutedVal = 'muted' 
		 end

		local muted = wibox.widget.textbox(mutedVal)
		muted.forced_width = 51

		table:add(label)
		table:add(value)
		table:add(muted)

	end

	update_table()
	icon_timer:connect_signal("timeout", update_table)
	icon_timer:start()

	return widget
end

return setmetatable(volume_right, {__call = function(_,...) return worker(...) end})