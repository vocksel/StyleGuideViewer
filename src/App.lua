local Roact = require(script.Parent.Modules.Roact)
local ScrollingFrame = require(script.Parent.ScrollingFrame)
local ColorDetail = require(script.Parent.ColorDetail)

local App = Roact.Component:extend("App")

function App:render()
    -- TODO: Add a foreword that you need to change studio theme to view colors
    -- for other themes

    -- TODO: Add a filter to see certain colors

    local children = {}

    for i, color in ipairs(Enum.StudioStyleGuideColor:GetEnumItems()) do
        children[color.Name] = Roact.createElement(ColorDetail, {
            color = color,
            LayoutOrder = i,
        })
    end

    return Roact.createElement(ScrollingFrame, {
        listPadding = UDim.new(0, 16),
        padding = 8,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
    }, children)
end

return App
