local wibox         = require("wibox")
local beautiful     = require("beautiful")

local acplug = {}

local function worker(args)
	local widget = wibox.layout.fixed.horizontal()
	local icon_timer = timer({timeout = 5})

	local function update_icon()
		local input_row_fh = assert(io.popen("acpi -a", "r"))
		local input_row = input_row_fh:read("*l")
		io.close(input_row_fh)
		local acplug_state = string.match(input_row, "Adapter %d: (.*)") or "N/A"

		widget:reset()
		if "on-line" == acplug_state then 
			local icon = wibox.widget.imagebox(beautiful.widget_ac)
			widget:add(icon)
		end
	end

	update_icon()
	icon_timer:connect_signal("timeout", update_icon)
	icon_timer:start()

	return widget

end

return setmetatable(acplug, {__call = function(_,...) return worker(...) end})