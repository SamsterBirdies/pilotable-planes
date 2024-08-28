--[[Scale = 1
SelectionWidth = 40.0
SelectionHeight = 58.75
SelectionOffset = { 0.0, -59.25 }
RecessionBox =
{
	Size = { 80, 25 },
	Offset = { -100, -60 },
}

WeaponMass = 80.0
HitPoints = 90.0
EnergyProductionRate = 0.0
MetalProductionRate = 0.0
EnergyStorageCapacity = 0.0
MetalStorageCapacity = 0.0
MinWindEfficiency = 1
MaxWindHeight = 0
MaxRotationalSpeed = 0
IgnitePlatformOnDestruct = true
StructureSplashDamage = 50
StructureSplashDamageMaxRadius = 150

FireEffect = path .. "/effects/fire_flak.lua"
ShellEffect = "effects/shell_eject_small.lua"
ConstructEffect = "effects/device_construct.lua"
CompleteEffect = "effects/device_complete.lua"
DestroyEffect = path .. "/effects/flak_weapon_explode.lua"
DestroyUnderwaterEffect = "mods/dlc2/effects/device_explode_submerged.lua"
ReloadEffect = path .. "/effects/reload_flak.lua"
FireEndEffect = path .. "/effects/cooldown_flak.lua"
ReloadEffectOffset = -1.5
RetriggerFireEffect = true
Projectile = "flak"
BarrelLength = 60.0
MinFireClearance = 500
FireClearanceOffsetInner = 20
FireClearanceOffsetOuter = 40
ReloadTime = 6.75
ReloadTimeIncludesBurst = false
MinFireSpeed = 8000.0
MaxFireSpeed = 8000.1
MaxFireClamp = 0.85
MinFireRadius = 350.0
MaxFireRadius = 1200.0
MinFireSpread = 8
MinVisibility = 1
MaxVisibilityHeight = 500
MinFireAngle = -50
MaxFireAngle = 50
KickbackMean = 15
KickbackStdDev = 3
MouseSensitivityFactor = 0.6
PanDuration = 0
FireStdDev = 0.005
FireStdDevAuto = 0.005
Recoil = 20000
EnergyFireCost = 300.0
MetalFireCost = 30
ShowFireAngle = true
RoundsEachBurst = 4
RoundPeriod = 0.25
BeamDuration = 0.05
ReloadFramePeriod = (ReloadTime + RoundsEachBurst*RoundPeriod)/12
DisruptionBlocksFire = true

TriggerProjectileAgeAction = true
MinAgeTrigger = 0.3
MaxAgeTrigger = 1.1

dofile("effects/device_smoke.lua")
SmokeEmitter = StandardDeviceSmokeEmitter

NodeEffects =
{
	{
		NodeName = "Hardpoint0",
		EffectPath = "effects/weapon_overheated.lua",
		Automatic = false,
	},
}

Root =
{
	Name = "flak",
	Angle = 0,
	Pivot = { 0, -0.37 },
	PivotOffset = { 0, 0 },
	Sprite = "flak-base",
	UserData = 0,
	
	ChildrenInFront =
	{
		{
			Name = "Head",
			Angle = 0,
			Pivot = { -0.1, -0.15 },
			PivotOffset = { 0.1, -0.05 },
			Sprite = "flak-head",
			UserData = 50,

			ChildrenBehind =
			{
				{
					Name = "Hardpoint0",
					Angle = 90,
					Pivot = { 0, 0 },
					PivotOffset = { 0, 0 },
				},
				{
					Name = "LaserSight",
					Angle = 90,
					Pivot = { 0.26, -0.22 },
					PivotOffset = { 0, 0 },
				},
				{
					Name = "Chamber",
					Angle = 0,
					Pivot = { 0.165, -0.05 },
					PivotOffset = { 0, 0 },
				},
				{
					Name = "FlakReload",
					Angle = 0,
					Pivot = { -0.25, 0 },
					PivotOffset = { 0, 0 },
					Sprite = "flak-reload",
					UserData = 100,
				},
				{
					Name = "FlakArm",
					Angle = 0,
					Pivot = { 0.6, -0.02 },
					PivotOffset = { 0, 0 },
					Sprite = "flak-arm",
					UserData = 70,
				},
			},
		},
	},
}
]]

