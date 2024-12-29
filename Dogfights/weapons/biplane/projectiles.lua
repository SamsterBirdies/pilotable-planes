local sbFlechetteP1 = DeepCopy(FindProjectile("machinegun"))
if sbFlechetteP1 then
	sbFlechetteP1.SaveName = "sbpp_FlechetteP1"
	sbFlechetteP1.ExpiresOnFreeFall = false
	sbFlechetteP1.CollidesWithProjectiles = false
	sbFlechetteP1.ProjectileSpriteMipMap = true
	sbFlechetteP1.ProjectileSprite = path .. "/weapons/projectiles/flechette.png"
	sbFlechetteP1.Effects = { Age = {t300 = { Effect = nil, Projectile = { Count = 4, Type = "sbpp_FlechetteP2", StdDev = 0.1 }, Offset = 0, Terminate = true, Splash = false} }}
	local sbFlechetteP2 = DeepCopy(FindProjectile("machinegun"))
	sbFlechetteP2.SaveName = "sbpp_FlechetteP2"
	sbFlechetteP2.MinAge = nil
	sbFlechetteP2.MaxAge = 60
	sbFlechetteP2.ProjectileShootDownRadius = sbFlechetteP2.ProjectileShootDownRadius * 1.5
	sbFlechetteP2.ProjectileDrag = 0
	sbFlechetteP2.WeaponDamageBonus = 0
	sbFlechetteP2.ProjectileSpriteMipMap = true
	sbFlechetteP2.ProjectileSprite = path .. "/weapons/projectiles/flechette.png"
	sbFlechetteP2.ExpiresOnFreeFall = false
	sbFlechetteP2.ProjectileDamage = 4
	sbFlechetteP2.AntiAirHitpoints = 1
	sbFlechetteP2.AntiAirDamage = 10
	sbFlechetteP2.ProjectileMass = 1
	sbFlechetteP2.PenetrationDamage = 460
	sbFlechetteP2.ImpactMomentumLimit = nil
	sbFlechetteP2.MomentumThreshold =
	{
		["bracing"] = { Reflect = 50, Penetrate = 1700 },
		["armour"] = { Reflect = 1500, Penetrate = 2300 },
		["door"] = { Reflect = 1500, Penetrate = 2300 },
		["shield"] = { Reflect = 1500, Penetrate = 2300 },
	}
	sbFlechetteP2.DamageMultiplier =
	{
		{ SaveName = "machinegun", Direct = 0},
		{ SaveName = "mortar", Direct = 0},
		{ SaveName = "mortar2", Direct = 0},
		{ SaveName = "turbine", Direct = 1.5},
		{ SaveName = "turbine2", Direct = 1.5},
		{ SaveName = "smokestack", Direct = 1.5},
		{ SaveName = "smokestack2", Direct = 1.5},
		{ SaveName = "sandbags", Direct = 2.5},
		{ SaveName = "structure", Direct = 3},
		{ SaveName = "turret", AntiAir = 2},
	}
	table.insert(Projectiles, sbFlechetteP2)
	table.insert(Projectiles, sbFlechetteP1)
end
local grenades = DeepCopy(FindProjectile("mortar2"))
if grenades then
	grenades.SaveName = "sbpp_grenade"
	grenades.Effects.Impact.firebeam = { Effect = nil, Projectile = { Count = 1, Type = "flamingsbpp_grenade", StdDev = 0, }, Terminate = true, Splash = false,}
	grenades.Projectile =
	{
		Root =
		{
			Name = "Root",
			Angle = 0,
			Sprite = path .. "/weapons/projectiles/grenade.png",
		}
	}
	grenades.TrailEffect = "effects/swarm_trail.lua"
	grenades.ProjectileSplashDamage = grenades.ProjectileSplashDamage * 0.65
	table.insert(Projectiles, grenades)
