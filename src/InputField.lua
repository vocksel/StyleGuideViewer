local Roact = require(script.Parent.Modules.Roact)
local t = require(script.Parent.Modules.t)
local StudioThemeAccessor = require(script.Parent.StudioThemeAccessor)
local styles = require(script.Parent.styles)

local InputField = Roact.Component:extend("InputField")

InputField.validateProps = t.interface({
    padding = t.optional(t.number),
    onSubmit = t.optional(t.callback),
    onTextChange = t.optional(t.callback),
    clearTextOnSubmit = t.optional(t.boolean),

    ClearTextOnFocus = t.optional(t.boolean),
    Placeholdertext = t.optional(t.string),
    Size = t.optional(t.UDim2),
    Position = t.optional(t.UDim2),
    AnchorPoint = t.optional(t.Vector2),
})

InputField.defaultProps = {
    padding = styles.Padding,
    clearTextOnSubmit = true,
    ClearTextOnFocus = false,
    Placeholdertext = "Type here..."
}

function InputField:init()
	self.state = {
		text = ""
	}

    self.setText = function(rbx)
        local text = rbx.Text

        if self.props.onTextChange then
            self.props.onTextChange(text)
        end

		self:setState({ text = text })
	end

	self.onFocusLost = function(rbx, enterPressed)
        if enterPressed then
            if self.props.onSubmit then
                self.props.onSubmit(self.state.text)
            end

            if self.props.clearTextOnSubmit then
                self:setState({ text = "" })
            end
		end
	end
end

function InputField:render()
	return StudioThemeAccessor.withTheme(function(theme)
		return Roact.createElement("TextBox", {
            Text = self.state.text,
            Font = styles.Font,
            TextSize = styles.TextSize,
            PlaceholderText = self.props.PlaceholderText,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			BackgroundColor3 = theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground),
			BorderSizePixel = 0,
			TextColor3 = theme:GetColor(Enum.StudioStyleGuideColor.MainText),
			PlaceholderColor3 = theme:GetColor(Enum.StudioStyleGuideColor.SubText),
			TextWrapped = true,
			ClearTextOnFocus = self.props.ClearTextOnFocus,
			Size = self.props.Size,
            Position = self.props.Position,
            AnchorPoint = self.props.AnchorPoint,

			[Roact.Change.Text] = self.setText,
			[Roact.Event.FocusLost] = self.onFocusLost
		}, {
			Roact = Roact.createElement("UIPadding", {
                PaddingTop = UDim.new(0, self.props.padding),
                PaddingRight = UDim.new(0, self.props.padding),
                PaddingBottom = UDim.new(0, self.props.padding),
                PaddingLeft = UDim.new(0, self.props.padding),
            })
		})
	end)
end

return InputField