Scale = 1
SelectionWidth = 90
SelectionHeight = 90
SelectionOffset =
{
	0,
	0
}
RecessionBox =
{
	Offset = {
		-230,
		-83
	},
	Size = {
		200,
		20
	}
}

WeaponMass = 120
HitPoints = 600
EnergyProductionRate = 0
MetalProductionRate = 0
EnergyStorageCapacity = 0
MetalStorageCapacity = 0

MinWindEfficiency = 1
MaxWindHeight = 0
MaxRotationalSpeed = 0

PanDuration = 0

DeviceSplashDamage = 150
DeviceSplashDamageMaxRadius = 400
DeviceSplashDamageDelay = 0.20000000298023
StructureSplashDamage = 200
StructureSplashDamageMaxRadius = 250
IncendiaryRadius = 200
IncendiaryRadiusHeated = 250
IgnitePlatformOnDestruct = true

FireEffect = "mods/weapon_pack/effects/fire_flak.lua"
ShellEffect = "effects/shell_eject_cannon.lua"
ConstructEffect = "effects/device_upgrade.lua"
CompleteEffect = "effects/device_complete.lua"
DestroyEffect = "mods/dlc2/effects/turret_explode.lua"
ReloadEffect = "effects/reload_cannon.lua"
ReloadEffectOffset = -2
RetriggerFireEffect = true
Projectile = "HardPointFlak"
BarrelLength = 50

MinFireClearance = 500
FireClearanceOffsetInner = 20
FireClearanceOffsetOuter = 40
--UniformSpray = true
ReloadTime = 12
MinFireSpeed = 20000
MaxFireSpeed = 20000
--MaxFireClamp = 0.80000001192093
MinFireRadius = 350
MaxFireRadius = 1000
ForceRecessionAngle = 0
MinVisibility = 1
MaxVisibilityHeight = 0
MinFireAngle = 55
MaxFireAngle = 110
DefaultFireAngle = 60
KickbackMean = 12
KickbackStdDev = 3
MouseSensitivityFactor = 0.5
FireStdDev = 0.12
FireStdDevAuto = 0.1
Recoil = 120000

EnergyFireCost = 2500
MetalFireCost = 75
ShowFireAngle = true
--IgnorePlatformSlope = true
ShowFireSpeed = true
--ProjectilesEachRound = 3
RoundsEachBurst = 8
RoundPeriod = 0.9
ReloadFramePeriod = (ReloadTime + RoundsEachBurst*RoundPeriod)/12
--DisruptionBlocksFire = true

TriggerProjectileAgeAction = true
MinAgeTrigger = 0.5
MaxAgeTrigger = 2

TargetIcon =
{
	Height = 32,
	Width = 32,
	Persistent = true,
	Texture = "ui/textures/mouse_target.tga"
}


SmokeEmitter = StandardDeviceSmokeEmitter

FrameRate = 25
Sprites = 
{
	{
		Name = "turret-decal_1_focus",
		States = {
			Normal = {
				Frames = {
					{
						texture = "mods/dlc2/weapons/turret/decal_1_focus.tga"
					},
					mipmap = true
				}
			}
		}
	},
	{
		Name = "HPT-base",
		States = {
			Normal = {
				Frames = {
					{
						texture = path.."/weapons/HardPointFlak/base-tur-03.tga"
					},
					mipmap = true
				}
			}
		}
	},
	{
		Name = "HPT-head",
		States = {
			Normal = {
				Frames = {
					{
						texture = path.."/weapons/HardPointFlak/head-tur-02.tga"
					},
					mipmap = true
				}
			}
		}
	}
}

