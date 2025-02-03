dofile("scripts/type.lua")
dofile(path .. "/scripts/better_log.lua")
sbpp_path = path
--temp projectile func
function sbpp_TempProjectile(name, delay)
	local projectile = DeepCopy(FindProjectile(name))
	projectile.SaveName = "sbpp_temp_" .. projectile.SaveName
	projectile.CollidesWithProjectiles = false
	projectile.Effects.Age = 
	{
		["t" .. tostring(delay)] = {Effect = nil, Projectile = { Count = 1, Type = name, StdDev = 0 }, Offset = 0, Terminate = true, Splash = false}
	}
	table.insert(Projectiles, projectile)
end
--make the thingie
function sbpp_Firebeams(name, radius, multiplier)
	local projectile = FindProjectile(name)
	if not projectile then return end
	projectile['Field' .. 'Radius'] = radius
	projectile['Field' .. 'Type'] = FIELD_BLOCK_BEAMS
	projectile.CollidesWithBeams = true
	projectile.Effects.Impact.firebeam = nil
	SetDamageMultiplier('firebeam', { SaveName = name, AntiAir = multiplier })
end

--change aa
local flak = FindProjectile('flak')
if flak then
	flak.MaxAge = 2.8
end
local shotgun = FindProjectile('shotgun')
if shotgun then
	shotgun.AntiAirDamage = 30
	shotgun.MinAge = 6
	shotgun.MaxAge = 30
	shotgun.ExpiresOnFreeFall = true
end
local machinegun = FindProjectile('machinegun')
if machinegun then
	machinegun.MinAge = 10
	machinegun.MaxAge = 30
end
local mg50 = DeepCopy(machinegun)
if mg50 then
	mg50.SaveName = "sbpp_machinegun50cal"
	mg50.ProjectileDamage = mg50.ProjectileDamage * 1.5
	mg50.WeaponDamageBonus = mg50.WeaponDamageBonus * 1.5
	table.insert(Projectiles, mg50)
	MakeFlamingVersion("sbpp_machinegun50cal", 1.33, 0.24, flamingTrail, 150, nil, genericFlamingExpire)
end
local mgsmall = DeepCopy(machinegun)
if mgsmall then
	mgsmall.SaveName = "sbpp_machinegunsmall"
	mgsmall.ProjectileDamage = mgsmall.ProjectileDamage * 0.6
	table.insert(Projectiles, mgsmall)
	MakeFlamingVersion("sbpp_machinegunsmall", 1.33, 0.24, flamingTrail, 150, nil, genericFlamingExpire)
end
--plane changes
local thunderbolt = FindProjectile("thunderbolt")
if thunderbolt then
	thunderbolt.dlc2_Bombs = nil
	thunderbolt.MaxAge = 1984
	thunderbolt.Effects.Age = {}
	thunderbolt.ProjectileDrag = 4
	thunderbolt.Gravity = 981
	thunderbolt.TrailEffect = nil
	thunderbolt.ProjectileDamage = 290
	thunderbolt.ProjectileSplashDamage = 110
	thunderbolt.ExplodeOnTouch = false
	thunderbolt.CanBeShotDown = true
	thunderbolt.AntiAirHitpoints = thunderbolt.AntiAirHitpoints * 1.2-- * 1.5
	thunderbolt.sb_planes =
	{
		elevator = 50000,
		thrust = 15000,
		throttle_min = 0.65,
		throttle_max = 1.25,
		lift_multiplier = 4.3,
		lift_max_speed = 3700,
		advanced_physics = true,
		--transfer_control = true, --makes plane control get transfered to a child projectile spawned with age or impact effects.
		--submarine = true, --makes plane only work underwater
		trail_effect = path .. "/effects/trail_jet",
		RCS = 10,
		weapon1 = 
		{
			projectile = "sbpp_temp_sbpp_gau8",
			rotation = 0.12, 
			distance = 25, 
			speed = 3000, 
			count = 24, 
			period = 0.08, 
			timer = 6,
			bank_timer = 15,
			bank_max = 2,
			bank_start = 1,
			stddev = 0.04, 
			effect = path .. "/effects/a10_fire.lua",
			reload_effect = path .. "/effects/reload_gun_large.lua",
			name = "$Weapon.sbpp_gau8",
		},
		weapon2 = 
		{
			projectile = "sbpp_temp_bomb",
			rotation = 1.5708, 
			distance = 1, 
			speed = 350, 
			count = 4, 
			period = 0.06, 
			timer = 8,
			bank_timer = 20,
			bank_max = 2,
			bank_start = 1,
			stddev = 0, 
			effect = "mods/dlc2/effects/bomb_release.lua", 
			reload_effect = path .. "/effects/reload_bomb.lua",
			name = "$Weapon.sbpp_bombs",
		},
		weapon3 =
		{
			projectile = "sbpp_flare",
			rotation = 0.0,
			distance = 25,
			speed = 6500,
			count = 5,
			period = 0.24,
			perround = 4,
			timer = 15,
			bank_start = 0,
			stddev = 3,
			effect = path .. "/effects/flare_launch.lua",
			reload_effect = path .. "/effects/reload_bomb.lua",
			name = "$Weapon.sbpp_flares",
		}
	}
	sbpp_Firebeams('thunderbolt', 150, 400)
end
local nighthawk = FindProjectile("nighthawk")
if nighthawk then
	nighthawk.dlc2_Bombs = nil
	nighthawk.MaxAge = 1984
	nighthawk.Effects.Age = {}
	nighthawk.ProjectileDrag = 4
	nighthawk.Gravity = 981
	nighthawk.TrailEffect = nil
	nighthawk.ProjectileDamage = 150
	nighthawk.ProjectileSplashDamage = 110
	nighthawk.ExplodeOnTouch = false
	nighthawk.CanBeShotDown = true
	nighthawk.AntiAirHitpoints = nighthawk.AntiAirHitpoints * 0.9-- * 1.5
	nighthawk.sb_planes =
	{
		elevator = 50000,
		thrust = 15000,
		throttle_min = 0.6,
		throttle_max = 1.4,
		lift_multiplier = 4.3,
		lift_max_speed = 3700,
		advanced_physics = true,
		RCS = 0.003, --radar cross section 0.003m2
		trail_effect = path .. "/effects/trail_jet",
		weapon1 = 
		{
			projectile = "sbpp_temp_paveway", 
			rotation = 1.5708, 
			distance = 1, 
			speed = 350,
			count = 1,
			period = 0.041,
			timer = 5,
			bank_max = 2,
			bank_start = 1,
			bank_timer = 20,
			stddev = 0,
			fire_cost_energy = 1500,
			effect = "mods/dlc2/effects/bomb_release.lua",
			reload_effect = path .. "/effects/reload_bomb.lua",
			name = "$Weapon.sbpp_paveway"
		},
	}
	sbpp_Firebeams('nighthawk', 150, 500)
