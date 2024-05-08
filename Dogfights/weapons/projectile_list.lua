dofile("scripts/type.lua")
dofile(path .. "/scripts/better_log.lua")
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
--change aa
local flak = FindProjectile('flak')
if flak then
	flak.MaxAge = 3
end
local shotgun = FindProjectile('shotgun')
if shotgun then
	shotgun.AntiAirDamage = shotgun.AntiAirDamage / 2
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
	thunderbolt.AntiAirHitpoints = thunderbolt.AntiAirHitpoints * 1.2
	thunderbolt.sb_planes =
	{
		elevator = 50000,
		thrust = 15000,
		throttle_min = 0.65,
		throttle_max = 1.25,
		lift_multiplier = 4.3,
		lift_max_speed = 3700,
		advanced_physics = true,
		trail_effect = path .. "/effects/trail_jet",
		RCS = 10,
		weapon1 = 
		{
			projectile = "sbpp_temp_sbpp_gau8",
			rotation = 0.12, 
			distance = 25, 
			speed = 3000, 
			count = 20, 
			period = 0.08, 
			timer = 12, 
			stddev = 0.04, 
			effect = path .. "/effects/a10_fire.lua",
			name = "Avenger",
		},
		weapon2 = 
		{
			projectile = "sbpp_temp_bomb",
			rotation = 1.5708, 
			distance = 1, 
			speed = 350, 
			count = 4, 
			period = 0.06, 
			timer = 15,
			stddev = 0, 
			effect = "mods/dlc2/effects/bomb_release.lua", 
			name = "GBU-39 Bombs",
		},
	}
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
	nighthawk.AntiAirHitpoints = nighthawk.AntiAirHitpoints * 0.9
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
			timer = 20,
			stddev = 0,
			effect = "mods/dlc2/effects/bomb_release.lua",
			name = "Paveway"
		},
	}
end
local bomb = FindProjectile("bomb")
if bomb then
	bomb.MaxAge = 60
	bomb.ProjectileDrag = 8
	bomb.Gravity = 981 * 2
	bomb.ProjectileSplashDamageMaxRadius = bomb.ProjectileSplashDamageMaxRadius * 1.2
	bomb.ProjectileDamage = bomb.ProjectileDamage * 2
end
local paveway = FindProjectile("paveway")
if paveway then
	paveway.MaxAge = 60
	paveway.ProjectileDrag = 8
	paveway.Gravity = 981 * 2
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
			speed = 6000,
			count = 45, 
			period = 0.04, 
			timer = 9, 
			stddev = 0.03, 
			effect = path .. "/effects/vulcan_fire.lua",
			name = "Vulcan",
		},
		weapon2 = 
		{
			projectile = "sbpp_temp_sbpp_sidewinder",
			rotation = 0.0, 
			distance = 25, 
			speed = 4000, 
			count = 6, 
			period = 0.2, 
			timer = 16,
			stddev = 0.02,
			effect = "mods/weapon_pack/effects/rocket_launch.lua",
			name = "Sidewinders",
		},
	}
	table.insert(Projectiles, f16)
	MakeFlamingVersion("sbpp_f16", 1.33, 10, flamingTrail, 100, nil, genericFlamingExpire)
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
	sidewinder.AntiAirHitpoints = 6
	sidewinder.AntiAirDamage = 150
	sidewinder.Gravity = 1
	sidewinder.Projectile =
	{
		Root =
		{
			Name = "Root",
			Angle = 0,
			Sprite = path .. "/weapons/f16/sidewinder.png",
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
	vulcan.WeaponDamageBonus = 10
	vulcan.ProjectileDamage = 30
	vulcan.AntiAirHitpoints = 6
	vulcan.AntiAirDamage = 20
	vulcan.TrailEffect = nil
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
					Pivot = {0,0},
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
			projectile = "sbpp_temp_machinegun",
			rotation = 0.0, 
			distance = 25, 
			speed = 6000,
			count = 12,
			perround = 6,
			period = 0.16, 
			timer = 9, 
			stddev = 0.03, 
			effect = path .. "/effects/50cal_fire.lua",
			name = "Machinegun",
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
			name = "250kg Bombs",
		},
	}
	p51.AntiAirHitpoints = p51.AntiAirHitpoints * 0.75
	table.insert(Projectiles, p51)
	MakeFlamingVersion("sbpp_p51", 1.33, 10, flamingTrail, 100, nil, genericFlamingExpire)
