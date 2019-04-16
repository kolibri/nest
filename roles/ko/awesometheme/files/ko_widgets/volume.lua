local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")



local volume = {}
local function worker(args)
	local args = args or {}

	local widget = wibox.layout.fixed.horizontal()
	local interface = "Master"
	local icon = wibox.widget.imagebox()
	local icon_timer = timer({timeout = 5})
	local notification = nil

	local function get_volume_info()
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

	local function update_icon()
		-- @todo: move this out of this function
		local infos = get_volume_info()

		vol_icon_file = beautiful.widget_vol_mute

		if (false == infos.muted and nil ~= infos.value) then 
			if infos.value == 100 then 
				vol_icon_file = beautiful.widget_vol_100
			elseif infos.value >= 66 then
				vol_icon_file = beautiful.widget_vol_66
			elseif infos.value >= 33 then
				vol_icon_file = beautiful.widget_vol_33
			else 
				vol_icon_file = beautiful.vol_mute
			end
		end
		icon:set_image(vol_icon_file)
	end

	local function create_message(infos)
		msg =
		    "<span font_desc=\""..beautiful.font.."\">"..
		    "┌["..interface.."]\n"..
		    "├Current:\t"..(infos.value or "n/a").."%\n"..
		    "└Muted:\t\t"..(infos.muted and "Yes" or "No").."\n"..
		    "</span>"
	   return msg
	end

	function widget:show(t_out)
		widget:hide()

		msg = create_message(get_volume_info())

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

	update_icon()
	icon_timer:connect_signal("timeout", update_icon)
	icon_timer:start()

	widget:add(icon)
	widget:connect_signal('mouse::enter', function () widget:show(0) end)
	widget:connect_signal('mouse::leave', function () widget:hide() end)

	return widget
end

return setmetatable(volume, { __call = function(_, ...) return worker(...) end })