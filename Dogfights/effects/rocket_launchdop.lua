--  age (in seconds) at which the explosion actor deletes itself
--  make sure this exceedes the age of all effects
LifeSpan = 6.0
SoundEvent = "mods/dogfights/effects/rocket_launch"
LaunchDelay = 0.5
EffectVerticalOffset = 1
EffectDepth = 90

Effects =
{
--[[
	{
		Type = "sound",
		TimeToTrigger = LaunchDelay,
		LocalPosition = { x = 0, y = 0, z = 0 },
		Sound = path .. "/effects/media/rocket_launch.mp3",
		PlayForEnemy = true,
		Volume = 1,
		Priority = 254,
		Falloff = true,
	},
]]	
	{
		Type = "sparks",
		TimeToTrigger = 0.0,
		TimeToStop = LaunchDelay,
		SparkCount = 20,
		BurstPeriod = 0.5,
		SparksPerBurst = 2,
		LocalPosition = { x = 0, y = EffectVerticalOffset, z = EffectDepth },	-- how to place the origin relative to effect position and direction (0, 0) 
		Sprite = "effects/media/Steam.dds",

		Gravity = 0,						-- gravity applied to particle (981 is earth equivalent)

		NormalDistribution =					-- distribute sparks evenly between two angles with optional variation
		{
			Mean = 0,
			StdDev = 5,						-- standard deviation at each iteration in degrees (zero will make them space perfectly even)
		},

		Keyframes =							
		{
			{
				Angle = 0,					-- angle of keyframe in degrees (e.g. -180, 45, 0)
				RadialOffsetMin = 0,		-- minimum distance from effect origin
				RadialOffsetMax = 5,		-- maximum distance from effect origin
				ScaleMean = 0.35,			-- mean scale (normal distribution)
				ScaleStdDev = 0.01,			-- standard deviation of scale (0 will make them all the same size)
				SpeedStretch = 0,			-- factor of speed by which to elongate the spark in the direction of travel (avoid using with rotation)
				SpeedMean = 50,				-- mean speed of sparks at emission (normal distribution)
				SpeedStdDev = 1,			-- standard deviation of spark speed at emission
				Drag = 0,					-- drag of sparks (zero will make them continue at same speed)
				RotationMean = 0,			-- mean initial rotation in degrees (e.g. -180, 45, 0) (normal distribution)
				RotationStdDev = 45,		-- standard deviation of initial rotation in degrees (zero will make them start at the same angle)
				RotationalSpeedMean = 5,	-- mean rotational speed in degrees per second (e.g. -180, 45, 0) (normal distribution)
				RotationalSpeedStdDev = 0,	-- standard deviation of rotational speed in degrees per second (zero will make them rotate at the same rate)
				AgeMean = 3,				-- mean age in seconds (normal distribution)
				AgeStdDev = .1,				-- standard deviation of age in seconds (zero makes them last the same length of time)
				AlphaKeys = { 0.5, 0.75 },	-- fractions of life span between which the spark reaches full alpha (fade in -> full alpha -> fade out)
				ScaleKeys = { 0.25, 0.75 },	-- fractions of life span between which the spark reaches full scale (balloon in -> full scale -> shrink out)
				colour = { 255, 255, 255, 255 }, -- Colour used to modulate the sprite
			},
		},
	},
--[[
	{
		Type = "sound",
		TimeToTrigger = LaunchDelay,
		LocalPosition = { x = 0, y = 0, z = 0 },
		Sound = path .. "/audio/sfx/weapons/weapon_missile_swarm_fire_01.wav",
	},
]]
	{
		Type = "sparks",
		TimeToTrigger = 0,
		TimeToStop = 0.8,
		SparkCount = 12,
		BurstPeriod = 0.2,
		SparksPerBurst = 3,
		LocalPosition = { x = 0, y = EffectVerticalOffset, z = EffectDepth },	-- how to place the origin relative to effect position and direction (0, 0) 
		Sprite = "effects/media/Steam",

		Gravity = -50,						-- gravity applied to particle (981 is earth equivalent)
--[[
		EvenDistribution =					-- distribute sparks evenly between two angles with optional variation
		{
			Min = -30,						-- minimum angle in degrees (e.g. -180, 45, 0)
			Max = 30,						-- maximum angle in degrees (e.g. -180, 45, 0)
			StdDev = 1,						-- standard deviation at each iteration in degrees (zero will make them space perfectly even)
		},
]]
		NormalDistribution =
		{
			Mean = 180,
			StdDev = 8,
		},

		Keyframes =
		{
			{
				Angle = -180,					-- angle of keyframe in degrees (e.g. -180, 45, 0)
				RadialOffsetMin = 0,		-- minimum distance from effect origin
				RadialOffsetMax = 50,		-- maximum distance from effect origin
				ScaleMean = 0.5,			-- mean scale (normal distribution)
				ScaleStdDev = 0.02,			-- standard deviation of scale (0 will make them all the same size)
				SpeedStretch = 0,			-- factor of speed by which to elongate the spark in the direction of travel (avoid using with rotation)
				SpeedMean = 350,			-- mean speed of sparks at emission (normal distribution)
				SpeedStdDev = 10,			-- standard deviation of spark speed at emission
				Drag = 0.1,					-- drag of sparks (zero will make them continue at same speed)
				RotationMean = 0,			-- mean initial rotation in degrees (e.g. -180, 45, 0) (normal distribution)
				RotationStdDev = 45,		-- standard deviation of initial rotation in degrees (zero will make them start at the same angle)
				RotationalSpeedMean = 5,	-- mean rotational speed in degrees per second (e.g. -180, 45, 0) (normal distribution)
				RotationalSpeedStdDev = 0,	-- standard deviation of rotational speed in degrees per second (zero will make them rotate at the same rate)
				AgeMean = 1.5,				-- mean age in seconds (normal distribution)
				AgeStdDev = .2,				-- standard deviation of age in seconds (zero makes them last the same length of time)
				AlphaKeys = { 0.1, 0.75 },	-- fractions of life span between which the spark reaches full alpha (fade in -> full alpha -> fade out)
				ScaleKeys = { 0.1, 0.75 },	-- fractions of life span between which the spark reaches full scale (balloon in -> full scale -> shrink out)
				colour = { 255, 255, 255, 255 }, -- Colour used to modulate the sprite
			},
			{
				Angle = -165,				-- angle of keyframe in degrees (e.g. -180, 45, 0)
				RadialOffsetMin = 0,		-- minimum distance from effect origin
				RadialOffsetMax = 20,		-- maximum distance from effect origin
				ScaleMean = 0.5,			-- mean scale (normal distribution)
				ScaleStdDev = 0.02,			-- standard deviation of scale (0 will make them all the same size)
				SpeedStretch = 0,			-- factor of speed by which to elongate the spark in the direction of travel (avoid using with rotation)
				SpeedMean = 30,				-- mean speed of sparks at emission (normal distribution)
				SpeedStdDev = 1,			-- standard deviation of spark speed at emission
				Drag = 0.2,					-- drag of sparks (zero will make them continue at same speed)
				RotationMean = 0,			-- mean initial rotation in degrees (e.g. -180, 45, 0) (normal distribution)
				RotationStdDev = 45,		-- standard deviation of initial rotation in degrees (zero will make them start at the same angle)
				RotationalSpeedMean = -180,	-- mean rotational speed in degrees per second (e.g. -180, 45, 0) (normal distribution)
				RotationalSpeedStdDev = 0,	-- standard deviation of rotational speed in degrees per second (zero will make them rotate at the same rate)
				AgeMean = 1,				-- mean age in seconds (normal distribution)
				AgeStdDev = .1,				-- standard deviation of age in seconds (zero makes them last the same length of time)
				AlphaKeys = { 0.1, 0.75 },	-- fractions of life span between which the spark reaches full alpha (fade in -> full alpha -> fade out)
				ScaleKeys = { 0.1, 0.75 },	-- fractions of life span between which the spark reaches full scale (balloon in -> full scale -> shrink out)
				colour = { 255, 255, 255, 255 }, -- Colour used to modulate the sprite
			},
			{
				Angle = 165,					-- angle of keyframe in degrees (e.g. -180, 45, 0)
				RadialOffsetMin = 0,		-- minimum distance from effect origin
				RadialOffsetMax = 20,		-- maximum distance from effect origin
				ScaleMean = 0.5,			-- mean scale (normal distribution)
				ScaleStdDev = 0.02,			-- standard deviation of scale (0 will make them all the same size)
				SpeedStretch = 0,			-- factor of speed by which to elongate the spark in the direction of travel (avoid using with rotation)
				SpeedMean = 30,				-- mean speed of sparks at emission (normal distribution)
				SpeedStdDev = 1,			-- standard deviation of spark speed at emission
				Drag = 0.2,					-- drag of sparks (zero will make them continue at same speed)
				RotationMean = 0,			-- mean initial rotation in degrees (e.g. -180, 45, 0) (normal distribution)
				RotationStdDev = 45,		-- standard deviation of initial rotation in degrees (zero will make them start at the same angle)
				RotationalSpeedMean = 180,	-- mean rotational speed in degrees per second (e.g. -180, 45, 0) (normal distribution)
				RotationalSpeedStdDev = 0,	-- standard deviation of rotational speed in degrees per second (zero will make them rotate at the same rate)
				AgeMean = 1,				-- mean age in seconds (normal distribution)
				AgeStdDev = .1,				-- standard deviation of age in seconds (zero makes them last the same length of time)
				AlphaKeys = { 0.1, 0.75 },	-- fractions of life span between which the spark reaches full alpha (fade in -> full alpha -> fade out)
				ScaleKeys = { 0.1, 0.75 },	-- fractions of life span between which the spark reaches full scale (balloon in -> full scale -> shrink out)
				colour = { 255, 255, 255, 255 }, -- Colour used to modulate the sprite
			},
			{
				Angle = 180,					-- angle of keyframe in degrees (e.g. -180, 45, 0)
				RadialOffsetMin = 0,		-- minimum distance from effect origin
				RadialOffsetMax = 50,		-- maximum distance from effect origin
				ScaleMean = 0.5,			-- mean scale (normal distribution)
				ScaleStdDev = 0.02,			-- standard deviation of scale (0 will make them all the same size)
				SpeedStretch = 0,			-- factor of speed by which to elongate the spark in the direction of travel (avoid using with rotation)
				SpeedMean = 350,			-- mean speed of sparks at emission (normal distribution)
				SpeedStdDev = 10,			-- standard deviation of spark speed at emission
				Drag = 0.1,					-- drag of sparks (zero will make them continue at same speed)
				RotationMean = 0,			-- mean initial rotation in degrees (e.g. -180, 45, 0) (normal distribution)
				RotationStdDev = 45,		-- standard deviation of initial rotation in degrees (zero will make them start at the same angle)
				RotationalSpeedMean = 5,	-- mean rotational speed in degrees per second (e.g. -180, 45, 0) (normal distribution)
				RotationalSpeedStdDev = 0,	-- standard deviation of rotational speed in degrees per second (zero will make them rotate at the same rate)
				AgeMean = 1.5,				-- mean age in seconds (normal distribution)
				AgeStdDev = .2,				-- standard deviation of age in seconds (zero makes them last the same length of time)
				AlphaKeys = { 0.1, 0.75 },	-- fractions of life span between which the spark reaches full alpha (fade in -> full alpha -> fade out)
				ScaleKeys = { 0.1, 0.75 },	-- fractions of life span between which the spark reaches full scale (balloon in -> full scale -> shrink out)
				colour = { 255, 255, 255, 255 }, -- Colour used to modulate the sprite
			},
		},
	},
}
