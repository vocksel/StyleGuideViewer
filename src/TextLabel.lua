local Roact = require(script.Parent.Modules.Roact)
local Cryo = require(script.Parent.Modules.Cryo)
local styles = require(script.Parent.styles)
local StudioThemeAccessor = require(script.Parent.StudioThemeAccessor)

local function TextLabel(props)
    return StudioThemeAccessor.withTheme(function(theme)
        return Roact.createElement("TextLabel", Cryo.Dictionary.join({
            Font = styles.Font,
            Text = "",
            TextSize = styles.TextSize,
            TextColor3 = theme:GetColor(Enum.StudioStyleGuideColor.MainText),
            TextTruncate = Enum.TextTruncate.None,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            BackgroundTransparency = 1,
        }, props))
    end)
end

return TextLabel
