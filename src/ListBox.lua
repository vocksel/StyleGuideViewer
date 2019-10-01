--[[
	Creates an automatically sized frame from its children.

	Usage:

		Roact.createElement(ListBox, {
			width = UDim.new(0, 100),
			BackgroundTransparency = 0,
			listPadding = 8,
		}, {
			Red = Roact.createElement("Frame", {
				LayoutOrder = 1,
				Size = UDim2.new(1, 0, 0, 100),
				BackgroundColor3 = Color3.fromRGB(255, 0, 0),
			}),

			Green = Roact.createElement("Frame", {
				LayoutOrder = 2,
				Size = UDim2.new(1, 0, 0, 200),
				BackgroundColor3 = Color3.fromRGB(0, 255, 0),
			}),

			Blue = Roact.createElement("Frame", {
				LayoutOrder = 3,
				Size = UDim2.new(1, 0, 0, 300),
				BackgroundColor3 = Color3.fromRGB(0, 0, 255),
			})
		})

	You can also supply a custom width if you don't want the frame to fill the
	whole width of its parent element.

		Roact.createElement(ListBox, {
			-- Only 400 pixels wide, but will still expand vertically to fit content.
			width = UDim.new(0, 400)
		})

	As well, you can supply padding in two ways. On all sides:

		Roact.createElement(ListBox, {
			-- Creates a UIPadding with 8 pixels of padding on all sides
			padding = 8
		})

	Or individually:

		Roact.createElement(ListBox, {
			-- This will leave PaddingLeft and PaddingRight as 0.
			paddingTop = 8,
			paddingBottom = 8,
		})
]]

local Cryo = require(script.Parent.Modules.Cryo)
local Roact = require(script.Parent.Modules.Roact)
local t = require(script.Parent.Modules.t)

local ListBox = Roact.Component:extend("ListBox")

ListBox.validateProps = t.interface({
    listPadding = t.optional(t.UDim),
	onHeightChange = t.optional(t.callback),
    padding = t.optional(t.integer),
    width = t.optional(t.UDim),
    useLazyResizing = t.optional(t.boolean),

	BackgroundColor3 = t.optional(t.Color3),
	BackgroundTransparency = t.optional(t.number),
	BorderColor = t.optional(t.Color3),
	BorderSize = t.optional(t.integer),
	FillDirection = t.optional(t.enum(Enum.FillDirection)),
	LayoutOrder = t.optional(t.integer),
	PaddingBottom = t.optional(t.integer),
	PaddingLeft = t.optional(t.integer),
	PaddingRight = t.optional(t.integer),
	PaddingTop = t.optional(t.integer),
})

ListBox.defaultProps = {
    width = UDim.new(1, 0),
	PaddingTop = 0,
	PaddingRight = 0,
	PaddingBottom = 0,
	PaddingLeft = 0,
	BackgroundTransparency = 1,
}

function ListBox:init()
	self.height, self.setHeight = Roact.createBinding(0)

	self.onSizeChange = function(rbx)
		local padding = self:getPaddingProps()
		local newHeight = rbx.AbsoluteContentSize.Y + padding.PaddingTop.Offset + padding.PaddingBottom.Offset

		-- useLazyResizing is used when nesting ListBoxes, as there can be event
		-- re-entry errors from a parent ListBox adjusting every time its child
		-- ListBoxes adjust. This switch spawns the height change, so that the
		-- event isn't flooded.
		if self.props.useLazyResizing then
			spawn(function()
				self.setHeight(newHeight)
			end)
		else
			self.setHeight(newHeight)
		end

		if self.props.onHeightChange then
			self.props.onHeightChange(newHeight)
		end
	end

	self.mapHeight = function(height)
		return UDim2.new(self.props.width, UDim.new(0, height))
	end
end

function ListBox:getPaddingProps()
	local padding = self.props.padding

	if padding then
		return {
			PaddingBottom = UDim.new(0, padding),
			PaddingLeft = UDim.new(0, padding),
			PaddingRight = UDim.new(0, padding),
			PaddingTop = UDim.new(0, padding),
		}
	else
		return {
			PaddingBottom = UDim.new(0, self.props.paddingBottom),
			PaddingLeft = UDim.new(0, self.props.paddingLeft),
			PaddingRight = UDim.new(0, self.props.paddingRight),
			PaddingTop = UDim.new(0, self.props.paddingTop),
		}
	end
end

function ListBox:render()
	local children = Cryo.Dictionary.join(self.props[Roact.Children], {
		Layout = Roact.createElement("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = self.props.FillDirection,
			Padding = self.props.listPadding,
			[Roact.Change.AbsoluteContentSize] = self.onSizeChange,
		}),

		Padding = Roact.createElement("UIPadding", self:getPaddingProps())
	})

	return Roact.createElement("Frame", {
		LayoutOrder = self.props.LayoutOrder,
		Size = self.height:map(self.mapHeight),
		BackgroundTransparency = self.props.BackgroundTransparency,
		BackgroundColor3 = self.props.BackgroundColor3,
		BorderColor3 = self.props.BorderColor,
		BorderSizePixel = self.props.BorderSize,
	}, children)
end

return ListBox