end
local bomb = FindProjectile("bomb")
if bomb then
	bomb.MaxAge = 60
	bomb.ProjectileDrag = 8
	bomb.Gravity = 981 * 2
	bomb.ProjectileSplashDamageMaxRadius = bomb.ProjectileSplashDamageMaxRadius * 1.35
	bomb.ProjectileDamage = bomb.ProjectileDamage * 2
	--bomb.AntiAirHitpoints = bomb.AntiAirHitpoints * 2
end
local paveway = FindProjectile("paveway")
if paveway then
	paveway.MaxAge = 60
	paveway.ProjectileDrag = 8
	paveway.Gravity = 981 * 2
	paveway.AntiAirHitpoints = paveway.AntiAirHitpoints * 1.5
end

--new projectiles
--gau8 (modified 20mm)
table.insert(Projectiles,
{
	SaveName = "sbpp_gau8",

	ProjectileType = "mortar",
	ProjectileSprite = "weapons/media/bullet",
	ProjectileSpriteMipMap = false,
	DrawBlurredProjectile = true,
	ProjectileMass = 16,
	ProjectileDrag = 0,
	Impact = 20000,
	DisableShields = false,
	DeflectedByShields = true,
	PassesThroughMaterials = false,
	ExplodeOnTouch = false,
	ProjectileThickness = 4.0,
	ProjectileShootDownRadius = 50,
	BeamTileRate = 0.02,
	BeamScrollRate = 0.0,
	ProjectileDamage = 60.0,
	ProjectileSplashDamage = 30.0, -- low splash damage
	ProjectileSplashDamageMaxRadius = 100.0,
	ProjectileSplashMaxForce = 10000, -- moderate shockwave
	WeaponDamageBonus = 20,
	AntiAirHitpoints = 20,
	AntiAirDamage = 20,
	SpeedIndicatorFactor = 0.25,

	TrailEffect = path .. "/effects/trail_gau8.lua",

	Effects =
	{
		Impact =
		{
			["default"] = "effects/impact_medium.lua",
		},	
		Deflect =
		{
			["armour"] = { Effect = "effects/armor_ricochet.lua" },
			["door"] = { Effect = "effects/armor_ricochet.lua" },
			["shield"] = { Effect = "effects/energy_shield_ricochet.lua" },
		},
	},

	DamageMultiplier =
	{
		{ SaveName = "sandbags", Direct = 0.6, Splash = 0.6 },
		{ SaveName = "weapon", Direct = 1.5, Splash = 2 },
		{ SaveName = "shield", Direct = 0, Splash = 0 },
	},
})
MakeFlamingVersion("sbpp_gau8", 1.33, 0.25, flamingTrail, 100, nil, genericFlamingExpire)
--biplane
dofile(path .. "/weapons/biplane/projectiles.lua")
--f16
local f16 = DeepCopy(FindProjectile("nighthawk"))
if f16 then
	f16.SaveName = "sbpp_f16"
	f16.Projectile =
	{
		Root =
		{
			Name = "Root",
			Angle = -90,
			Sprite = path .. "/weapons/f16/f16.png",
			PivotOffset = {0, 0},
			Scale = 1.08,
		}
	}
	f16.sb_planes =
	{
		elevator = 60000,
		thrust = 15000,
		throttle_min = 0.5,
		throttle_max = 1.85,
		lift_multiplier = 4.3,
		lift_max_speed = 3700,
		advanced_physics = true,
		trail_effect = path .. "/effects/trail_jet",
		RCS = 5,
		weapon1 = 
		{
			projectile = "sbpp_temp_sbpp_vulcan",
			rotation = 0.0, 
			distance = 25, 
			speed = 7000,
			count = 60, 
			period = 0.04, 
			timer = 4,
			bank_timer = 12,
			bank_max = 3,
			bank_start = 3,
			stddev = 0.03, 
			effect = path .. "/effects/vulcan_fire.lua",
			reload_effect = path .. "/effects/reload_gun.lua",
			name = "$Weapon.sbpp_vulcan",
		},
		weapon2 = 
		{
			projectile = "sbpp_temp_sbpp_sidewinder",
			rotation = 0.0, 
			distance = 25, 
			speed = 4000, 
			count = 6, 
			period = 0.2, 
			timer = 12,
			stddev = 0.02,
			effect = path .. "/effects/rocket_launchdop.lua",
			reload_effect = path .. "/effects/reload_bomb.lua",
			name = "$Weapon.sbpp_sidewinders",
		},
		weapon3 =
		{
			projectile = "sbpp_flare",
			rotation = 0.0,
			distance = 25,
			speed = 6500,
			count = 6,
			period = 0.24,
			perround = 3,
			timer = 10,
			bank_start = 0,
			stddev = 4,
			effect = path .. "/effects/flare_launch.lua",
			reload_effect = path .. "/effects/reload_bomb.lua",
			name = "$Weapon.sbpp_flares",
		}
	}
	table.insert(Projectiles, f16)
	MakeFlamingVersion("sbpp_f16", 1.33, 10, flamingTrail, 100, nil, genericFlamingExpire)
	sbpp_Firebeams('sbpp_f16', 150, 600)
