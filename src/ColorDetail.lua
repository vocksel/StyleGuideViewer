local Roact = require(script.Parent.Modules.Roact)
local t = require(script.Parent.Modules.t)
local styles = require(script.Parent.styles)
local HeaderTextLabel = require(script.Parent.HeaderTextLabel)
local Color = require(script.Parent.Color)
local ListBox = require(script.Parent.ListBox)

local ColorDetail = Roact.Component:extend("ColorDetail")

ColorDetail.validateProps = t.interface({
    color = t.enum(Enum.StudioStyleGuideColor),
    LayoutOrder = t.number,
})

function ColorDetail:render()
    local totalModifiers = #Enum.StudioStyleGuideModifier:GetEnumItems()
    local colors = {}

    colors.Layout = Roact.createElement("UIGridLayout", {
        CellSize = UDim2.new(1/totalModifiers, -styles.Padding, 1, 0),
        CellPadding = UDim2.new(0, styles.Padding, 0, styles.BigPadding),
        SortOrder = Enum.SortOrder.LayoutOrder,
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
        Name = Roact.createElement(HeaderTextLabel, {
            Text = self.props.color.Name,
            LayoutOrder = 1,
            Size = UDim2.new(1, 0, 0, styles.TextSize),
        }),

        Colors = Roact.createElement("Frame", {
            LayoutOrder = 2,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 140),
        }, colors),
    })
end

return ColorDetail
