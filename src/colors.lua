local t = require(script.Parent.Modules.t)

local colors = {}

local changeBrightnessCheck = t.tuple(t.Color3, t.integer)
local function changeBrightness(color, percent)
	assert(changeBrightnessCheck(color, percent))

	local h, s, v = Color3.toHSV(color)

    return Color3.fromHSV(h, s, math.clamp(v+(v*percent/100), 0, 1))
end

local brightenCheck = t.tuple(t.Color3, t.integer)
function colors.brighten(color, percent)
	assert(brightenCheck(color, percent))

    return changeBrightness(color, percent)
end

local darkenCheck = t.tuple(t.Color3, t.integer)
function colors.darken(color, percent)
	assert(darkenCheck(color, percent))

    return changeBrightness(color, -percent)
end

return colors