end
local sidewinder = DeepCopy(FindProjectile("cannon"))
if sidewinder then
	sidewinder.SaveName = "sbpp_sidewinder"
	sidewinder.ProjectileDamage = 100
	sidewinder.ProjectileSplashDamage = 75
	sidewinder.ProjectileSplashDamageMaxRadius = 150
	sidewinder.TrailEffect = "effects/swarm_trail.lua"
	sidewinder.ProjectileSprite = nil
	sidewinder.ProjectileSpriteMipMap = true
	sidewinder.DrawBlurredProjectile = false
	sidewinder.AntiAirHitpoints = 11
	sidewinder.AntiAirDamage = 150
	sidewinder.ProjectileShootDownRadius = 125
	sidewinder.Gravity = 1
	sidewinder.Projectile =
	{
		Root =
		{
			Name = "Root",
			Angle = 0,
			Sprite = path .. "/weapons/projectiles/sidewinder.png",
			PivotOffset = {0, 0},
			Scale = 1.0,
			ChildrenInFront =
			{
				{
					Name = "Flame",
					Angle = 0,
					Offset = { 0, 0.5 },
					Pivot = { 0, 0.5 },
					PivotOffset = { 0, 0 },
					Sprite = "missile_swarm_tail",
				},
			},
		}
	}
	sidewinder.Effects =
	{
		Impact = 
		{
			default = "mods/weapon_pack/effects/rocket_structure_hit.lua",
		}
	}
	sidewinder.ExplodeOnTouch = true
	table.insert(Projectiles, sidewinder)
	MakeFlamingVersion("sbpp_sidewinder", 1.33, 1, flamingTrail, 150, nil, genericFlamingExpire)
end
local vulcan = DeepCopy(FindProjectile("sniper"))
if vulcan then
	vulcan.SaveName = "sbpp_vulcan"
	vulcan.WeaponDamageBonus = 20
	vulcan.ProjectileDamage = 30
	vulcan.AntiAirHitpoints = 6
	vulcan.AntiAirDamage = 20
	vulcan.TrailEffect = nil
	vulcan.ProjectileShootDownRadius = 50
	table.insert(Projectiles, vulcan)
	MakeFlamingVersion("sbpp_vulcan", 1.33, 0.24, flamingTrail, 150, nil, genericFlamingExpire)
end
--p51
local p51 = DeepCopy(FindProjectile("nighthawk"))
if p51 then
	table.insert(Sprites, 
	{
		Name = "sbpp_p51_prop",
		States =
		{
			Normal = { Frames =
			{
				{ texture = path .. "/weapons/p51/prop0.dds",},
				{ texture = path .. "/weapons/p51/prop3.dds",},
				{ texture = path .. "/weapons/p51/prop2.dds",},
				{ texture = path .. "/weapons/p51/prop1.dds",},
				mipmap = true,
				duration = 0.04,
			},},
			Idle = Normal,
		},
	})
	p51.SaveName = "sbpp_p51"
	p51.Projectile =
	{
		Root =
		{
			Name = "Root",
			Angle = -90,
			Sprite = path .. "/weapons/p51/mustang.png",
			PivotOffset = {0, 0},
			Scale = 0.81,
			ChildrenInFront =
			{	
				{
					Name = "Prop",
					Angle = 0,
					Sprite = "sbpp_p51_prop",
					PivotOffset = {0,0},
					Pivot = {0.43359375, 0.013020834},
				}
			}
		}
	}
	p51.sb_planes =
	{
		elevator = 34000,
		thrust = 13000,
		throttle_min = 0.6,
		throttle_max = 1.3,
		lift_multiplier = 5.3,
		lift_max_speed = 3000,
		advanced_physics = true,
		trail_effect = path .. "/effects/trail_p51",
		RCS = 5,
		weapon1 = 
		{
			projectile = "sbpp_temp_sbpp_machinegun50cal",
			rotation = 0.0, 
			distance = 25, 
			speed = 6000,
			count = 12,
			perround = 6,
			period = 0.16, 
			timer = 9, 
			stddev = 0.03, 
			effect = path .. "/effects/50cal_fire.lua",
			reload_effect = path .. "/effects/reload_gun.lua",
			name = "$Weapon.sbpp_50cal",
		},
		weapon2 = 
		{
			projectile = "sbpp_temp_sbpp_bomb250kg",
			rotation = 1.5708, 
			distance = 1, 
			speed = 350, 
			count = 2, 
			period = 0.12, 
			timer = 17,
			stddev = 0, 
			effect = "mods/dlc2/effects/bomb_release.lua", 
			reload_effect = path .. "/effects/reload_bomb.lua",
			name = "$Weapon.sbpp_bomb250kg",
		},
	}
	p51.AntiAirHitpoints = p51.AntiAirHitpoints * 0.75
	table.insert(Projectiles, p51)
	MakeFlamingVersion("sbpp_p51", 1.33, 10, flamingTrail, 100, nil, genericFlamingExpire)
	sbpp_Firebeams('sbpp_p51', 150, 450)
end
local hellcat = DeepCopy(p51)
if hellcat then
	hellcat.SaveName = "sbpp_hellcat"
	hellcat.Projectile.Root.Sprite = path .. "/weapons/hellcat/hellcat.png"
	hellcat.Projectile.Root.ChildrenInFront[1].Pivot = {0.4296875, -0.02604167} 
	hellcat.AntiAirHitpoints = hellcat.AntiAirHitpoints * 1.4-- * 1.5
	hellcat.sb_planes.thrust = 11000
	hellcat.sb_planes.elevator = 29000
	hellcat.sb_planes.lift_multiplier = 6
	hellcat.sb_planes.weapon1.count = 11
	hellcat.sb_planes.weapon1.timer = 8
	hellcat.sb_planes.weapon1.stddev = 0.035
	hellcat.sb_planes.weapon2.timer = 13
	hellcat.sb_planes.trail_effect = path .. "/effects/trail_hellcat"
	table.insert(Projectiles, hellcat)
	MakeFlamingVersion("sbpp_hellcat", 1.33, 10, flamingTrail, 100, nil, genericFlamingExpire)
	sbpp_Firebeams('sbpp_hellcat', 150, 400)
end
local bomb250kg = DeepCopy(FindProjectile("bomb"))
if bomb250kg then
	bomb250kg.SaveName = "sbpp_bomb250kg"
	bomb250kg.ProjectileDamage = 250
	bomb250kg.ProjectileSplashDamage = 175
	bomb250kg.ProjectileSplashDamageMaxRadius = 200
	bomb250kg.Effects.Impact =
	{
		default = "mods/dlc2/effects/impact_turret.lua",
	}
	bomb250kg.Projectile =
	{
		Root =
		{
			Name = "Root",
			Angle = 0,
			Sprite = path .. "/weapons/projectiles/bomb.png",
			PivotOffset = {0, 0},
			Scale = 1.5,
		}
	}
	bomb250kg.ProjectileSprite = nil
	--bomb250kg.AntiAirHitpoints = bomb250kg.AntiAirHitpoints * 2.5
	table.insert(Projectiles, bomb250kg)
	MakeFlamingVersion("sbpp_bomb250kg", 1.33, 3, flamingTrail, 100, nil, genericFlamingExpire)
