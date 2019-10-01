local Roact = require(script.Parent.Modules.Roact)
local Cryo = require(script.Parent.Modules.Cryo)
local styles = require(script.Parent.styles)
local TextLabel = require(script.Parent.TextLabel)

local function HeaderTextLabel(props)
    return Roact.createElement(TextLabel, Cryo.Dictionary.join({
        Font = styles.HeaderFont,
        TextSize = styles.HeaderTextSize,
    }, props))
end

return HeaderTextLabel
