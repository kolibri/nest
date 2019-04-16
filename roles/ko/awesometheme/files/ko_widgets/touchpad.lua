local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local awful     = require("awful")
awful.util     = require("awful.util")

local touchpad = {}
local function worker(args)
    local args = args or {}
    local widget = wibox.layout.fixed.horizontal()
    local interface = "Master"
    local icon = wibox.widget.imagebox()
    local icon_timer = timer({timeout = 5})
    local notification = nil

    local function get_touchpad_info()
        local is_on = false
        local input_row_fh = assert(io.popen(theme.touchpad_status_script))
        local touchpad_status = input_row_fh:read("*n")
        io.close(input_row_fh)
        
        if (1 == touchpad_status) then
            is_on = true
        end

        local info = {
            touchpad_on = is_on
        }

        return info
    end

    local function update_icon()
        local infos = get_touchpad_info()

        if (infos.touchpad_on) then
            touchpad_icon_file = theme.widget_touchpad_on
        else
            touchpad_icon_file = theme.widget_touchpad_off
        end
        icon:set_image(touchpad_icon_file)
    end

    update_icon()
    icon_timer:connect_signal("timeout", update_icon)
    icon_timer:start()
    widget:add(icon)

    widget:buttons (awful.util.table.join (
        awful.button ({}, 1, function()
            awful.util.spawn (theme.touchpad_toggle_script)
            update_icon()
        end)
    ))

    return widget
end

return setmetatable(touchpad, { __call = function(_, ...) return worker(...) end })