end
--ac130
local ac130 = DeepCopy(FindProjectile("nighthawk"))
if ac130 then
	table.insert(Sprites, 
	{
		Name = "sbpp_ac130_prop",
		States =
		{
			Normal = { Frames =
			{
				{ texture = path .. "/weapons/ac130/prop0.dds",},
				{ texture = path .. "/weapons/ac130/prop1.dds",},
				mipmap = true,
				duration = 0.04,
			},},
			Idle = Normal,
		},
	})
	ac130.SaveName = "sbpp_ac130"
	ac130.Projectile =
	{
		Root =
		{
			Name = "Root",
			Angle = -90,
			Sprite = path .. "/weapons/ac130/ac130.png",
			PivotOffset = {-0.115234, 0.0156},
			Scale = 2,
			ChildrenInFront =
			{	
				{
					Name = "Prop",
					Angle = 0,
					Sprite = "sbpp_ac130_prop",
					PivotOffset = {0,0},
					Pivot = {0.1982421875, 0.005859375},
				}
			}
		}
	}
	ac130.AntiAirHitpoints = ac130.AntiAirHitpoints * 2-- * 1.5
	ac130.ProjectileShootDownRadius = ac130.ProjectileShootDownRadius * 1.5
	ac130.ProjectileDamage = ac130.ProjectileDamage * 1.8
	ac130.ProjectileSplashDamage = ac130.ProjectileSplashDamage * 1.8
	ac130.ProjectileSplashDamageMaxRadius = ac130.ProjectileSplashDamageMaxRadius * 1.9
	ac130.ProjectileSplashMaxForce = 650000
	ac130.IncendiaryRadius = 200
	ac130.WeaponDamageBonus = 300
	ac130.Effects.Impact =
	{
		default = path .. "/effects/HUGE_EXPLOSION.lua",
	}
	ac130.sb_planes =
	{
		elevator = 20000,
		thrust = 12000,
		throttle_min = 0.6,
		throttle_max = 1.2,
		lift_multiplier = 5.4,
		lift_max_speed = 3000,
		advanced_physics = true,
		trail_effect = path .. "/effects/trail_ac130",
		RCS = 5,
		weapon1 = 
		{
			projectile = "sbpp_temp_sbpp_gau12",
			rotation = 0.0, 
			distance = 25, 
			speed = 5000,
			count = 20, 
			period = 0.08, 
			timer = 6,
			bank_timer = 16,
			bank_max = 3,
			bank_start = 1,
			stddev = 0.03,
			aimed = true,
			max_aim = 0,
			min_aim = 3.14,
			fire_cost_metal = 10,
			fire_cost_energy = 1200,
			effect = path .. "/effects/a10_fire.lua",
			reload_effect = path .. "/effects/reload_gun_large.lua",
			name = "$Weapon.sbpp_gau12",
		},
		weapon2 = 
		{
			projectile = "sbpp_temp_sbpp_bofors",
			rotation = 0.0, 
			distance = 25,  
			speed = 5000, 
			count = 1, 
			period = 0.06, 
			timer = 0.8,
			bank_timer = 4,
			bank_max = 5,
			bank_start = 2,
			stddev = 0,
			aimed = true,
			max_aim = 0,
			min_aim = 3.14,
			fire_cost_metal = 10,
			fire_cost_energy = 500,
			effect = path .. "/effects/fire_20mmdop.lua", 
			name = "$Weapon.sbpp_bofors",
		},
		weapon3 = 
		{
			projectile = "sbpp_temp_sbpp_howitzer105mm",
			rotation = 0.0,
			distance = 25,
			speed = 4000,
			count = 1,
			period = 0.06,
			timer = 9,
			bank_timer = 16,
			bank_max = 2,
			bank_start = 1,
			stddev = 0,
			aimed = true,
			max_aim = 0,
			min_aim = 3.14,
			fire_cost_metal = 50,
			fire_cost_energy = 3000,
			effect = "effects/fire_cannon.lua",
			reload_effect = path .. "/effects/ac130_gunready.lua",
			name = "$Weapon.sbpp_howitzer105mm",
		},
	}
	table.insert(Projectiles, ac130)
	MakeFlamingVersion("sbpp_ac130", 1.33, 10, flamingTrail, 100, nil, genericFlamingExpire)
	sbpp_Firebeams('sbpp_ac130', 225, 400)
end
local gau12 = DeepCopy(FindProjectile("sbpp_gau8"))
if gau12 then
	gau12.SaveName = "sbpp_gau12"
	gau12.WeaponDamageBonus = 20
	table.insert(Projectiles, gau12)
	MakeFlamingVersion("sbpp_gau12", 1.33, 0.25, flamingTrail, 100, nil, genericFlamingExpire)
end
local bofors = DeepCopy(FindProjectile("cannon"))
if bofors then
	bofors.SaveName = "sbpp_bofors"
	bofors.DisableShields = false
	bofors.DeflectedByShields = true
	bofors.DestroyShields = false
	bofors.ProjectileDamage = 250
	bofors.ProjectileSplashDamage = 75
	bofors.ProjectileSplashDamageMaxRadius = 170
	bofors.Effects.Impact =
	{
		default = "mods/weapon_pack/effects/rocket_structure_hit.lua",
	}
	bofors.DamageMultiplier =
	{
		{ SaveName = "shield", Direct = 0, Splash = 0 },
		{ SaveName = "backbracing", Direct = 0, Splash = 0.75 },
	}
	table.insert(Projectiles, bofors)
	MakeFlamingVersion("sbpp_bofors", 1.33, 0.4, flamingTrail, 100, nil, genericFlamingExpire)
