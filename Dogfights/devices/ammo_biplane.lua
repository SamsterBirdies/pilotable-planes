dofile("mods/dlc2/devices/ammo_nighthawk.lua")
Sprites = {}
ConsumeEffect = "mods/dlc2/effects/ammo_consumption.lua"
DestroyEffect = path .. "/effects/biplane_explode.lua"
HitPoints = 90
Root = 
{
	Sprite = path .. "/devices/biplaneAmmo.png",
	Name = "ammo_biplane",
	ChildrenInFront = {},
	Angle = 0,
	Pivot = {0,-0.5},
	PivotOffset = {0,0}
}

dofile('ui/uihelper.lua')
table.insert(Sprites, ButtonSprite("hud-ammo-sbpp_BiplaneFlechette", "context/HUD-biplaneFlechette", nil, nil, nil, nil, path))
table.insert(Sprites,
	{
		Name = "sbpp_RunwayBiplane",
		States =
		{
			Normal = { Frames = { { texture = path .. "/weapons/biplane/biplaneRunway.png" }, mipmap = true, }, },
			Idle = Normal,
			Reload =
			{
				Frames =
				{
					{ texture = path .. "/weapons/biplane/biplaneRunway.png", duration = 120, colour = {0,0,0,0} },
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
		AmmoSprites = { { Node = "Head", Sprite = "sbpp_RunwayBiplane", }, },
		Sprite = "hud-ammo-sbpp_BiplaneFlechette",
		Devices = { {Name = "ammo_sbpp_Biplane", Consume = true}, },
		Weapons = { "runway", "runway2" },
		MinFireSpeed = 2000,
		MaxFireSpeed = 2000.1,
		Projectile = "sbpp_Biplane",
		HeatPerRound = 0.19,
	}
}