end
local hellcat = DeepCopy(p51)
if hellcat then
	hellcat.SaveName = "sbpp_hellcat"
	hellcat.Projectile.Root.Sprite = path .. "/weapons/hellcat/hellcat.png"
	hellcat.AntiAirHitpoints = hellcat.AntiAirHitpoints * 1.4
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
			Sprite = path .. "/weapons/hellcat/bomb.png",
			PivotOffset = {0, 0},
			Scale = 1.5,
		}
	}
	bomb250kg.ProjectileSprite = nil
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
			PivotOffset = {0, 0},
			Scale = 2.0,
			ChildrenInFront =
			{	
				{
					Name = "Prop",
					Angle = 0,
					Sprite = "sbpp_ac130_prop",
					PivotOffset = {0,0},
					Pivot = {0,0},
				}
			}
		}
	}
	ac130.AntiAirHitpoints = ac130.AntiAirHitpoints * 2
	ac130.ProjectileShootDownRadius = ac130.ProjectileShootDownRadius * 1.5
	ac130.ProjectileDamage = ac130.ProjectileDamage * 2
	ac130.ProjectileSplashDamage = ac130.ProjectileSplashDamage * 2
	ac130.ProjectileSplashDamageMaxRadius = ac130.ProjectileSplashDamageMaxRadius * 2.4
	ac130.ProjectileSplashMaxForce = 750000
	ac130.IncendiaryRadius = 300
	ac130.Effects.Impact =
	{
		default = path .. "/effects/HUGE_EXPLOSION.lua",
	}
	ac130.sb_planes =
	{
		elevator = 34000,
		thrust = 13000,
		throttle_min = 0.6,
		throttle_max = 1.3,
		lift_multiplier = 5.3,
		lift_max_speed = 3000,
		advanced_physics = true,
		trail_effect = path .. "/effects/trail_ac130",
		RCS = 5,
		weapon1 = 
		{
			projectile = "sbpp_temp_sbpp_gau12",
			rotation = 0.0, 
			distance = 25, 
			speed = 4000,
			count = 20, 
			period = 0.08, 
			timer = 9, 
			stddev = 0.03,
			aimed = true,
			max_aim = 0,
			min_aim = 3.14,
			effect = path .. "/effects/a10_fire.lua",
			name = "25mm Equalizer",
		},
		weapon2 = 
		{
			projectile = "sbpp_temp_sbpp_bofors",
			rotation = 0.0, 
			distance = 25,  
			speed = 4000, 
			count = 1, 
			period = 0.06, 
			timer = 0.8,
			stddev = 0,
			aimed = true,
			max_aim = 0,
			min_aim = 3.14,
			effect = "mods/weapon_pack/effects/fire_20mmcannon.lua", 
			name = "40mm Bofors",
		},
		weapon3 = 
		{
			projectile = "sbpp_temp_sbpp_howitzer105mm",
			rotation = 0.0,
			distance = 25,
			speed = 4000,
			count = 1,
			period = 0.06,
			timer = 8,
			stddev = 0,
			aimed = true,
			max_aim = 0,
			min_aim = 3.14,
			effect = "effects/fire_cannon.lua",
			reload_effect = path .. "/effects/ac130_gunready.lua",
			name = "105mm Howitzer",
		},
	}
	table.insert(Projectiles, ac130)
	MakeFlamingVersion("sbpp_ac130", 1.33, 10, flamingTrail, 100, nil, genericFlamingExpire)
end
local gau12 = DeepCopy(FindProjectile("sbpp_gau8"))
if gau12 then
	gau12.SaveName = "sbpp_gau12"
	gau12.ProjectileDamage = gau12.ProjectileDamage * 0.8
	table.insert(Projectiles, gau12)
	MakeFlamingVersion("sbpp_gau12", 1.33, 0.25, flamingTrail, 100, nil, genericFlamingExpire)