end
local howitzer105 = DeepCopy(FindProjectile("mortar2"))
if howitzer105 then
	howitzer105.SaveName = "sbpp_howitzer105mm"
	howitzer105.ProjectileDamage = 400
	howitzer105.ProjectileSplashDamage = 250
	howitzer105.ProjectileSplashDamageMaxRadius = 250
	howitzer105.ProjectileSplashMaxForce = 420000
	howitzer105.DisableShields = false
	howitzer105.Effects.Impact = 
	{
		default = "mods/dlc2/effects/impact_paveway.lua",
	}
	howitzer105.DamageMultiplier =
	{
		{ SaveName = "shield", Direct = 0, Splash = 0.2 },
		{ SaveName = "backbracing", Direct = 0, Splash = 0.4 },
		{ SaveName = "sandbags", Direct = 0.5, Splash = 0.5 },
	}
	howitzer105.Projectile.Root.Sprite = path .. "/weapons/projectiles/howitzer.png"
	howitzer105.Projectile.Root.Scale = 1.5
	howitzer105.ProjectileShootDownRadius = 15
	howitzer105.AntiAirHitpoints = 60 * 1.5
	howitzer105.TrailEffect = "effects/cannon_trail.lua"
	table.insert(Projectiles, howitzer105)
	MakeFlamingVersion("sbpp_howitzer105mm", 1.33, 0.5, flamingTrail, 100, nil, genericFlamingExpire)
end

--apache
local heliwind = DeepCopy(FindProjectile("mortar"))
if heliwind then
	heliwind.SaveName = "sbpp_heliwind"
	heliwind.CollidesWithProjectiles = false
	heliwind.Projectile = nil
	heliwind.Effects = nil
	heliwind.ProjectileSprite = path .. "/blank.png"
	heliwind.Gravity = 1
	heliwind.MaxAge = 0.75
	heliwind.MaxAgeUnderwater = 0.04
	heliwind.UnderwaterFadeDuration = 0.04
	heliwind.ProjectileIncendiary = false
	heliwind.IgnitesBackgroundMaterials = false
	heliwind.ProjectileDamage = 0
	heliwind.ProjectileSplashDamage = 0
	heliwind.ProjectileSplashDamageMaxForce = 20000
	heliwind.ProjectileSplashDamageMaxRadius = heliwind.ProjectileSplashDamageMaxRadius * 2.5
	heliwind.DrawBlurredProjectile = false
	heliwind.TrailEffect = nil
	heliwind.ProjectileType = "bullet"
	table.insert(Projectiles, heliwind)
end
local apache = DeepCopy(FindProjectile("nighthawk"))
if apache then
	apache.SaveName = "sbpp_apache"
	apache.Projectile = nil
	apache.ProjectileSprite = nil
	apache.ProjectileDrag = 1.7
	apache.ProjectileMass = 5
	apache.AntiAirHitpoints = apache.AntiAirHitpoints * 1.5
	apache.ExplodeOnTouch = true
	apache.ProjectileAgeTrigger = false
	--apache.MaxAgeUnderwater = 999
	--apache.UnderwaterFadeDuration = 999
	apache.sb_planes =
	{
		elevator = 2,
		thrust = 5030,
		throttle_min = 0.8,
		throttle_max = 1.2,
		helicopter = true,
		--submarine = true,
		sprite = path .. "/effects/apache",
		trail_effect = path .. "/effects/trail_heli",
		--angle_max = 0.5,
		RCS = 5,
		weapon1 = 
		{
			projectile = "sbpp_temp_cannon20mm",
			rotation = 0.0, 
			distance = 25, 
			speed = 4500,
			count = 8, 
			period = 0.2, 
			timer = 14, 
			stddev = 0.03,
			effect = path .. "/effects/fire_20mmdop.lua",
			reload_effect = path .. "/effects/reload_gun_large.lua",
			name = "$Weapon.sbpp_chaingun",
		},
		weapon2 = 
		{
			projectile = "sbpp_temp_sbpp_hydra",
			rotation = 0.0, 
			distance = 25,  
			speed = 2000, 
			count = 9, 
			period = 0.20, 
			timer = 20,
			stddev = 0.04,
			effect = path .. "/effects/apache_hydra.lua",
			reload_effect = path .. "/effects/reload_bomb.lua",
			name = "$Weapon.sbpp_hydra",
		},
		weapon3 = 
		{
			projectile = "sbpp_temp_sbpp_hellfire",
			rotation = 0.0,
			distance = 25,
			speed = 4000,
			count = 1,
			period = 0.06,
			aim_missile = true,
			timer = 20,
			stddev = 0,
			effect = path .. "/effects/apache_hellfire.lua",
			reload_effect = path .. "/effects/reload_missile.lua",			
			name = "$Weapon.sbpp_hellfire",
		},
	}
	apache.Effects.Impact.firebeam = nil
	--BetterLog(apache.Effects.Age)
	table.insert(Projectiles, apache)
	sbpp_Firebeams('sbpp_apache', 150, 300)
	--hydra rocket
	local sbApacheHydra = DeepCopy(FindProjectile("missile"))
	if sbApacheHydra then
		sbApacheHydra.SaveName = "sbpp_hydra"
		sbApacheHydra.Missile.RocketThrust = 130000
		sbApacheHydra.Missile.MaxSteerPerSecond = 30
		sbApacheHydra.Missile.MaxSteerPerSecondErratic = 100
		sbApacheHydra.Missile.ThrustAngleExtent = 10
		sbApacheHydra.Missile.ErraticAngleExtentStdDev = 2.5
		SetDamageMultiplier("sbpp_hydra", {SaveName = "bracing", Direct = 2})
		sbApacheHydra.ProjectileIncendiary = false
		sbApacheHydra.Gravity = 0
		sbApacheHydra.ProjectileSplashDamage = 35
		sbApacheHydra.AntiAirDamage = 70
		sbApacheHydra.ProjectileSplashDamageMaxRadius = 160
		sbApacheHydra.Projectile.Root.Sprite = path .. "/weapons/projectiles/hydra.png"
		sbApacheHydra.Projectile.Root.Scale = 0.75
		--sbApacheHydra.Effects = DeepCopy(FindProjectile("bomb").Effects)
		table.insert(Projectiles, sbApacheHydra)
		MakeFlamingVersion("sbpp_hydra", 1.33, 2.5, flamingSwarmTrail, 75, nil, genericFlamingExpire)
	end
	--hellfire missile
	local sbApacheHellfire = DeepCopy(FindProjectile("missile2"))
	if sbApacheHellfire then
		sbApacheHellfire.SaveName = "sbpp_hellfire"
		sbApacheHellfire.Missile.RocketThrust = 130000
		sbApacheHellfire.Missile.MaxSteerPerSecond = 30
		sbApacheHellfire.Missile.MaxSteerPerSecondErratic = 100
		sbApacheHellfire.Missile.ThrustAngleExtent = 10
		sbApacheHellfire.Missile.ErraticAngleExtentStdDev = 2.5
		sbApacheHellfire.ProjectileIncendiary = true
		sbApacheHellfire.AlwaysIncendiary = true
		sbApacheHellfire.IncendiaryRadius = 180
		sbApacheHellfire.IncendiaryRadiusHeated = 220
		sbApacheHellfire.ProjectileSplashDamageMaxRadius = 260
		sbApacheHellfire.ProjectileSplashDamage = 200
		sbApacheHellfire.AntiAirDamage = 200
		sbApacheHellfire.AntiAirHitpoints = 16
		sbApacheHellfire.Projectile.Root.Sprite = path .. "/weapons/projectiles/hellfire.png"
		sbApacheHellfire.Projectile.Root.ChildrenInFront[1].Pivot = {0, 0.5}
		if FindProjectile("paveway") then
			sbApacheHellfire.Effects = DeepCopy(FindProjectile("paveway").Effects)
		end
		table.insert(Projectiles, sbApacheHellfire)
		MakeFlamingVersion("sbpp_hellfire", 1.33, 2.5, flamingTrail, 225, nil, rocketFlamingExpire)
	end
