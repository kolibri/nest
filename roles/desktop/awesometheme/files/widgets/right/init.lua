local module_path = (...):match ("(.+/)[^/]+$") or ""

package.loaded.right = nil

local right = {
    cpu         = require(module_path .. "widgets.right.cpu"),
    hdd         = require(module_path .. "widgets.right.hdd"),
    launcher    = require(module_path .. "widgets.right.launcher"),
    temperature = require(module_path .. "widgets.right.temperature"),
    volume      = require(module_path .. "widgets.right.volume")
}

return right