HardPointFlakDetonation = { Effect = nil, Projectile = { Count = 4, Type = "HardPointSubFlak",--[[ Speed = 9000,]] StdDev = 0.24 }, --[[Offset = -120,]] Terminate = true, }
HardPointSubFlakDetonation = { Effect = path.."/effects/HPF_end_explosion.lua", Projectile = { Count = 24, Type = "HardPointShrapnel", Speed = 20000, StdDev = 0.7 }, Offset = -120, Terminate = true, }

table.insert(Projectiles,
{
	SaveName = "HardPointFlak",

	ProjectileType = "mortar",
	ProjectileSprite = "weapons/media/bullet",
   TrailEffect = path.."/effects/trail_HPF.lua",
	ProjectileSpriteMipMap = false,
	DrawBlurredProjectile = true,
	ProjectileMass = 0.6,
	ProjectileDrag = 0.05,
	DeflectedByShields = false,
	ExplodeOnTouch = true,
	ProjectileThickness = 1,
	ProjectileShootDownRadius = 150,
	ProjectileShootDownRadiusBeamWidth = 15,
	CollisionLookaheadDist = 120,
	Impact = 10000,
	ProjectileDamage = 6.0,
	AntiAirDamage = 0,
	WeaponDamageBonus = 6.0,
	SpeedIndicatorFactor = 5.0,
	BeamTileRate = 0.02,
	BeamScrollRate = 0.0,
   MaxAge = 5,

	DamageMultiplier =
	{
		{ SaveName = "default", Direct = 0, },
	},

	Effects =
	{
		Impact =
		{
			["firebeam"] = HardPointFlakDetonation,
			["device"] = HardPointFlakDetonation,
			["foundations"] = HardPointFlakDetonation,
			["rocks01"] = HardPointFlakDetonation,
			["bracing"] = HardPointFlakDetonation,
			["backbracing"] = HardPointFlakDetonation,
			["armour"] = HardPointFlakDetonation,
			["door"] = HardPointFlakDetonation,
			["shield"] = HardPointFlakDetonation,
			["default"] = HardPointFlakDetonation,
		},
		Deflect =
		{
			["bracing"] = "effects/bullet_bracing_hit.lua",
			["backbracing"] = "effects/bullet_bracing_hit.lua",
			["armour"] = "effects/bullet_armor_ricochet.lua",
			["door"] = "effects/bullet_armor_ricochet.lua",
			["shield"] = "effects/energy_shield_ricochet.lua",
			["default"] = "effects/bullet_bracing_hit.lua",
		},
		Age =
		{
			t200 = HardPointFlakDetonation,
		},
	},
})

table.insert(Projectiles,
{
	SaveName = "HardPointSubFlak",

	ProjectileType = "mortar",
	ProjectileSprite = "weapons/media/bullet",
   TrailEffect = path.."/effects/trail_HPSubF.lua",
	ProjectileSpriteMipMap = false,
	DrawBlurredProjectile = true,
	ProjectileMass = 0.6,
	ProjectileDrag = 0.05,
	DeflectedByShields = false,
	ExplodeOnTouch = true,
	ProjectileThickness = 1,
	ProjectileShootDownRadius = 150,
	ProjectileShootDownRadiusBeamWidth = 15,
	CollisionLookaheadDist = 120,
	Impact = 10000,
	ProjectileDamage = 6.0,
	AntiAirDamage = 0,
	WeaponDamageBonus = 6.0,
	SpeedIndicatorFactor = 5.0,
	BeamTileRate = 0.02,
	BeamScrollRate = 0.0,
   MaxAge = 5,

	DamageMultiplier =
	{
		{ SaveName = "default", Direct = 0, },
	},

	Effects =
	{
		Impact =
		{
			["firebeam"] = HardPointSubFlakDetonation,
			["device"] = HardPointSubFlakDetonation,
			["foundations"] = HardPointSubFlakDetonation,
			["rocks01"] = HardPointSubFlakDetonation,
			["bracing"] = HardPointSubFlakDetonation,
			["backbracing"] = HardPointSubFlakDetonation,
			["armour"] = HardPointSubFlakDetonation,
			["door"] = HardPointSubFlakDetonation,
			["shield"] = HardPointSubFlakDetonation,
			["default"] = HardPointSubFlakDetonation,
		},
		Deflect =
		{
			["bracing"] = "effects/bullet_bracing_hit.lua",
			["backbracing"] = "effects/bullet_bracing_hit.lua",
			["armour"] = "effects/bullet_armor_ricochet.lua",
			["door"] = "effects/bullet_armor_ricochet.lua",
			["shield"] = "effects/energy_shield_ricochet.lua",
			["default"] = "effects/bullet_bracing_hit.lua",
		},
		Age =
		{
			t300 = HardPointSubFlakDetonation,
		},
	},
})


HPShrapnel =
{
	SaveName = "HardPointShrapnel",

	ProjectileType = "bullet",
	ProjectileSprite = "weapons/media/bullet",
	ProjectileSpriteMipMap = false,
	DrawBlurredProjectile = true,
	ProjectileMass = 0.25,
	ProjectileDrag = 0.3,
	DeflectedByShields = true,
	DeflectedByTerrain = false,
	ExplodeOnTouch = false,
	ProjectileThickness = 0,
	ProjectileShootDownRadius = 7,
	Impact = 10000,
	ImpactMomentumLimit = 2000,
	ProjectileDamage = 2.5,
	SpeedIndicatorFactor = 5.0,
	BeamTileRate = 0.02,
	BeamScrollRate = 0.0,
	MinAge = 0.25,
	MaxAge = 0.2,
	DrawFromAge = 2/FrameRate,

	Effects =
	{
		ImpactDevice =
		{
			["sandbags"] = "effects/bullet_sandbag_hit.lua",
		},
		Impact =
		{
			["device"] = "effects/impact_light.lua",
			["foundations"] = "effects/ground_hit.lua",
			["rocks01"] = "effects/ground_hit.lua",
			["bracing"] = "effects/bullet_bracing_hit.lua",
			["backbracing"] = "effects/bullet_bracing_hit.lua",
			["armour"] = "effects/bullet_armor_hit.lua",
			["door"] = "effects/bullet_armor_hit.lua",
			["shield"] = "effects/impact_light.lua",
			["default"] = "effects/impact_light.lua",
		},
		Deflect =
		{
			["bracing"] = "effects/bullet_bracing_hit.lua",
			["backbracing"] = "effects/bullet_bracing_hit.lua",
			["armour"] = "effects/bullet_armor_ricochet.lua",
			["door"] = "effects/bullet_armor_ricochet.lua",
			["shield"] = "effects/energy_shield_ricochet.lua",
			["default"] = "effects/bullet_bracing_hit.lua",
		},
	},

	DamageMultiplier =
	{
		{ SaveName = "mortar", Direct = 0.6, Splash = 1 },
		{ SaveName = "mortar2", Direct = 0.6, Splash = 1 },
		{ SaveName = "machinegun", Direct = 0.2, Splash = 1 },
		{ SaveName = "minigun", Direct = 0.2, Splash = 1 },
	},
}

table.insert(Projectiles, HPShrapnel)