Root = 
{
	Sprite = "HPT-base",
	ChildrenBehind = {
		{
			Sprite = "HPT-head",
			Name = "Head",
			UserData = 50,
			ChildrenInFront = {
				{
					Pivot = {-0.34999999403953552, 0},
					Angle = 90,
					Name = "Hardpoint0",
					PivotOffset = {0,0}
				},
				{
					Pivot = {-0.05000000074505806, -0.5},
					Angle = 0,
					Name = "Chamber",
					PivotOffset = {0,0}
				}
			},
			Angle = 0,
			Pivot = {0.18, -0.2800000011920929},
			PivotOffset = {
				0.30000001192092896,
				0
			}
		}
	},
	Name = "Turret",
	UserData = 0,
	ChildrenInFront = {
		{
			Sprite = "turret-decal_1_focus",
			Name = "decal",
			Scale = 0.5,
			Angle = 0,
			Pivot = {
				0.14399999380111694,
				-0.25
			},
			PivotOffset = {
				0,
				0
			}
		}
	},
	Angle = 0,
	Pivot = {
		0,
		-0.46000000834465027
	},
	PivotOffset = {
		0,
		0.44999998807907104
	}
}


-- Unknown variables:
-- DeregisterApplyMod function: 0FFA3318
--[[
DeregisterApplyMod = loadstring(Base64dec([=[
G0x1YVEAAQQEBAQAgwAAAGZ1bmN0aW9uIERlcmVnaXN0ZXJBcHBseU1vZChmdW5jKSBmb3Igayx2IGluIGlwYWlycyhBcHBseU1vZENhbGxzKSBkbyBpZiB2ID09IGZ1bmMgdGhlbiB0YWJsZS5yZW1vdmUoQXBwbHlNb2RDYWxscywgaykgZW5kIGVuZCBlbmQAAQAAAAEAAAAAAQAJDgAAAEUAAACFQAAAXAABARaAAYAXAIACFgABgIWBAACGwUADxUEAAAACAAKcQYABYYAAABaA/X8eAIAABAAAAAQHAAAAaXBhaXJzAAQOAAAAQXBwbHlNb2RDYWxscwAEBgAAAHRhYmxlAAQHAAAAcmVtb3ZlAAAAAAAOAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAAGAAAABQAAAGZ1bmMAAAAAAA0AAAAQAAAAKGZvciBnZW5lcmF0b3IpAAM
AAAANAAAADAAAAChmb3Igc3RhdGUpAAMAAAANAAAADgAAAChmb3IgY29udHJvbCkAAwAAAA0AAAACAAAAawAEAAAACwAAAAIAAAB2AAQAAAALAAAAAAAAAA==
]=]))
activeValue = 0
dlc1Var_Value = 1
SaveName = "turret"
dlc2Var_Active = true
-- RegisterApplyMod function: 0FFA3298
RegisterApplyMod = loadstring(Base64dec([=[
G0x1YVEAAQQEBAQAWgAAAEFwcGx5TW9kQ2FsbHMgPSB7fTsgZnVuY3Rpb24gUmVnaXN0ZXJBcHBseU1vZChmdW5jKSB0YWJsZS5pbnNlcnQoQXBwbHlNb2RDYWxscywgZnVuYykgZW5kAAEAAAABAAAAAAEABAYAAABFAAAARkDAAIWAAADAAAAAXECAAR4AgAADAAAABAYAAAB0YWJsZQAEBwAAAGluc2VydAAEDgAAAEFwcGx5TW9kQ2FsbHMAAAAAAAYAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAABQAAAGZ1bmMAAAAAAAUAAAAAAAAA
]=]))
ScattershotExclude = true
moonshot = true
moonshotValue = 1
dlc1Var_Active = true
DestroyUnderwaterEffect = "mods/dlc2/effects/device_explode_submerged_large.lua"
dlc2Var_Value = 1
ApplyModCalls = 
{}]]