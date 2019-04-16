local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")

local temperature = {}

local function worker(args)
	local widget = wibox.layout.fixed.horizontal()
	local icon_timer = timer({timeout = 5})


	local function update_icon()
		local temp_max = 0
		local input_row_fh = assert(io.popen("sensors", "r"))
		for line in input_row_fh:lines() do
			local temp_value = tonumber(string.match(line, "%+([%d%.]*)°C.*%(high.*%)") or 0) -- todo: make weak matching stronger

			if temp_value > temp_max then
				temp_max = temp_value
			end
		end
		io.close(input_row_fh)

		widget:reset()

		local text = wibox.widget.textbox(temp_max)
		widget:add(text)

		--local icon = wibox.widget.imagebox(beautiful.widget_ac) -- todo: add icon
			--widget:add(icon)
	end

	update_icon()
	icon_timer:connect_signal("timeout", update_icon)
	icon_timer:start()



	local function create_message()
		local input_row_fh = assert(io.popen("sensors", "r"))
		msg = input_row_fh:read("*a")

		--msg = 
		    --"<span font_desc=\""..beautiful.font.."\">"..
		    --"┌[".."interface".."]\n"..
		    --"├Current:\t".."(infos.value)".."%\n"..
		    --"└Muted:\t\t".."Yes".."\n"..
		    --"</span>"
	   return msg
	end

	function widget:show(t_out)
		widget:hide()

		msg = create_message()

		notification = naughty.notify({
			preset = fs_notification_preset,
			text = msg,
			timeout = t_out
		})
	end

	function widget:hide()
		if notification ~= nil then
			naughty.destroy(notification)
			notification = nil
		end
	end

	--widget:add(icon)
	widget:connect_signal('mouse::enter', function () widget:show(0) end)
	widget:connect_signal('mouse::leave', function () widget:hide() end)



	return widget

end

return setmetatable(temperature, {__call = function(_,...) return worker(...) end})