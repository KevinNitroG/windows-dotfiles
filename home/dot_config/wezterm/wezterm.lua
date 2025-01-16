-- Ref: https://github.com/theopn/dotfiles/blob/main/wezterm/wezterm.lua

local is_dark = true
local shell = { "pwsh" }

local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

-- Mux
wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():set_position(60, 80)
end)

local config = {}
-- Use config builder object if possible
if wezterm.config_builder then
	config = wezterm.config_builder()
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Latte"
	end
end

-- UI
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.font = wezterm.font_with_fallback({
	{ family = "JetBrainsMono NF", scale = 1.0 },
	"Liga SFMono Nerd Font",
	"Apple Color Emoji",
})
config.font_size = 13
config.line_height = 1.1
config.window_background_opacity = 0.9
config.window_decorations = "TITLE | RESIZE" -- INTEGRATED_BUTTONS, RESIZE, TITLE, NONE
config.window_padding = {
	left = 5,
	right = 7,
	top = 5,
	bottom = 0,
}

-- Cursor
config.default_cursor_style = "BlinkingBar"
config.animation_fps = 1
config.cursor_blink_rate = 700
config.cursor_thickness = 2

-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 1.0,
	brightness = is_dark and 0.85 or 0.95,
}

-- Engine
config.default_prog = shell
config.automatically_reload_config = true
config.max_fps = 60
config.enable_wayland = false
config.pane_focus_follows_mouse = false
config.window_close_confirmation = "NeverPrompt"
config.scrollback_lines = 3000
config.default_workspace = "main"
config.win32_system_backdrop = "Acrylic" -- Auto, Disabled, Acrylic, Mica, Tabbed
config.window_background_opacity = 0.7
config.initial_cols = 138
config.initial_rows = 28
config.front_end = "WebGpu" -- OpenGL, WebGpu, Software

-- Wezterm
config.set_environment_variables = { TERMINAL = "WezTerm" }
config.warn_about_missing_glyphs = false
config.show_update_window = true
config.check_for_updates = false
config.enable_scroll_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.visual_bell = {
	fade_in_duration_ms = 75,
	fade_out_duration_ms = 75,
	target = "CursorColor",
}

-- Menu
config.launch_menu = {}
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	table.insert(config.launch_menu, {
		label = "PowerShell 7",
		args = { "pwsh.exe" },
	})
	table.insert(config.launch_menu, {
		label = "PowerShell",
		args = { "powershell.exe", "-NoLogo" },
	})

	-- Find installed visual studio version(s) and add their compilation
	-- environment command prompts to the menu
	for _, vsvers in ipairs(wezterm.glob("Microsoft Visual Studio/20*", "C:/Program Files (x86)")) do
		local year = vsvers:gsub("Microsoft Visual Studio/", "")
		table.insert(config.launch_menu, {
			label = "x64 Native Tools VS " .. year,
			args = {
				"cmd.exe",
				"/k",
				"C:/Program Files (x86)/" .. vsvers .. "/BuildTools/VC/Auxiliary/Build/vcvars64.bat",
			},
		})
	end
end

-- Mouse: Middle to paste
-- Ref: https://www.reddit.com/r/wezterm/comments/10jda7o/is_there_a_way_not_to_open_urls_on_simple_click/
config.mouse_bindings = {
	-- Disable the default click behavior
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = wezterm.action.DisableDefaultAssignment,
	},
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Down = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

-- Keys
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 3000 }
config.keys = {
	{ key = "phys:Space", mods = "LEADER", action = act.ActivateCommandPalette },

	-- Remove default bindings
	{ key = "n", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
	{ key = "t", mods = "CTRL | SHIFT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "w", mods = "CTRL | SHIFT", action = wezterm.action.DisableDefaultAssignment },

	-- Copy and paste
	{ key = "c", mods = "CTRL | SHIFT", action = act.CopyTo("ClipboardAndPrimarySelection") },
	{ key = "v", mods = "CTRL | SHIFT", action = act.PasteFrom("Clipboard") },

	-- Font Size
	{ key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },

	-- Window
	{ key = "F11", mods = "", action = wezterm.action.ToggleFullScreen },

	-- Send C-a when pressing C-a twice
	{ key = "a", mods = "LEADER | CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },

	-- Pane split
	{ key = "_", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- {
	-- 	key = "_",
	-- 	mods = "LEADER",
	-- 	action = wezterm.action.SplitPane({ top_level = true, direction = "Down", size = { Percent = 50 } }),
	-- },
	{ key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{
		key = "|",
		mods = "LEADER",
		action = wezterm.action.SplitPane({ top_level = true, direction = "Right", size = { Percent = 50 } }),
	},

	-- Pane navigate
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) },
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "o", mods = "LEADER", action = act.RotatePanes("Clockwise") },

	-- Pane resize
	{
		key = "s",
		mods = "LEADER",
		action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
	},
	{ key = "h", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Left", 2 }) },
	{ key = "j", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Down", 2 }) },
	{ key = "k", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Up", 2 }) },
	{ key = "l", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Right", 2 }) },

	-- Tab keybindings
	{ key = "Q", mods = "LEADER", action = wezterm.action({ CloseCurrentTab = { confirm = false } }) },
	{ key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "n", mods = "LEADER", action = act.ShowTabNavigator },
	{
		key = "r",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Renaming Tab Title: " },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	-- Key table for moving tabs around
	{ key = "m", mods = "LEADER", action = act.ActivateKeyTable({ name = "move_tab", one_shot = false }) },
	-- Or shortcuts to move tab w/o move_tab table. SHIFT is for when caps lock is on
	{ key = "<", mods = "LEADER | SHIFT", action = act.MoveTabRelative(-1) },
	{ key = ">", mods = "LEADER | SHIFT", action = act.MoveTabRelative(1) },

	-- Lastly, workspace
	{ key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
}
-- I can use the tab navigator (LDR t), but I also want to quickly navigate tabs with index
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

config.key_tables = {
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
	move_tab = {
		{ key = "h", action = act.MoveTabRelative(-1) },
		{ key = "j", action = act.MoveTabRelative(-1) },
		{ key = "k", action = act.MoveTabRelative(1) },
		{ key = "l", action = act.MoveTabRelative(1) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}

-- Tab bar
config.use_fancy_tab_bar = true
-- config.status_update_interval = 1000
config.tab_bar_at_bottom = false

--[[ Appearance setting for when I need to take pretty screenshots
config.enable_tab_bar = false
config.window_padding = {
  left = '0.5cell',
  right = '0.5cell',
  top = '0.5cell',
  bottom = '0cell',

}
--]]

-- config.hyperlink_rules = {
-- 	{ regex = "\\b\\w+://[\\w.-]+:[0-9]{2,15}\\S*\\b", format = "$0" },
-- 	{ regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b", format = "$0" },
-- 	{ regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]], format = "mailto:$0" },
-- 	{ regex = [[\bfile://\S*\b]], format = "$0" },
-- 	{ regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]], format = "$0" },
-- 	{ regex = [[\b[tT](\d+)\b]], format = "https://example.com/tasks/?t=$1" },
-- }

return config
