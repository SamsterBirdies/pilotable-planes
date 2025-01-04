dofile("mods/dlc2/devices/ammo_nighthawk.lua")
Sprites = {}
ConsumeEffect = "mods/dlc2/effects/ammo_consumption.lua"
--DestroyEffect = path .. "/effects/biplane_explode.lua"
Root = 
{
	Sprite = path .. "/devices/mig15Ammo.png",
	Name = "ammo_mig15",
	ChildrenInFront = {},
	Angle = 0,
	Pivot = {0,-0.5},
	PivotOffset = {0,0}
}

dofile('ui/uihelper.lua')
table.insert(Sprites, ButtonSprite("hud-ammo-sbpp_mig15", "context/HUD-mig15", nil, nil, nil, nil, path))
table.insert(Sprites,
	{
		Name = "sbpp_mig15_runway",
		States =
		{
			Normal = { Frames = { { texture = path .. "/weapons/mig15/mig15_runway.png" }, mipmap = true, }, },
			Idle = Normal,
			Reload =
			{
				Frames =
				{
					{ texture = path .. "/weapons/mig15/mig15_runway.png", duration = 120, colour = {0,0,0,0} },
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
		AmmoSprites = { { Node = "Head", Sprite = "sbpp_mig15_runway", }, },
		Sprite = "hud-ammo-sbpp_mig15",
		Devices = { {Name = "ammo_sbpp_mig15", Consume = true}, },
		Weapons = { "runway", "runway2", "sbpp_runway3" },
		MinFireSpeed = 3000,
		MaxFireSpeed = 3000.1,
		Projectile = "sbpp_mig15",
		HeatPerRound = 0.4,
	}
}