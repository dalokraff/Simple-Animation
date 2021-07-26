return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`Simple Animation` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("Simple Animation", {
			mod_script       = "scripts/mods/Simple Animation/Simple Animation",
			mod_data         = "scripts/mods/Simple Animation/Simple Animation_data",
			mod_localization = "scripts/mods/Simple Animation/Simple Animation_localization",
		})
	end,
	packages = {
		"resource_packages/Simple Animation/Simple Animation",
	},
}
