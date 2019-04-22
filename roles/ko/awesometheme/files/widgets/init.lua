local module_path = (...):match ("(.+/)[^/]+$") or ""

package.loaded.widgets = nil

local widgets = {
    right = require(module_path .. "widgets.right")
}

return widgets