end
local ah6 = DeepCopy(apache)
if ah6 then
	ah6.SaveName = "sbpp_littlebird"
	ah6.AntiAirHitpoints = ah6.AntiAirHitpoints * 0.65
	ah6.sb_planes.sprite = path .. "/effects/littlebird"
	ah6.sb_planes.trail_effect = path .. "/effects/trail_heli_small"
	ah6.sb_planes.weapon1.projectile = "sbpp_temp_machinegun"
	ah6.sb_planes.weapon1.speed = 8000
	ah6.sb_planes.weapon1.count = 60
	ah6.sb_planes.weapon1.period = 0.04
	ah6.sb_planes.weapon1.perround = 2
	ah6.sb_planes.weapon1.timer = 6
	--ah6.sb_planes.weapon1.recoil = 10000
	--ah6.sb_planes.heli_effect = false
	ah6.sb_planes.weapon1.bank_timer = 18
	ah6.sb_planes.weapon1.bank_max = 2
	--ah6.sb_planes.weapon1.delay = 1
	--ah6.sb_planes.weapon1.delay_effect = "effects/fire_cannon.lua"
	ah6.sb_planes.weapon1.bank_start = 1
	ah6.ProjectileShootDownRadius = ah6.ProjectileShootDownRadius * 0.6
	ah6.FieldRadius = ah6.FieldRadius * 0.6
	ah6.sb_planes.weapon1.effect = path .. "/effects/m134_fire.lua"
	ah6.sb_planes.weapon1.name = "$Weapon.sbpp_m134"
	ah6.sb_planes.weapon3 =
	{
		projectile = "sbpp_flare",
		rotation = 0.0,
		distance = 25,
		speed = 6000,
		count = 4,
		period = 0.24,
		perround = 3,
		timer = 18,
		bank_start = 0,
		stddev = 3,
		effect = path .. "/effects/flare_launch.lua",
		reload_effect = path .. "/effects/reload_bomb.lua",
		name = "$Weapon.sbpp_flares",
	}
	table.insert(Projectiles, ah6)
	sbpp_Firebeams('sbpp_littlebird', 90, 600)
end
local mig15 = DeepCopy(FindProjectile("nighthawk"))
if mig15 then
	mig15.SaveName = "sbpp_mig15"
	mig15.Projectile =
	{
		Root =
		{
			Name = "Root",
			Angle = -90,
			Sprite = path .. "/weapons/mig15/mig15.png",
			PivotOffset = {0, 0},
			Scale = 0.81,
		}
	}
	mig15.sb_planes.weapon1 = 
	{
		projectile = "sbpp_temp_sbpp_vulcan",
		rotation = 0.0, 
		distance = 25, 
		speed = 6000,
		count = 13, 
		period = 0.12,
		perround = 2,
		timer = 9,
		stddev = 0.03, 
		effect = path .. "/effects/20mmcal_fire.lua",
		reload_effect = path .. "/effects/reload_gun.lua",
		name = "$Weapon.sbpp_mig15gun1",
	}
	mig15.sb_planes.weapon2 = 
	{
		projectile = "sbpp_temp_sbpp_mig15gun2",
		rotation = 0.0, 
		distance = 25, 
		speed = 5000,
		count = 8, 
		period = 0.12, 
		timer = 13, 
		stddev = 0.04,
		effect = path .. "/effects/fire_20mmdop.lua",
		reload_effect = path .. "/effects/reload_gun_large.lua",
		name = "$Weapon.sbpp_mig15gun2",
	}
	mig15.AntiAirHitpoints = mig15.AntiAirHitpoints * 0.9
	table.insert(Projectiles, mig15)
	MakeFlamingVersion("sbpp_mig15", 1.33, 10, flamingTrail, 100, nil, genericFlamingExpire)
	sbpp_Firebeams('sbpp_mig15', 150, 400)
end
--[[
local mig15gun1 = DeepCopy(FindProjectile("sbpp_vulcan"))
if mig15gun1 then
	mig15gun1.SaveName = "sbpp_mig15gun1"
	mig15gun1.WeaponDamageBonus = 0
	table.insert(Projectiles, mig15gun1)
	MakeFlamingVersion("sbpp_mig15gun1", 1.33, 0.25, flamingTrail, 100, nil, genericFlamingExpire)
end]]
local mig15gun2 = DeepCopy(FindProjectile("sbpp_gau12"))
if mig15gun2 then
	mig15gun2.SaveName = "sbpp_mig15gun2"
	mig15gun2.ProjectileDamage = mig15gun2.ProjectileDamage - 15
	mig15gun2.WeaponDamageBonus = 15
	table.insert(Projectiles, mig15gun2)
	MakeFlamingVersion("sbpp_mig15gun2", 1.33, 0.25, flamingTrail, 100, nil, genericFlamingExpire)
end

