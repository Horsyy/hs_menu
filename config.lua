Config = {}

Config.DefaultVolume = 0.5 -- Defines the default volume.

Config.EnableCommand = true
Config.CommandName = 'ytmenu'

Config.EnableAuthorizedGrade = true -- If you wanna restrict the YouTube Menu for certain people set it true.
Config.AuthorizedGrade = 'dj'		-- Also boss grade has always access 

Config.Jobs = { -- Sets the jobs that will be able to use the YouTube Menu.
		unicorn = {
			{ jobName = 'unicorn', coordinates = vector3(118.4, -1284.5, 28.85), distance = '25' }
		},
		bahamas = {
			{ jobName = 'bahamas', coordinates = vector3(-1387.06, -618.31, 30.81), distance = '30' }
		},
		crucialfix = {
			{ jobName = 'crucialfix', coordinates = vector3(268.15, -824.53, 29.44), distance = '15' }
		},
		pearls = {
			{ jobName = 'pearls', coordinates = vector3(-1830.17, -1191.51, 19.22), distance = '25' }
		}
}