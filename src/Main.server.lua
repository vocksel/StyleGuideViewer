local Roact = require(script.Parent.Modules.Roact)
local App = require(script.Parent.App)

local widget do
	local info = DockWidgetPluginGuiInfo.new(
		Enum.InitialDockState.Bottom,
        true
	)
	local widgetName = "StudioStyleGuideViewer"
	widget = plugin:CreateDockWidgetPluginGui(widgetName, info)

	widget.Name = widgetName
	widget.Title = "Studio Style Guide Viewer"
	widget.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
end

do
    local toolbar = plugin:CreateToolbar("Studio Style Guide")

    local toggleAppView = toolbar:CreateButton(
        "StyleGuideToggle",
        "Toggles the view of all Studio style guide colors",
        "",
        "View colors"
    )

    toggleAppView.Click:Connect(function()

    end)

    toggleAppView.Click:Connect(function()
        widget.Enabled = not widget.Enabled
    end)
end

local app = Roact.createElement(App)
Roact.mount(app, widget, "App")
