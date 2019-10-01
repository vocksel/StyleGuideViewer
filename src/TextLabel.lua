local Roact = require(script.Parent.Modules.Roact)
local Cryo = require(script.Parent.Modules.Cryo)
local StudioThemeAccessor = require(script.Parent.StudioThemeAccessor)

local function TextLabel(props)
    return StudioThemeAccessor.withTheme(function(theme)
        return Roact.createElement("TextLabel", Cryo.Dictionary.join({
            BackgroundTransparency = 1,

            Font = Enum.Font.Gotham,
            Text = "",
            TextSize = 16,
            TextColor3 = theme:GetColor(Enum.StudioStyleGuideColor.MainText),
            TextTruncate = Enum.TextTruncate.None,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
        }, props))
    end)
end

return TextLabel