end
local bofors = DeepCopy(FindProjectile("cannon"))
if bofors then
	bofors.SaveName = "sbpp_bofors"
	bofors.ProjectileDamage = 250
	bofors.ProjectileSplashDamage = 75
	bofors.ProjectileSplashDamageMaxRadius = 170
	bofors.Effects.Impact =
	{
		default = "mods/weapon_pack/effects/rocket_structure_hit.lua",
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
	howitzer105.ProjectileSplashMaxForce = 500000
	howitzer105.Effects.Impact = 
	{
		default = "mods/dlc2/effects/impact_paveway.lua",
	}
	howitzer105.Projectile.Root.Sprite = path .. "/weapons/ac130/howitzer.png"
	howitzer105.Projectile.Root.Scale = 0.75
	howitzer105.ProjectileShootDownRadius = 15
	howitzer105.AntiAirHitpoints = 60
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
	apache.ExplodeOnTouch = true
	apache.ProjectileAgeTrigger = false
	apache.sb_planes =
	{
		elevator = 2,
		thrust = 5030,
		throttle_min = 0.8,
		throttle_max = 1.2,
		helicopter = true,
		sprite = path .. "/effects/apache",
		trail_effect = path .. "/effects/trail_heli",
		RCS = 5,
		weapon1 = 
		{
			projectile = "sbpp_temp_cannon20mm",
			rotation = 0.0, 
			distance = 25, 
			speed = 4500,
			count = 8, 
			period = 0.2, 
			timer = 15, 
			stddev = 0.03,
			effect = "mods/weapon_pack/effects/fire_20mmcannon.lua",
			name = "Chain Gun",
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
			name = "Hydra Rockets",
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
			name = "Hellfire Missile",
		},
	}
	--BetterLog(apache.Effects.Age)
	table.insert(Projectiles, apache)
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
		sbApacheHydra.ProjectileSplashDamage = 30
		sbApacheHydra.AntiAirDamage = 70
		sbApacheHydra.ProjectileSplashDamageMaxRadius = 150
		sbApacheHydra.Projectile.Root.Sprite = path .. "/weapons/apache/hydra.png"
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
		sbApacheHellfire.IncendiaryRadius = 175
		sbApacheHellfire.IncendiaryRadiusHeated = 200
		sbApacheHellfire.ProjectileSplashDamageMaxRadius = 240
		sbApacheHellfire.ProjectileSplashDamage = 200
		sbApacheHellfire.AntiAirDamage = 200
		sbApacheHellfire.AntiAirHitpoints = 11
		sbApacheHellfire.Projectile.Root.Sprite = path .. "/weapons/apache/hellfire.png"
		sbApacheHellfire.Projectile.Root.ChildrenInFront[1].Pivot = {0, 0.5}
		if FindProjectile("paveway") then
			sbApacheHellfire.Effects = DeepCopy(FindProjectile("paveway").Effects)
		end
		table.insert(Projectiles, sbApacheHellfire)
		MakeFlamingVersion("sbpp_hellfire", 1.33, 2.5, flamingTrail, 225, nil, rocketFlamingExpire)
	end
end
--temp projectiles
sbpp_TempProjectile("bomb", 300)
sbpp_TempProjectile("cannon20mm", 80)
sbpp_TempProjectile("sbpp_bomb250kg", 300)
sbpp_TempProjectile("paveway", 300)
sbpp_TempProjectile("sbpp_vulcan", 80)
sbpp_TempProjectile("sbpp_gau8", 80)
sbpp_TempProjectile("sbpp_gau12", 120)
sbpp_TempProjectile("sbpp_hydra", 120)
sbpp_TempProjectile("sbpp_hellfire", 300)
sbpp_TempProjectile("sbpp_bofors", 120)
sbpp_TempProjectile("sbpp_howitzer105mm", 120)
sbpp_TempProjectile("machinegun", 80)
sbpp_TempProjectile("sbpp_sidewinder", 80)
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