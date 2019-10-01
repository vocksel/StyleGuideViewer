local Roact = require(script.Parent.Modules.Roact)
local t = require(script.Parent.Modules.t)
local styles = require(script.Parent.styles)
local TextLabel = require(script.Parent.TextLabel)
local Color = require(script.Parent.Color)
local ListBox = require(script.Parent.ListBox)

local ColorDetail = Roact.Component:extend("ColorDetail")

ColorDetail.validateProps = t.interface({
    color = t.enum(Enum.StudioStyleGuideColor),
    LayoutOrder = t.number,
})

function ColorDetail:render()
    local colors = {}

    colors.Layout = Roact.createElement("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, styles.BigPadding),
    })

    for i, modifier in ipairs(Enum.StudioStyleGuideModifier:GetEnumItems()) do
        colors[modifier.Name] = Roact.createElement(Color, {
            color = self.props.color,
            modifier = modifier,
            LayoutOrder = i
        })
    end

    return Roact.createElement(ListBox, {
        useLazyResizing = true,
        listPadding = UDim.new(0, styles.Padding),
        LayoutOrder = self.props.LayoutOrder,
        BackgroundTransparency = 1,
    }, {
        Name = Roact.createElement(TextLabel, {
            Text = self.props.color.Name,
            LayoutOrder = 1,
            Size = UDim2.new(1, 0, 0, styles.TextSize),
        }),

        Colors = Roact.createElement("Frame", {
            LayoutOrder = 2,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 100),
        }, colors),
    })
end

return ColorDetail
