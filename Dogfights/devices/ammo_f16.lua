dofile("mods/dlc2/devices/ammo_nighthawk.lua")
Sprites = {}
ConsumeEffect = "mods/dlc2/effects/ammo_consumption.lua"
--DestroyEffect = path .. "/effects/biplane_explode.lua"
Root = 
{
	Sprite = path .. "/devices/f16Ammo.png",
	Name = "ammo_f16",
	ChildrenInFront = {},
	Angle = 0,
	Pivot = {0,-0.5},
	PivotOffset = {0,0}
}

dofile('ui/uihelper.lua')
table.insert(Sprites, ButtonSprite("hud-ammo-sbpp_f16", "context/HUD-f16", nil, nil, nil, nil, path))
table.insert(Sprites,
	{
		Name = "sbpp_f16_runway",
		States =
		{
			Normal = { Frames = { { texture = path .. "/weapons/f16/f16_runway.png" }, mipmap = true, }, },
			Idle = Normal,
			Reload =
			{
				Frames =
				{
					{ texture = path .. "/weapons/f16/f16_runway.png", duration = 120, colour = {0,0,0,0} },
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
		AmmoSprites = { { Node = "Head", Sprite = "sbpp_f16_runway", }, },
		Sprite = "hud-ammo-sbpp_f16",
		Devices = { {Name = "ammo_sbpp_f16", Consume = true}, },
		Weapons = { "runway2", "sbpp_runway3" },
		MinFireSpeed = 3600,
		MaxFireSpeed = 3600.1,
		Projectile = "sbpp_f16",
		HeatPerRound = 0.4,
	}
}