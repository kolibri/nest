local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")

local battery = {}

local function worker(args)

	local widget = wibox.layout.fixed.horizontal()
	local icon = wibox.widget.imagebox()
	local icon_timer = timer({timeout = 5})
	local notification = nil
	local hasBattery = False

	local function update_icon()

		local input_row_fh = assert(io.popen("acpi -b | sed -n 's/^\\(.*\\) \\([0-9]\\{1,3\\}\\)%\\(.*\\)$/\\2/p'", "r"))
		local loading_state = input_row_fh:read("*n")
		io.close(input_row_fh)
--		bat_icon_file = beautiful.widget_battery_0

		if nil == loading_state then
			icon:set_image(nil)
		else
			hasBattery = True
			if loading_state == 100 then 
				bat_icon_file = beautiful.widget_battery_100
			elseif loading_state >= 80 then
				bat_icon_file = beautiful.widget_battery_80
			elseif loading_state >= 60 then
				bat_icon_file = beautiful.widget_battery_60
			elseif loading_state >= 40 then
				bat_icon_file = beautiful.widget_battery_40
			elseif loading_state >= 20 then
				bat_icon_file = beautiful.widget_battery_20
			else 
				bat_icon_file = beautiful.widget_battery_0
			end
			icon:set_image(bat_icon_file)
		end
	end

	local function get_battery_infos()
		local bat_infos = {}
		--Battery 0: Full, 100%
		--Battery 0: Charging, 100%, 00:31:40 until charged
		--Battery 0: Discharging, 73%, 00:55:11 remaining

		local input_row_handle_1 = assert(io.popen("acpi -bi | sed -n '1p'", "r"))
		local input_row_1 = input_row_handle_1:read("*l")
		io.close(input_row_handle_1)
		--if nil ~= input_row_1 then
			local loading_state   = string.match(input_row_1, "Battery %d: (.+), %d?%d?%d%%")
			local current_percent = string.match(input_row_1, ", (.+)%%")
			local remaining       = string.match(input_row_1, "%, (%d%d:%d%d:%d%d) ")
		--end 
		-- Battery 0: design capacity 3776 mAh, last full capacity 2936 mAh = 77%
		local input_row_handle_2 = assert(io.popen("acpi -bi | sed -n '2p'", "r"))
		local input_row_2 = input_row_handle_2:read("*l")
		io.close(input_row_handle_2)
		--if nil ~= input_row_2 then
			local abs_full    = string.match(input_row_2, "design capacity (.*) mAh,")
			local abs_current = string.match(input_row_2, "last full capacity (.*) mAh")
			local abs_percent = string.match(input_row_2, "mAh = (.*)%%")
		--end

		bat_infos.loading_state   = loading_state or "N/A"
		bat_infos.current_percent = current_percent or "N/A"
		bat_infos.remaining       = remaining or "N/A"
		bat_infos.abs_full        = abs_full or "N/A"
		bat_infos.abs_current     = abs_current or "N/A"
		bat_infos.abs_percent     = abs_percent or "N/A"


		return bat_infos
end

local function create_message(infos)
	msg =
	"<span font_desc=\""..beautiful.font.."\">"..
	"┌[Battery]\n"..
	"├Current:\t"..infos.current_percent.."%\n"..
	"├State:\t\t"..infos.loading_state.."\n"..
	"├Remaining\t"..infos.remaining.."\n"..
	"└Abs. Capacity:\t"..infos.abs_current.."/"..infos.abs_full.."mAh"..
	" ("..infos.abs_percent.."%)"..
	"</span>"

	return msg
end

function widget:show(t_out)
	widget:hide()

	msg = create_message(get_battery_infos())

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

if True == hasBattery then 
	widget:add(icon)
	widget:connect_signal('mouse::enter', function () widget:show(0) end)
	widget:connect_signal('mouse::leave', function () widget:hide() end)
end
return widget

end

return setmetatable(battery, {__call = function(_,...) return worker(...) end})