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
	Sprite = path .. "/devices/b52Ammo.png",
	Name = "ammo_b52",
	ChildrenInFront = {},
	Angle = 0,
	Pivot = {0,-0.5},
	PivotOffset = {0,0}
}

dofile('ui/uihelper.lua')
table.insert(Sprites, ButtonSprite("hud-ammo-sbpp_b52", "context/HUD-b52", nil, nil, nil, nil, path))
table.insert(Sprites,
	{
		Name = "sbpp_b52_runway",
		States =
		{
			Normal = { Frames = { { texture = path .. "/weapons/b52/b52_runway.png" }, mipmap = true, }, },
			Idle = Normal,
			Reload =
			{
				Frames =
				{
					{ texture = path .. "/weapons/b52/b52_runway.png", duration = 120, colour = {0,0,0,0} },
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
		AmmoSprites = { { Node = "Head", Sprite = "sbpp_b52_runway", }, },
		Sprite = "hud-ammo-sbpp_b52",
		Devices = { {Name = "ammo_sbpp_b52", Consume = true}, },
		Weapons = { "sbpp_runway3" },
		MinFireSpeed = 3000,
		MaxFireSpeed = 3000.1,
		Projectile = "sbpp_b52",
		HeatPerRound = 0.4,
	}
}