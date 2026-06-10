
planename = input("plane name:")
tier = input("tier:")
costm = input("cost metal:")
coste = input("cost energy:")
buildtime = input("build time:")
prereq = input("prerequisite:")

weapons = '{ "runway", "runway2", "sbpp_runway3" }'
buildqueue = 'dlc2_runway'
if tier == '2':
	weapons = '{ "runway2", "sbpp_runway3" }'
	buildqueue = 'dlc2_runway2'
elif tier == '3':
	weapons = '{ "sbpp_runway3" }'
	buildqueue = 'dlc2_runway3'


ammo_file = f'''
dofile("mods/dlc2/devices/ammo_nighthawk.lua")
Sprites = {{}}
ConsumeEffect = "mods/dlc2/effects/ammo_consumption.lua"
DestroyEffect = "effects/device_explode.lua"
Root = 
{{
	Sprite = path .. "/devices/{planename}.png",
	Name = "ammo_{planename}",
	ChildrenInFront = {{}},
	Angle = 0,
	Pivot = {{0,-0.5}},
	PivotOffset = {{0,0}}
}}

dofile('ui/uihelper.lua')
table.insert(Sprites, ButtonSprite("hud-ammo-sbpp_{planename}", "context/HUD-{planename}", nil, nil, nil, nil, path))
table.insert(Sprites,
	{{
		Name = "sbpp_{planename}_runway",
		States =
		{{
			Normal = {{ Frames = {{ {{ texture = path .. "/weapons/{planename}/{planename}_runway.png" }}, mipmap = true, }}, }},
			Idle = Normal,
			Reload =
			{{
				Frames =
				{{
					{{ texture = path .. "/weapons/{planename}/{planename}_runway.png", duration = 120, colour = {{0,0,0,0}} }},
					mipmap = true,
					duration = 0.1,
				}},
			}},
		}},
	}}
)

dlc2_Ammunition =
{{
	{{ 
		AmmoSprites = {{ {{ Node = "Head", Sprite = "sbpp_{planename}_runway", }}, }},
		Sprite = "hud-ammo-sbpp_{planename}",
		Devices = {{ {{Name = "ammo_sbpp_{planename}", Consume = true}}, }},
		Weapons = {weapons},
		MinFireSpeed = 3000,
		MaxFireSpeed = 3000.1,
		Projectile = "sbpp_{planename}",
		HeatPerRound = 0.4,
		RowName = "mk{tier}",
	}}
}}
'''

ammo_list_entry = f'''
table.insert(Sprites, DetailSprite("hud-detail-sbpp_{planename}", "{planename}", path))
table.insert(Sprites, ButtonSprite("hud-sbpp_{planename}-icon", "HUD/HUD-{planename}", nil, ButtonSpriteBottom, nil, nil, path))
table.insert(Devices, IndexOfDevice("ammo_sbpp_biplane"),
	InheritType(FindDevice("ammo_nighthawk"),nil,
		{{	
			SaveName = "ammo_sbpp_{planename}",
			FileName = path .. "/devices/ammo_{planename}.lua",
			dlc2_BuildQueue = "{buildqueue}",
			Detail = "hud-detail-sbpp_{planename}",
			Icon = "hud-sbpp_{planename}-icon",
			MetalCost = {costm},
			EnergyCost = {coste},
			Prerequisite = "{prereq}",
			Enabled = true,
			BuildTimeComplete = {buildtime},
			ObserverBuildEvent = true,
		}}
	)
)
'''

with open(f"ammo_{planename}.lua", "w") as file:
    file.write(ammo_file)
with open("ammo_list.lua", "a") as file:
    file.write(ammo_list_entry)
