dofile("scripts/type.lua")
BuildQueueConcurrent["dlc2_runway"] = { Default = 1, Min = 1, Max = 3 }
BuildQueueConcurrent["dlc2_runway2"] = { Default = 1, Min = 1, Max = 2 }
BuildQueueConcurrent["dlc2_runway3"] = { Default = 1, Min = 1, Max = 1 }
table.insert(Sprites, ButtonSprite("hud-sbpp_a10-icon", "HUD/HUD-a10", nil, ButtonSpriteBottom, nil, nil, path))
table.insert(Sprites, ButtonSprite("hud-sbpp_nighthawk-icon", "HUD/HUD-nighthawk", nil, ButtonSpriteBottom, nil, nil, path))
local thunderbolt = FindDevice("ammo_thunderbolt")
if thunderbolt then
	thunderbolt.MetalCost = 400
	thunderbolt.EnergyCost = 8000
	thunderbolt.BuildTimeComplete = 40
	thunderbolt.Icon = "hud-sbpp_a10-icon"
	thunderbolt.dlc2_BuildQueue = "dlc2_runway2"
end
local nighthawk = FindDevice("ammo_nighthawk")
if nighthawk then
	nighthawk.MetalCost = 200
	nighthawk.EnergyCost = 6000
	nighthawk.Icon = "hud-sbpp_nighthawk-icon"
	nighthawk.BuildTimeComplete = 40
	nighthawk.dlc2_BuildQueue = "dlc2_runway2"
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
			dlc2_BuildQueue = "dlc2_runway2",
			Detail = "hud-detail-sbpp_f16",
			Icon = "hud-sbpp_f16-icon",
			MetalCost = 300,
			EnergyCost = 5000,
			Prerequisite = "armoury",
			Enabled = true,
			BuildTimeComplete = 30,
			ObserverBuildEvent = false,
		}
	)
)

table.insert(Sprites, DetailSprite("hud-detail-sbpp_p51", "p51", path))
table.insert(Sprites, ButtonSprite("hud-sbpp_p51-icon", "HUD/HUD-p51", nil, ButtonSpriteBottom, nil, nil, path))
table.insert(Devices, IndexOfDevice("ammo_sbpp_f16"),
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
table.insert(Devices, IndexOfDevice("ammo_sbpp_p51"),
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
			dlc2_BuildQueue = "dlc2_runway3",
			Detail = "hud-detail-sbpp_ac130",
			Icon = "hud-sbpp_ac130-icon",
			MetalCost = 1200,
			EnergyCost = 18000,
			Prerequisite = "factory",
			Enabled = true,
			BuildTimeComplete = 90,
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
			dlc2_BuildQueue = "dlc2_runway2",
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

table.insert(Sprites, DetailSprite("hud-detail-sbpp_littlebird", "littlebird", path))
table.insert(Sprites, ButtonSprite("hud-sbpp_littlebird-icon", "HUD/HUD-littlebird", nil, ButtonSpriteBottom, nil, nil, path))
table.insert(Devices, IndexOfDevice("ammo_thunderbolt") + 1,
	InheritType(FindDevice("ammo_nighthawk"),nil,
		{	
			SaveName = "ammo_sbpp_littlebird",
			FileName = path .. "/devices/ammo_littlebird.lua",
			dlc2_BuildQueue = "dlc2_runway2",
			Detail = "hud-detail-sbpp_littlebird",
			Icon = "hud-sbpp_littlebird-icon",
			MetalCost = 300,
			EnergyCost = 6000,
			Prerequisite = "munitions",
			--Enabled = false,
			BuildTimeComplete = 50,
			ObserverBuildEvent = false,
		}
	)
)

table.insert(Devices, IndexOfDevice("ammo_sbpp_p51"),
	InheritType(FindDevice("ammo_nighthawk"),nil,
		{	
			SaveName = "ammo_sbpp_mig15",
			FileName = path .. "/devices/ammo_mig15.lua",
			dlc2_BuildQueue = "dlc2_runway",
			Detail = "hud-detail-sbpp_hellcat",
			Icon = "hud-sbpp_hellcat-icon",
			MetalCost = 300,
			EnergyCost = 5000,
			Prerequisite = "munitions",
			Enabled = true,
			BuildTimeComplete = 40,
			ObserverBuildEvent = false,
		}
	)
)