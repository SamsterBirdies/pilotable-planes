dofile("mods/dlc2/devices/ammo_nighthawk.lua")
Sprites = {}
ConsumeEffect = "mods/dlc2/effects/ammo_consumption.lua"
--DestroyEffect = path .. "/effects/biplane_explode.lua"
Root = 
{
	Sprite = path .. "/devices/zeroAmmo.png",
	Name = "ammo_f16",
	ChildrenInFront = {},
	Angle = 0,
	Pivot = {0,-0.5},
	PivotOffset = {0,0}
}

dofile('ui/uihelper.lua')
table.insert(Sprites, ButtonSprite("hud-ammo-sbpp_zero", "context/HUD-zero", nil, nil, nil, nil, path))
table.insert(Sprites,
	{
		Name = "sbpp_zero_runway",
		States =
		{
			Normal = { Frames = { { texture = path .. "/weapons/zero/zero_runway.png" }, mipmap = true, }, },
			Idle = Normal,
			Reload =
			{
				Frames =
				{
					{ texture = path .. "/weapons/zero/zero_runway.png", duration = 120, colour = {0,0,0,0} },
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
		AmmoSprites = { { Node = "Head", Sprite = "sbpp_zero_runway", }, },
		Sprite = "hud-ammo-sbpp_zero",
		Devices = { {Name = "ammo_sbpp_zero", Consume = true}, },
		Weapons = { "runway", "runway2", "sbpp_runway3" },
		MinFireSpeed = 2200,
		MaxFireSpeed = 2200.1,
		Projectile = "sbpp_zero",
		HeatPerRound = 0.4,
		RowName = "mk1",
	}
}