local spitfire = DeepCopy(FindProjectile("sbpp_hellcat"))
if spitfire then
	spitfire.SaveName = "sbpp_spitfire"
	spitfire.Projectile.Root.Sprite = path .. "/weapons/spitfire/spitfire.png"
	spitfire.Projectile.Root.ChildrenInFront[1].Pivot = {0.455, -0.04166}
	spitfire.Projectile.Root.Scale = spitfire.Projectile.Root.Scale * 0.9
	spitfire.sb_planes.throttle_max = 1.235
	spitfire.sb_planes.elevator = 32000
	spitfire.sb_planes.lift_multiplier = spitfire.sb_planes.lift_multiplier - 0.1
	spitfire.sb_planes.weapon1.projectile = "sbpp_temp_sbpp_machinegunsmall"
	spitfire.sb_planes.weapon1.effect = path .. "/effects/303cal_fire.lua"
	spitfire.sb_planes.weapon1.perround = 8
	spitfire.sb_planes.weapon1.period = 0.12
	spitfire.sb_planes.weapon1.count = 15
	spitfire.sb_planes.weapon1.name = "$Weapon.sbpp_303cal"
	spitfire.sb_planes.weapon2.projectile = "sbpp_temp_sbpp_rp3"
	spitfire.sb_planes.weapon2.rotation = 0
	spitfire.sb_planes.weapon2.speed = 3000
	spitfire.sb_planes.weapon2.effect = path .. "/effects/rocket_launchdop.lua"
	spitfire.sb_planes.weapon2.count = 1
	spitfire.sb_planes.weapon2.bank_max = 2
	spitfire.sb_planes.weapon2.bank_start = 2
	spitfire.sb_planes.weapon2.timer = 0.8
	spitfire.sb_planes.weapon2.bank_timer = 7
	spitfire.sb_planes.weapon2.name = "$Weapon.sbpp_rp3"
	spitfire.sb_planes.trail_effect = path .. "/effects/trail_p51"
	table.insert(Projectiles, spitfire)
	MakeFlamingVersion("sbpp_spitfire", 1.33, 10, flamingTrail, 100, nil, genericFlamingExpire)
	sbpp_Firebeams('sbpp_spitfire', 150, 400)
end

local rp3 = DeepCopy(FindProjectile("sbpp_sidewinder"))
if rp3 then
	rp3.SaveName = "sbpp_rp3"
	rp3.ProjectileDamage = 300
	rp3.ProjectileSplashDamage = rp3.ProjectileSplashDamage * 2
	rp3.ProjectileSplashDamageMaxRadius = rp3.ProjectileSplashDamageMaxRadius * 1.4
	rp3.Projectile =
	{
		Root =
		{
			Name = "Root",
			Angle = 0,
			Sprite = path .. "/weapons/projectiles/rp3.png",
			PivotOffset = {0, 0},
			Scale = 1.0,
			ChildrenInFront =
			{
				{
					Name = "Flame",
					Angle = 0,
					Offset = { 0, 0.5 },
					Pivot = { 0, 0.5 },
					PivotOffset = { 0, 0 },
					Sprite = "missile_swarm_tail",
				},
			},
		}
	}
	rp3.TrailEffect = "effects/missile_trail.lua"
	table.insert(Projectiles, rp3)
	MakeFlamingVersion("sbpp_rp3", 1.33, 1.5, flamingTrail, 150, nil, genericFlamingExpire)
end
local b52 = DeepCopy(FindProjectile("sbpp_ac130"))
if b52 then
	b52.SaveName = "sbpp_b52"
	b52.Projectile.Root.Sprite = path .. "/weapons/b52/b52.dds"
	b52.Projectile.Root.Scale = b52.Projectile.Root.Scale * 1.6
	b52.Projectile.Root.PivotOffset = {-0.20117, -0.125}
	b52.Projectile.Root.ChildrenInFront = {}
	b52.sb_planes.trail_effect = path .. "/effects/trail_b52"
	b52.ProjectileDamage = b52.ProjectileDamage + 410
	b52.ProjectileSplashDamage = b52.ProjectileSplashDamage * 0.75
	b52.ProjectileSplashMaxForce = 650000
	b52.AntiAirHitpoints = b52.AntiAirHitpoints * 0.7
	b52.WeaponDamageBonus = 500
	b52.ProjectileShootDownRadius = b52.ProjectileShootDownRadius * 1.3
	b52.sb_planes.elevator = 18000
	b52.sb_planes.weapon1 = 
	{
		projectile = "sbpp_temp_bomb",
		rotation = 1.5708, 
		distance = 35,
		speed = 300,
		count = 20, 
		period = 0.04, 
		timer = 3,
		bank_timer = 10,
		bank_max = 3,
		bank_start = 1,
		stddev = 0.6,
		aimed = false,
		maxangle = 0.55,
		effect = "mods/dlc2/effects/bomb_release.lua",
		reload_effect = path .. "/effects/reload_bomb.lua",
		name = "$Weapon.sbpp_bombs",
	}
	b52.sb_planes.weapon2 =
	{
		projectile = "sbpp_temp_sbpp_alcm",
		rotation = 1.5708,
		distance = 25,
		speed = 2000,
		count = 1,
		period = 0.4,
		perround = 1,
		timer = 1,
		aim_missile = true,
		bank_start = 1,
		bank_timer = 10,
		bank_max = 6,
		stddev = 0,
		maxangle = 0.55,
		effect = path .. "/effects/flare_launch.lua",
		reload_effect = path .. "/effects/reload_bomb.lua",
		name = "$Weapon.sbpp_alcm",
	}
	b52.sb_planes.weapon3 = {}
	table.insert(Projectiles, b52)
	MakeFlamingVersion("sbpp_b52", 1.33, 10, flamingTrail, 100, nil, genericFlamingExpire)
	sbpp_Firebeams('sbpp_b52', 275, 600)
	
end