end
MakeFlamingVersion("sbpp_grenade", 1.33, 2.5, flamingTrail, 100, nil, genericFlamingExpire)
sbpp_TempProjectile("sbpp_grenade", 300)
local sbpp_bi = DeepCopy(FindProjectile("nighthawk"))
if sbpp_bi then
	table.insert(Sprites, 
	{
		Name = "sbpp_BiProp",
		States =
		{
			Normal = { Frames =
			{
				{ texture = path .. "/weapons/biplane/propeller0.png",},
				{ texture = path .. "/weapons/biplane/propeller1.png",},
				mipmap = true,
				duration = 0.04,
			},},
			Idle = Normal,
		},
	})
	sbpp_bi.SaveName = "sbpp_Biplane"
	sbpp_bi.FlipSpriteFacingLeft = true
	sbpp_bi.AntiAirHitpoints = 30
	sbpp_bi.AntiAirDamage = 30
	sbpp_bi.ProjectileShootDownRadius = 100
	sbpp_bi.dlc2_Bombs = nil
	sbpp_bi.TrailEffect = nil
	sbpp_bi.ProjectileDamage = 100
	sbpp_bi.ProjectileDrag = 3
	sbpp_bi.MaxAge = 1984
	sbpp_bi.Gravity = 981
	sbpp_bi.Projectile =
	{
		Root =
		{
			Name = "Root",
			Angle = -90,
			Sprite = path .. "/weapons/biplane/base.png",
			PivotOffset = {0, 0},
			Scale = 1.6,
			
			ChildrenInFront = 
			{
				{
					Name = "Propeller",
					Angle = 0,
					Sprite = "sbpp_BiProp",
					Pivot = {0.465625, -0.11914},
				},
			},
		}
	}
	--effects
	sbpp_bi.Effects.Impact["firebeam"] = { Effect = nil, Projectile = { Count = 1, Type = "flamingsbpp_Biplane", StdDev = 0, }, Terminate = true, Splash = false,}
	sbpp_bi.Effects.Impact["antiair"] = path .. "/effects/biplane_explode.lua"
	sbpp_bi.Effects.Impact["default"] = path .. "/effects/biplane_explode.lua"
	sbpp_bi.Effects.Impact["whitecaps"] = path .. "/effects/biplane_explode.lua"
	sbpp_bi.DamageMultiplier =
	{
		{ SaveName = "sniper", Direct = 2, Splash = 1 },
		{ SaveName = "machinegun", Direct = 2, Splash = 1 },
		{ SaveName = "minigun", Direct = 2, Splash = 1 },
	}
	--controllable planes config
	sbpp_bi.sb_planes =
	{
		elevator = 20000,
		thrust = 5100,
		throttle_min = 0.5,
		throttle_max = 1.5,
		lift_multiplier = 9.15,
		lift_max_speed = 1800,
		advanced_physics = true,
		trail_effect = path .. "/effects/trail_biplane",
		weapon1 = 
		{
			projectile = "sbpp_temp_machinegun", 
			rotation = 0, 
			distance = 1, 
			speed = 4000, 
			count = 7, 
			period = 0.2, 
			timer = 3.2, 
			stddev = 0.045, 
			effect = path .. "/effects/m1911_fire.lua",
			name = "$Weapon.sbpp_m1911",
		},
		weapon2 = 
		{
			projectile = "sbpp_FlechetteP1", 
			rotation = 1.5708, 
			distance = 1, 
			speed = 600, 
			count = 20, 
			period = 0.04, 
			timer = 12, 
			stddev = 0,
			name = "$Weapon.sbpp_flechettes",
		},
		weapon3 = 
		{
			projectile = "sbpp_temp_sbpp_grenade", 
			rotation = 1.5708, 
			distance = 1, 
			speed = 500, 
			count = 6, 
			period = 0.08, 
			timer = 9, 
			stddev = 0,
			name = "$Weapon.sbpp_grenades",
		},
	}
	table.insert(Projectiles, sbpp_bi)
end
MakeFlamingVersion("sbpp_Biplane", 1.33, 10, flamingTrail, 100, nil, genericFlamingExpire)
