local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local awful     = require("awful")
awful.util     = require("awful.util")

local launcher = {}

local function worker(args)

	local widget = wibox.layout.fixed.vertical()

	local function update_table(item)
		local widget = wibox.layout.fixed.horizontal()


		local label = wibox.widget.textbox('<span background="#773311"> ' .. item .. ' </span>')
		label.forced_width = 100
		label.forced_height = 70

		widget:add(label)

		widget:buttons (awful.util.table.join (
		        awful.button ({}, 1, function()
		            awful.util.spawn (item)
		        end)
		    ))
		return widget
	end

	widget:add(update_table('xterm'))
	widget:add(update_table('chromium'))
	widget:add(update_table('kodi'))


    return widget
end

return setmetatable(launcher, {__call = function(_,...) return worker(...) end})