local alcm = DeepCopy(FindProjectile("sbpp_hellfire"))
if alcm then
	alcm.SaveName = "sbpp_alcm"
	alcm.Projectile.Root.Sprite = path .. "/weapons/projectiles/alcm.png"
	alcm.Projectile.Root.ChildrenInFront[1].Pivot = {0.09375, 0.26923}
	alcm.Projectile.Root.ChildrenInFront[1].PivotOffset = {0, 0.4}
	alcm.MaxAge = 1984
	alcm.Missile =
	{
		ThrustAngleExtent = 8,
		ErraticAngleExtentStdDev = 0.01,
		ErraticAngleExtentMax = 0.01,
		MaxSteerPerSecond = 50,
		MaxSteerPerSecondErratic = 0.01,
		ErraticAnglePeriodMean = 0.01,
		ErraticAnglePeriodStdDev = 0.01,
		ErraticThrust = 0.01,
		ErraticThrustMagneticField = 0.01,
		LaunchThrust = 105000,
		RocketThrust = 300000,
		CruiseTargetDistance = 2000,
		CruiseTargetDuration = .5,
		TargetRearOffsetDistance = 100000,
		MinTargetUpdateDistance = 2000,
		DecoyFramesToRedirect = 2,
	}
	
	alcm.ProjectileDamage = 1000
	alcm.ProjectileSplashDamageMaxRadius = alcm.ProjectileSplashDamageMaxRadius * 1.2
	alcm.IncendiaryRadius = alcm.IncendiaryRadius * 0.6
	alcm.AntiAirHitpoints = 40
	alcm.ProjectileSplashMaxForce = 400000
	table.insert(Projectiles, alcm)
	MakeFlamingVersion("sbpp_alcm", 1.33, 2.5, flamingTrail, 225, nil, rocketFlamingExpire)
end
table.insert(Sprites,
{
	Name = "sbpp_bloom_flare",
	States =
	{
		Normal = { Frames = 
		{ 
			{ texture = path .. "/effects/media/bloom1.png" , colour = { 0.85, 0.80, 0.4, 0.4 },},
			{ texture = path .. "/effects/media/bloom1.png" , colour = { 0.9, 0.85, 0.3, 0.3 },},
			{ texture = path .. "/effects/media/bloom1.png" , colour = { 1, 0.85, 0.2, 0.2 },},
			{ texture = path .. "/effects/media/bloom1.png" , colour = { 0.9, 0.82, 0.35, 0.3 },},
			duration = 0.04,
			NextState = "Normal",
		},},
	},
})
local flare = DeepCopy(FindProjectile("machinegun"))
if flare then
	flare.SaveName = "sbpp_flare"
	flare.CollidesWithProjectiles = false
	flare.CollidesWithBeams = false
	flare.ProjectileIncendiary = true
	flare.ProjectileType = "mortar"
	flare.TrailEffect = path .. "/effects/trail_flare.lua"
	flare.ProjectileSprite = nil --path .. "/weapons/projectiles/flare"
	flare.Projectile =
	{
		Root =
		{
			Name = "Root",
			Angle = 0,
			Sprite = path .. "/weapons/projectiles/flare",
			PivotOffset = {0, 0},
			Scale = 1.5,
			ChildrenInFront =
			{
				{
					Sprite = "sbpp_bloom_flare",
					Additive = true,
					Scale = 3,
				}
			}
		}
	}
	flare.ProjectileThickness = flare.ProjectileThickness * 4
	flare.DrawBlurredProjectile = false
	flare.MinAge = 3
	flare.ProjectileDrag = 0.2
	table.insert(Projectiles, flare)
end

laser = FindProjectile("laser")
if laser then
	if laser.DamageMultiplier == nil then
		laser.DamageMultiplier = {}
	end
	table.insert(laser.DamageMultiplier, { SaveName = "HardPointFlak", AntiAir = 0 })
	table.insert(laser.DamageMultiplier, { SaveName = "HardPointShrapnel", AntiAir = 0 })

   table.insert(laser.DamageMultiplier, { SaveName = "nighthawk", AntiAir = 0.0004 })
   table.insert(laser.DamageMultiplier, { SaveName = "thunderbolt", AntiAir = 0.00045 })
   table.insert(laser.DamageMultiplier, { SaveName = "sbpp_Biplane", AntiAir = 1 })
   table.insert(laser.DamageMultiplier, { SaveName = "sbpp_hellcat", AntiAir = 0.00045 })
   table.insert(laser.DamageMultiplier, { SaveName = "sbpp_p51", AntiAir = 0.00045 })
   table.insert(laser.DamageMultiplier, { SaveName = "sbpp_f16", AntiAir = 0.00045 })
   table.insert(laser.DamageMultiplier, { SaveName = "sbpp_apache", AntiAir = 0.00035 })
   table.insert(laser.DamageMultiplier, { SaveName = "sbpp_ac130", AntiAir = 0.00045 })
end

--temp projectiles
sbpp_TempProjectile("bomb", 300)
sbpp_TempProjectile("cannon20mm", 80)
sbpp_TempProjectile("sbpp_bomb250kg", 300)
sbpp_TempProjectile("paveway", 300)
sbpp_TempProjectile("sbpp_vulcan", 80)
--sbpp_TempProjectile("sbpp_mig15gun1", 80)
sbpp_TempProjectile("sbpp_mig15gun2", 120)
sbpp_TempProjectile("sbpp_gau8", 80)
sbpp_TempProjectile("sbpp_gau12", 120)
sbpp_TempProjectile("sbpp_hydra", 120)
sbpp_TempProjectile("sbpp_hellfire", 300)
sbpp_TempProjectile("sbpp_bofors", 120)
sbpp_TempProjectile("sbpp_howitzer105mm", 120)
sbpp_TempProjectile("machinegun", 80)
sbpp_TempProjectile("sbpp_machinegun50cal", 80)
sbpp_TempProjectile("sbpp_machinegunsmall", 80)
sbpp_TempProjectile("sbpp_sidewinder", 80)
sbpp_TempProjectile("sbpp_rp3", 80)
sbpp_TempProjectile("sbpp_alcm", 300)
--apply mod
function sb_planes_applymod()
	for k, v in pairs(Projectiles) do
		--apply overrides
		if v.sb_planes_overrides then
			for kk, vv in pairs(v.sb_planes_overrides) do
				v[kk] = vv
			end
		end
		--set default weapon if none
		if not v.sb_planes then
			if v.dlc2_Bombs and v.dlc2_Bombs.Projectile and v.dlc2_Bombs.Count and v.dlc2_Bombs.Period then
				v.sb_planes =
				{
					weapon1 = {projectile = v.dlc2_Bombs.Projectile, count = v.dlc2_Bombs.Count, period = v.dlc2_Bombs.Period}
				}
				if v.dlc2_Bombs.FireEffect then v.sb_planes.weapon1.effect = v.dlc2_Bombs.FireEffect end
			end
		end
	end
end
RegisterApplyMod(sb_planes_applymod)