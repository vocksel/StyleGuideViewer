-- ty tiffany,,,,

local Roact = require(script.Parent.Modules.Roact)

local StudioThemeAccessor = Roact.Component:extend("StudioThemeAccessor")

function StudioThemeAccessor:init()
	local studioSettings = settings().Studio

	self.state = {
		theme = studioSettings.Theme,
		themeEnum = studioSettings["UI Theme"],
	}

	self._themeConnection = studioSettings.ThemeChanged:Connect(function()
		self:setState({
			theme = studioSettings.Theme,
			themeEnum = studioSettings["UI Theme"],
		})
	end)
end

function StudioThemeAccessor:willUnmount()
	self._themeConnection:Disconnect()
end

function StudioThemeAccessor:render()
	local render = Roact.oneChild(self.props[Roact.Children])

	return render(self.state.theme, self.state.themeEnum)
end

function StudioThemeAccessor.withTheme(render)
	return Roact.createElement(StudioThemeAccessor, {}, {
		render = render
	})
end

return StudioThemeAccessor
