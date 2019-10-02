local Roact = require(script.Parent.Modules.Roact)
local App = require(script.Parent.App)
local config = require(script.Parent.config)

local widget do
	local info = DockWidgetPluginGuiInfo.new(
        Enum.InitialDockState.Bottom
    )

	local widgetName = config.PLUGIN_NAME.."App"
	widget = plugin:CreateDockWidgetPluginGui(widgetName, info)

	widget.Name = widgetName
	widget.Title = config.DISPLAY_NAME
	widget.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
end

do
    local toolbar = plugin:CreateToolbar("Studio Style Guide")

	local toggleAppView = toolbar:CreateButton(
		"View colors",
		"Toggles the view of all Studio style guide colors",
		""
	)

    toggleAppView.Click:Connect(function()
        widget.Enabled = not widget.Enabled
    end)
end

local app = Roact.createElement(App)
Roact.mount(app, widget, "App")
