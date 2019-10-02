local Roact = require(script.Parent.Modules.Roact)
local t = require(script.Parent.Modules.t)
local colors = require(script.Parent.colors)
local HeaderTextLabel = require(script.Parent.HeaderTextLabel)
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
            Size = UDim2.new(1, 0, 1, 0),
            SizeConstraint = Enum.SizeConstraint.RelativeYY,
            LayoutOrder = self.props.LayoutOrder,
            BackgroundColor3 = color,
            BorderSizePixel = 2,
            BorderColor3 = colors.darken(theme:GetColor(Enum.StudioStyleGuideColor.MainBackground), 20),
        }, {
            Layout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center,
            }),

            ModifierName = Roact.createElement(HeaderTextLabel, {
                LayoutOrder = 1,
                Text = self.props.modifier.Name,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextStrokeTransparency = 0,
                TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
                Size = UDim2.new(1, 0, 0, styles.HeaderTextSize),
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center,
            }),

            ColorValue = Roact.createElement(TextLabel, {
                LayoutOrder = 2,
                Text = ("(%i, %i, %i)"):format(color.r*255, color.g*255, color.b*255),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextStrokeTransparency = 0,
                TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
                Size = UDim2.new(1, 0, 0, styles.HeaderTextSize),
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center,
            })
        })
    end)
end

return Color
