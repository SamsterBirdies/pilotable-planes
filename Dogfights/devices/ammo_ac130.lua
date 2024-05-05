dofile("mods/dlc2/devices/ammo_nighthawk.lua")
Sprites = {}
ConsumeEffect = "mods/dlc2/effects/ammo_consumption.lua"
DeviceSplashDamage = 400
DeviceSplashDamageMaxRadius = 400
DeviceSplashDamageDelay = 0
IncendiaryRadius = 250
IncendiaryRadiusHeated = 350
StructureSplashDamage = 240
StructureSplashDamageMaxRadius = 200
DestroyEffect = path .. "/effects/HUGE_EXPLOSION.lua"
Root = 
{
	Sprite = path .. "/devices/ac130Ammo.png",
	Name = "ammo_ac130",
	ChildrenInFront = {},
	Angle = 0,
	Pivot = {0,-0.5},
	PivotOffset = {0,0}
}

dofile('ui/uihelper.lua')
table.insert(Sprites, ButtonSprite("hud-ammo-sbpp_ac130", "context/HUD-ac130", nil, nil, nil, nil, path))
table.insert(Sprites,
	{
		Name = "sbpp_ac130_runway",
		States =
		{
			Normal = { Frames = { { texture = path .. "/weapons/ac130/ac130_runway.png" }, mipmap = true, }, },
			Idle = Normal,
			Reload =
			{
				Frames =
				{
					{ texture = path .. "/weapons/ac130/ac130_runway.png", duration = 120, colour = {0,0,0,0} },
					mipmap = true,
					duration = 0.1,
				},
			},
		},
	}
)

dlc2_Ammunition =
{
	{ 
		AmmoSprites = { { Node = "Head", Sprite = "sbpp_ac130_runway", }, },
		Sprite = "hud-ammo-sbpp_ac130",
		Devices = { {Name = "ammo_sbpp_ac130", Consume = true}, },
		Weapons = { "runway2" },
		MinFireSpeed = 3000,
		MaxFireSpeed = 3000.1,
		Projectile = "sbpp_ac130",
		HeatPerRound = 0.4,
	}
}