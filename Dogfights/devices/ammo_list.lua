dofile("scripts/type.lua")

local thunderbolt = FindDevice("ammo_thunderbolt")
if thunderbolt then
	thunderbolt.MetalCost = 400
	thunderbolt.EnergyCost = 8000
	thunderbolt.BuildTimeComplete = 50
end
local nighthawk = FindDevice("ammo_nighthawk")
if nighthawk then
	nighthawk.MetalCost = 200
	nighthawk.EnergyCost = 6000
	nighthawk.BuildTimeComplete = 45
end

table.insert(Sprites, DetailSprite("hud-detail-sbpp_BiplaneFlechette", "biplane", path))
table.insert(Sprites, ButtonSprite("hud-sbpp_BiplaneFlechette-icon", "HUD/HUD-biplaneFlechette", nil, ButtonSpriteBottom, nil, nil, path))
table.insert(Devices, IndexOfDevice("ammo_thunderbolt"),
	InheritType(FindDevice("ammo_nighthawk"),nil,
		{	
			SaveName = "ammo_sbpp_Biplane",
			FileName = path .. "/devices/ammo_biplane.lua",
			dlc2_BuildQueue = "dlc2_runway",
			Detail = "hud-detail-sbpp_BiplaneFlechette",
			Icon = "hud-sbpp_BiplaneFlechette-icon",
			MetalCost = 50,
			EnergyCost = 1000,
			Prerequisite = "workshop",
			Enabled = true,
			BuildTimeComplete = 15,
			ObserverBuildEvent = false,
		}
	)
)

table.insert(Sprites, DetailSprite("hud-detail-sbpp_f16", "f16", path))
table.insert(Sprites, ButtonSprite("hud-sbpp_f16-icon", "HUD/HUD-f16", nil, ButtonSpriteBottom, nil, nil, path))
table.insert(Devices, IndexOfDevice("ammo_thunderbolt"),
	InheritType(FindDevice("ammo_nighthawk"),nil,
		{	
			SaveName = "ammo_sbpp_f16",
			FileName = path .. "/devices/ammo_f16.lua",
			dlc2_BuildQueue = "dlc2_runway",
			Detail = "hud-detail-sbpp_f16",
			Icon = "hud-sbpp_f16-icon",
			MetalCost = 300,
			EnergyCost = 5000,
			Prerequisite = "armoury",
			Enabled = true,
			BuildTimeComplete = 40,
			ObserverBuildEvent = false,
		}
	)
)

table.insert(Sprites, DetailSprite("hud-detail-sbpp_p51", "p51", path))
table.insert(Sprites, ButtonSprite("hud-sbpp_p51-icon", "HUD/HUD-p51", nil, ButtonSpriteBottom, nil, nil, path))
table.insert(Devices, IndexOfDevice("ammo_nighthawk"),
	InheritType(FindDevice("ammo_nighthawk"),nil,
		{	
			SaveName = "ammo_sbpp_p51",
			FileName = path .. "/devices/ammo_p51.lua",
			dlc2_BuildQueue = "dlc2_runway",
			Detail = "hud-detail-sbpp_p51",
			Icon = "hud-sbpp_p51-icon",
			MetalCost = 200,
			EnergyCost = 4000,
			Prerequisite = "factory",
			Enabled = true,
			BuildTimeComplete = 25,
			ObserverBuildEvent = false,
		}
	)
)
table.insert(Sprites, DetailSprite("hud-detail-sbpp_hellcat", "hellcat", path))
table.insert(Sprites, ButtonSprite("hud-sbpp_hellcat-icon", "HUD/HUD-hellcat", nil, ButtonSpriteBottom, nil, nil, path))
table.insert(Devices, IndexOfDevice("ammo_thunderbolt"),
	InheritType(FindDevice("ammo_nighthawk"),nil,
		{	
			SaveName = "ammo_sbpp_hellcat",
			FileName = path .. "/devices/ammo_hellcat.lua",
			dlc2_BuildQueue = "dlc2_runway",
			Detail = "hud-detail-sbpp_hellcat",
			Icon = "hud-sbpp_hellcat-icon",
			MetalCost = 200,
			EnergyCost = 4000,
			Prerequisite = "munitions",
			Enabled = true,
			BuildTimeComplete = 30,
			ObserverBuildEvent = false,
		}
	)
)
table.insert(Sprites, DetailSprite("hud-detail-sbpp_ac130", "ac130", path))
table.insert(Sprites, ButtonSprite("hud-sbpp_ac130-icon", "HUD/HUD-ac130", nil, ButtonSpriteBottom, nil, nil, path))
table.insert(Devices, IndexOfDevice("ammo_nighthawk") + 1,
	InheritType(FindDevice("ammo_nighthawk"),nil,
		{	
			SaveName = "ammo_sbpp_ac130",
			FileName = path .. "/devices/ammo_ac130.lua",
			dlc2_BuildQueue = "dlc2_runway",
			Detail = "hud-detail-sbpp_ac130",
			Icon = "hud-sbpp_ac130-icon",
			MetalCost = 1200,
			EnergyCost = 24000,
			Prerequisite = {{"munitions", "factory"}},
			Enabled = true,
			BuildTimeComplete = 120,
			ObserverBuildEvent = true,
		}
	)
)

table.insert(Sprites, DetailSprite("hud-detail-sbpp_apache", "apache", path))
table.insert(Sprites, ButtonSprite("hud-sbpp_apache-icon", "HUD/HUD-apache", nil, ButtonSpriteBottom, nil, nil, path))
table.insert(Devices, IndexOfDevice("ammo_nighthawk") + 1,
	InheritType(FindDevice("ammo_nighthawk"),nil,
		{	
			SaveName = "ammo_sbpp_apache",
			FileName = path .. "/devices/ammo_apache.lua",
			dlc2_BuildQueue = "dlc2_runway",
			Detail = "hud-detail-sbpp_apache",
			Icon = "hud-sbpp_apache-icon",
			MetalCost = 500,
			EnergyCost = 9000,
			Prerequisite = "factory",
			--Enabled = false,
			BuildTimeComplete = 60,
			ObserverBuildEvent = false,
		}
	)
)