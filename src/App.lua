local Roact = require(script.Parent.Modules.Roact)
local Cryo = require(script.Parent.Modules.Cryo)
local ScrollingFrame = require(script.Parent.ScrollingFrame)
local styles = require(script.Parent.styles)
local ColorDetail = require(script.Parent.ColorDetail)
local InputField = require(script.Parent.InputField)
local StudioThemeAccessor = require(script.Parent.StudioThemeAccessor)

local App = Roact.Component:extend("App")

function App:init()
    self.state = {
        filter = nil
    }
end

function App:getStyleGuideColors()
    local styleGuideColors = Enum.StudioStyleGuideColor:GetEnumItems()

    if self.state.filter then
        return Cryo.List.filter(styleGuideColors, function(color)
            return color.Name:lower():match(self.state.filter:lower())
        end)
    else
        return styleGuideColors
    end
end

function App:render()
    -- TODO: Add a foreword that you need to change studio theme to view colors
    -- for other themes

    return StudioThemeAccessor.withTheme(function(theme)
        local children = {}

        for i, color in ipairs(self:getStyleGuideColors()) do
            children[color.Name] = Roact.createElement(ColorDetail, {
                color = color,
                LayoutOrder = i,
            })
        end

        local filterHeight = styles.TextSize+(styles.Padding*2)

        return Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = theme:GetColor(Enum.StudioStyleGuideColor.MainBackground)
        }, {
            Layout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
            }),

            Filter = Roact.createElement(InputField, {
                LayoutOrder = 1,
                Size = UDim2.new(1, 0, 0, filterHeight),
                PlaceholderText = "Filter colors...",
                ClearTextOnFocus = true,
                clearTextOnSubmit = false,
                onTextChange = function(text)
                    self:setState({ filter = text })
                end
            }),

            ColorList = Roact.createElement(ScrollingFrame, {
                listPadding = UDim.new(0, styles.BigPadding),
                padding = styles.Padding,
                LayoutOrder = 2,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, -filterHeight),
            }, children)
        })
    end)
end

return App
