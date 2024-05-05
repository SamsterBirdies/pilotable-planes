function Flames(count, size, speed)
	return {
		--SPARKY STREAMERS
		Type = "sparks",
		TimeToTrigger = 0,
		TimeToStop = 0,
		SparkCount = count,
		SparksPerBurst = count,
		LocalPosition = { x = 0, y = 0, z = 0 },	-- how to place the origin relative to effect position and direction (0, 0) 
		Texture = "effects/media/flame.dds",
		TrailEffect = "effects/missile_streams.lua",
		Gravity = 600,						-- gravity applied to particle (981 is earth equivalent)
		
		EvenDistribution =					-- distribute sparks evenly between two angles with optional variation
		{
			Min = -60,						-- minimum angle in degrees (e.g. -180, 45, 0)
			Max = 60,						-- maximum angle in degrees (e.g. -180, 45, 0)
			StdDev = 15,					-- standard deviation at each iteration in degrees (zero will make them space perfectly even)
		},

		Keyframes =							
		{
			{
				Angle = -70,				-- angle of keyframe in degrees (e.g. -180, 45, 0)
				RadialOffsetMin = 0,		-- minimum distance from effect origin
				RadialOffsetMax = 20,		-- maximum distance from effect origin
				ScaleMean = size,				-- mean scale (normal distribution)
				ScaleStdDev = size * 0.25,			-- standard deviation of scale (0 will make them all the same size)
				SpeedStretch = 0.05,			-- factor of speed by which to elongate the spark in the direction of travel (avoid using with rotation)
				SpeedMean = speed * 0.7,				-- mean speed of sparks at emission (normal distribution)
				SpeedStdDev = speed * 0.25,			-- standard deviation of spark speed at emission
				Drag = .2,					-- drag of sparks (zero will make them continue at same speed)
				RotationMean = 0,			-- mean initial rotation in degrees (e.g. -180, 45, 0) (normal distribution)
				RotationStdDev = 0,		-- standard deviation of initial rotation in degrees (zero will make them start at the same angle)
				RotationalSpeedMean = 0,	-- mean rotational speed in degrees per second (e.g. -180, 45, 0) (normal distribution)
				RotationalSpeedStdDev = 0,	-- standard deviation of rotational speed in degrees per second (zero will make them rotate at the same rate)
				AgeMean = .7,				-- mean age in seconds (normal distribution)
				AgeStdDev = 0.2,				-- standard deviation of age in seconds (zero makes them last the same length of time)
				AlphaKeys = { 0, 0.5 },	-- fractions of life span between which the spark reaches full alpha (fade in -> full alpha -> fade out)
				ScaleKeys = { 0, 0.5 },	-- fractions of life span between which the spark reaches full scale (balloon in -> full scale -> shrink out)
			},
			{
				Angle = 0,
				RadialOffsetMin = 0,
				RadialOffsetMax = 20,
				ScaleMean = size,
				ScaleStdDev = size * 0.3,
				SpeedStretch = 0.05,
				SpeedMean = speed,
				SpeedStdDev = speed * 0.25,
				Drag = .2,
				RotationMean = 0,
				RotationStdDev = 0,
				RotationalSpeedMean = 0,
				RotationalSpeedStdDev = 0,
				AgeMean = 2,
				AgeStdDev = 0.3,
				AlphaKeys = { 0.1, 0.5 },
				ScaleKeys = { 0.1, 0.5 },
			},
			{
				Angle = 70,
				RadialOffsetMin = 0,
				RadialOffsetMax = 20,
				ScaleMean = size,
				ScaleStdDev = size * 0.25,
				SpeedStretch = 0.05,
				SpeedMean = speed * 0.8,
				SpeedStdDev = speed * 0.25,
				Drag = .2,
				RotationMean = 0,
				RotationStdDev = 0,
				RotationalSpeedMean = 0,
				RotationalSpeedStdDev = 0,
				AgeMean = .7,
				AgeStdDev = 0.2,
				AlphaKeys = { 0.1, 0.5 },
				ScaleKeys = { 0.1, 0.5 },
			},
		},
	}
end
function Smoke(amount, scale, life, speed)
	return {
	--DUST CLOUDS
		Type = "sparks",
		TimeToTrigger = 0,
		SparkCount = amount,
		LocalPosition = { x = 0, y = 0, z = 1 },	-- how to place the origin relative to effect position and direction (0, 0) 
		Texture = "effects/media/smoke",

		Gravity = 0,						-- gravity applied to particle (981 is earth equivalent)
		
		EvenDistribution =					-- distribute sparks evenly between two angles with optional variation
		{
			Min = -360,						-- minimum angle in degrees (e.g. -180, 45, 0)
			Max = 360,						-- maximum angle in degrees (e.g. -180, 45, 0)
			StdDev = 40,						-- standard deviation at each iteration in degrees (zero will make them space perfectly even)
		},

		Keyframes =							
		{
			{
				Angle = 0,
				RadialOffsetMin = 0,
				RadialOffsetMax = 20,
				ScaleMean = scale,
				ScaleStdDev = scale * 0.3,
				SpeedStretch = 0,
				SpeedMean = speed,	
				SpeedStdDev = speed * 0.4,
				Drag = 1,
				RotationMean = 0,
				RotationStdDev = 45,
				RotationalSpeedMean = 0,
				RotationalSpeedStdDev = 40,
				AgeMean = life,
				AgeStdDev = life * 0.3,
				AlphaKeys = { 0.5, 0.5 },
				ScaleKeys = { 0.1, 0.5 },
			},
		},
	}
end
function Dirt(size, speed)
	return {
	--DEBRIS
		Type = "sparks",
		TimeToTrigger = 0.1,
		SparkCount = 18,
		LocalPosition = { x = 0, y = 0 },	-- how to place the origin relative to effect position and direction (0, 0) 
		Texture = "mods/weapon_pack/effects/media/debris",

		Gravity = 0981,						-- gravity applied to particle (981 is earth equivalent)
		
		EvenDistribution =					-- distribute sparks evenly between two angles with optional variation
		{
			Min = -35,						-- minimum angle in degrees (e.g. -180, 45, 0)
			Max = 35,						-- maximum angle in degrees (e.g. -180, 45, 0)
			StdDev = 5,						-- standard deviation at each iteration in degrees (zero will make them space perfectly even)
		},

		Keyframes =							
		{
			{
				Angle = -35,
				RadialOffsetMin = 0,
				RadialOffsetMax = 20,
				ScaleMean = size,
				ScaleStdDev = size * 0.5,
				SpeedStretch = 0.05,
				SpeedMean = speed,
				SpeedStdDev = speed * 0.5,
				Drag = 1,
				RotationMean = 45,
				RotationStdDev = 180,
				RotationalSpeedMean = 10,
				RotationalSpeedStdDev = 5,
				AgeMean = 2,
				AgeStdDev = 0.5,
				AlphaKeys = { 0.1, 0.5 },
				ScaleKeys = { 0.1, 0.5 },
			},
			{
				Angle = 35,
				RadialOffsetMin = 0,
				RadialOffsetMax = 20,
				ScaleMean = size,
				ScaleStdDev = size * 0.5,
				SpeedStretch = 0.05,
				SpeedMean = speed,
				SpeedStdDev = speed * 0.5,
				Drag = 1,
				RotationMean = -45,
				RotationStdDev = -180,
				RotationalSpeedMean = 10,
				RotationalSpeedStdDev = 5,
				AgeMean = 2,
				AgeStdDev = 0.5,
				AlphaKeys = { 0.1, 0.5 },
				ScaleKeys = { 0.1, 0.5 },
			},
		},
	}
end