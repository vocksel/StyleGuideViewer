local Roact = require(script.Parent.Modules.Roact)
local t = require(script.Parent.Modules.t)
local colors = require(script.Parent.colors)
local TextLabel = require(script.Parent.TextLabel)
local StudioThemeAccessor = require(script.Parent.StudioThemeAccessor)
local styles = require(script.Parent.styles)

local Color = Roact.Component:extend("Color")

Color.validateProps = t.interface({
    color = t.enum(Enum.StudioStyleGuideColor),
    modifier = t.enum(Enum.StudioStyleGuideModifier),
    LayoutOrder = t.number,
})

function Color:render()
    return StudioThemeAccessor.withTheme(function(theme)
        local color = theme:GetColor(self.props.color, self.props.modifier)

        return Roact.createElement("Frame", {
            LayoutOrder = self.props.LayoutOrder,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
        }, {
            Layout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, styles.Padding),
            }),

            Color = Roact.createElement("Frame", {
                LayoutOrder = 1,
                Size = UDim2.new(1, 0, 0.8, 0),
                BackgroundColor3 = color,
                BorderSizePixel = 2,
                BorderColor3 = colors.darken(theme:GetColor(Enum.StudioStyleGuideColor.MainBackground), 20),
            }),

            Meta = Roact.createElement(TextLabel, {
                LayoutOrder = 2,
                Text = ("%s (%i, %i, %i)"):format(self.props.modifier.Name, color.r*255, color.g*255, color.b*255),
                Size = UDim2.new(1, 0, 0.2, 0),
            })
        })
    end)
end

return Color
