local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local awful     = require("awful")
awful.util     = require("awful.util")

local screen_brightness = {}

local function worker(args)

	local widget = wibox.layout.fixed.horizontal()
	local icon = wibox.widget.imagebox()
	local icon_timer = timer({timeout = 5})

	local function update_icon()

		local input_row_fh = assert(io.popen("cat /sys/class/backlight/acpi_video0/brightness", "r"))
		local brightness = input_row_fh:read("*n")
		io.close(input_row_fh)

		if nil == brightness then
			icon:set_image(nil)
		else
			if brightness == 15 then 
				brightness_icon_file = beautiful.widget_screen_brightness_8
			elseif brightness >= 13 then
				brightness_icon_file = beautiful.widget_screen_brightness_7
			elseif brightness >= 11 then
				brightness_icon_file = beautiful.widget_screen_brightness_6
			elseif brightness >= 9 then
				brightness_icon_file = beautiful.widget_screen_brightness_5
			elseif brightness >= 7 then
				brightness_icon_file = beautiful.widget_screen_brightness_4
			elseif brightness >= 5 then
				brightness_icon_file = beautiful.widget_screen_brightness_3
			elseif brightness >= 3 then
				brightness_icon_file = beautiful.widget_screen_brightness_2
			elseif brightness >= 1 then
				brightness_icon_file = beautiful.widget_screen_brightness_1
			else 
				brightness_icon_file = beautiful.widget_screen_brightness_0
			end

			icon:set_image(brightness_icon_file)
		end
	end

    update_icon()
	icon_timer:connect_signal("timeout", update_icon)
	icon_timer:start()
	widget:add(icon)

	widget:buttons (awful.util.table.join (
	        awful.button ({}, 1, function()
	            awful.util.spawn ("sudo su - root -c 'tee /sys/class/backlight/acpi_video0/brightness <<< 15'")
	            update_icon()
	        end),
	        awful.button ({}, 3, function()
	            awful.util.spawn ("sudo su - root -c 'tee /sys/class/backlight/acpi_video0/brightness <<< 0'")
	            update_icon()
	        end)
	    ))

    return widget
end

return setmetatable(screen_brightness, {__call = function(_,...) return worker(...) end})