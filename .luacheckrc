stds.roblox = {
	globals = {
		"game", "workspace", "script"
	},
	read_globals = {
		-- Extra functions
		"tick", "warn", "spawn",
		"wait", "settings",
		"delay", "debug",

		-- Types
		"Vector2", "Vector3",
		"Color3",
		"BrickColor",
		"UDim", "UDim2",
		"Rect",
		"CFrame",
		"Enum",
		"Instance",
		"TweenInfo",
		"NumberRange",
		"NumberSequence",
		"NumberSequenceKeypoint",
		"DockWidgetPluginGuiInfo",
		"ColorSequence",
		"Random",
		"Ray",
		"time",
		"typeof",

		utf8 = { fields = { "char", "codes", "codepoint", "len", "offset",
			"graphemes", "nfcnormalize", "nfdnormalize", "charpattern" } },

		math = { fields = { "clamp", "noise", "sign" } }
	}
}

stds.testez = {
	read_globals = {
		"describe",
		"it", "itFOCUS", "itSKIP",
		"FOCUS", "SKIP", "HACK_NO_XPCALL",
		"expect",
	}
}

stds.remodel = {
	read_globals = {
		remodel = { fields = {
			"readPlaceFile",
			"readModelFile",
			"writePlaceFile",
			"writeModelFile",
			"createDirAll",
		} }
	}
}

stds.plugin = {
    read_globals = {
        "plugin"
    }
}

ignore = {
	"212", -- unused arguments
	"421", -- shadowing local variable
	"422", -- shadowing argument
	"431", -- shadowing upvalue
	"432", -- shadowing upvalue argument
}

std = "lua51+roblox"

files["scripts/**/*.lua"] ={
	std = "+remodel"
}

files["**/*.spec.lua"] = {
	std = "+testez",
}

files["**/*.server.lua"] = {
    std = "+plugin"
}
files["**/*.client.lua"] = {
    std = "+plugin"
}

files["**/*Locale.lua"] = {
	ignore = { "631" }, --Line is too long
}
