-- white from bg: #e5e8e4
-- black from bg: #000000

theme                               = {}

themes_dir                          = os.getenv("HOME") .. "/.config/awesome/theme"
theme.font                          = "DejaVu Sans Mono 8"
theme.fg_normal                     = "#000000"
theme.fg_focus                      = "#F0DFAF"
theme.fg_urgent                     = "#CC9393"
theme.bg_normal                     = "#e5e8e4"
theme.bg_focus                      = "#313131"
theme.bg_urgent                     = "#FFFFFF"
theme.border_width                  = "1"
theme.border_normal                 = "#3F3F3F"
theme.border_focus                  = "#7F7F7F"
theme.border_marked                 = "#CC9393"
theme.titlebar_bg_focus             = "#000000"
theme.titlebar_bg_normal            = "#000000"
theme.taglist_fg_focus              = "#000000"
theme.tasklist_bg_focus             = "#FFFFFF"
theme.tasklist_fg_focus             = "#000000"
theme.textbox_widget_margin_top     = 1
theme.notify_fg                     = theme.fg_normal
theme.notify_bg                     = theme.bg_normal
theme.notify_border                 = theme.border_focus

theme.awful_widget_height           = 14
theme.awful_widget_margin_top       = 2
theme.mouse_finder_color            = "#CC9393"
theme.menu_height                   = "16"
theme.menu_width                    = "140"

theme.wallpaper                     = themes_dir .. "/ko_bg.png" 

-- layout icons
theme.ko_icon	     				= themes_dir .. "/icons/_ko.png"
theme.tag = themes_dir .. "/icons/_tag.png"

theme.layout_fairh                  = themes_dir .. "/icons/_fairh.png"
theme.layout_fairv                  = themes_dir .. "/icons/_fairv.png"
theme.layout_floating               = themes_dir .. "/icons/_floating.png"
theme.layout_max                    = themes_dir .. "/icons/_max.png"
theme.layout_tile                   = themes_dir .. "/icons/_tile.png"
theme.layout_tilebottom             = themes_dir .. "/icons/_tilebottom.png"
theme.layout_spiral                 = themes_dir .. "/icons/_spiral.png"
theme.layout_dwindle                = themes_dir .. "/icons/_spiraldwindle.png"

-- widget icons
theme.widget_ac                     = themes_dir .. "/icons/ac.png"
theme.widget_battery                = themes_dir .. "/icons/battery.png"
theme.widget_battery_low            = themes_dir .. "/icons/battery_low.png"
theme.widget_battery_empty          = themes_dir .. "/icons/battery_empty.png"
theme.widget_battery_0              = themes_dir .. "/icons/bat_0.png"
theme.widget_battery_20             = themes_dir .. "/icons/bat_20.png"
theme.widget_battery_40             = themes_dir .. "/icons/bat_40.png"
theme.widget_battery_60             = themes_dir .. "/icons/bat_60.png"
theme.widget_battery_80             = themes_dir .. "/icons/bat_80.png"
theme.widget_battery_100            = themes_dir .. "/icons/bat_100.png"
theme.widget_mem                    = themes_dir .. "/icons/mem.png"
theme.widget_cpu                    = themes_dir .. "/icons/cpu.png"
theme.widget_temp                   = themes_dir .. "/icons/temp.png"
theme.widget_net                    = themes_dir .. "/icons/net.png"
theme.widget_hdd                    = themes_dir .. "/icons/hdd.png"
theme.widget_vol                    = themes_dir .. "/icons/vol.png"
theme.widget_vol_low                = themes_dir .. "/icons/vol_low.png"
theme.widget_vol_no                 = themes_dir .. "/icons/vol_no.png"
theme.widget_vol_33                 = themes_dir .. "/icons/vol_33.png"
theme.widget_vol_66                 = themes_dir .. "/icons/vol_66.png"
theme.widget_vol_100                = themes_dir .. "/icons/vol_100.png"
theme.widget_vol_mute               = themes_dir .. "/icons/vol_mute.png"
theme.widget_mail                   = themes_dir .. "/icons/mail.png"
theme.widget_touchpad_on            = themes_dir .. "/icons/touchpad_on.png"
theme.widget_touchpad_off           = themes_dir .. "/icons/touchpad_off.png"
theme.widget_screen_brightness_0    = themes_dir .. "/icons/screen_brightness_0.png"
theme.widget_screen_brightness_1    = themes_dir .. "/icons/screen_brightness_1.png"
theme.widget_screen_brightness_2    = themes_dir .. "/icons/screen_brightness_2.png"
theme.widget_screen_brightness_3    = themes_dir .. "/icons/screen_brightness_3.png"
theme.widget_screen_brightness_4    = themes_dir .. "/icons/screen_brightness_4.png"
theme.widget_screen_brightness_5    = themes_dir .. "/icons/screen_brightness_5.png"
theme.widget_screen_brightness_6    = themes_dir .. "/icons/screen_brightness_6.png"
theme.widget_screen_brightness_7    = themes_dir .. "/icons/screen_brightness_7.png"
theme.widget_screen_brightness_8    = themes_dir .. "/icons/screen_brightness_8.png"

theme.tasklist_disable_icon         = true
theme.tasklist_floating             = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

theme.touchpad_status_script = "/usr/local/bin/touchpad_status.sh"
theme.touchpad_toggle_script = "/usr/local/bin/touchpad_toggle.sh"

return theme
