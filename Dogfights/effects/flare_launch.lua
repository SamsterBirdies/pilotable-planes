LifeSpan = 6
SoundEvent = "mods/dogfights/effects/launch_flare"
LaunchDelay = 0
EffectVerticalOffset = 1
EffectDepth = -100
Effects =
{
	{
	--DUST CLOUDS
		Type = "sparks",
		TimeToTrigger = 0.0,
		SparkCount = 15,
		LocalPosition = { x = 0, y = 0, z = -2 },	-- how to place the origin relative to effect position and direction (0, 0) 
		Sprite = "effects/media/Steam",
		Additive = false,
		Gravity = 0,						-- gravity applied to particle (981 is earth equivalent)
		
		EvenDistribution =					-- distribute sparks evenly between two angles with optional variation
		{
			Min = -180,						-- minimum angle in degrees (e.g. -180, 45, 0)
			Max = 180,						-- maximum angle in degrees (e.g. -180, 45, 0)
			StdDev = 10,						-- standard deviation at each iteration in degrees (zero will make them space perfectly even)
		},

		Keyframes =							
		{
			{
				Angle = 90,				-- angle of keyframe in degrees (e.g. -180, 45, 0)
				RadialOffsetMin = 0,		-- minimum distance from effect origin
				RadialOffsetMax = 20,		-- maximum distance from effect origin
				ScaleMean = 0.4,				-- mean scale (normal distribution)
				ScaleStdDev = 0.1,			-- standard deviation of scale (0 will make them all the same size)
				SpeedStretch = 0,			-- factor of speed by which to elongate the spark in the direction of travel (avoid using with rotation)
				SpeedMean = 900,				-- mean speed of sparks at emission (normal distribution)
				SpeedStdDev = 10,			-- standard deviation of spark speed at emission
				Drag = 3,					-- drag of sparks (zero will make them continue at same speed)
				RotationMean = 0,			-- mean initial rotation in degrees (e.g. -180, 45, 0) (normal distribution)
				RotationStdDev = 45,		-- standard deviation of initial rotation in degrees (zero will make them start at the same angle)
				RotationalSpeedMean = -180,	-- mean rotational speed in degrees per second (e.g. -180, 45, 0) (normal distribution)
				RotationalSpeedStdDev = 0,	-- standard deviation of rotational speed in degrees per second (zero will make them rotate at the same rate)
				AgeMean = 2.5,				-- mean age in seconds (normal distribution)
				AgeStdDev = 0.25,				-- standard deviation of age in seconds (zero makes them last the same length of time)
				AlphaKeys = { 0.1, 1 },
				ScaleKeys = { 0.1, 0.2 },	-- fractions of life span between which the spark reaches full scale (balloon in -> full scale -> shrink out)
			},
			{
				Angle = 0,					-- angle of keyframe in degrees (e.g. -180, 45, 0)
				RadialOffsetMin = 0,		-- minimum distance from effect origin
				RadialOffsetMax = 20,		-- maximum distance from effect origin
				ScaleMean = 0.5,			-- mean scale (normal distribution)
				ScaleStdDev = 0.1,			-- standard deviation of scale (0 will make them all the same size)
				SpeedStretch = 0,			-- factor of speed by which to elongate the spark in the direction of travel (avoid using with rotation)
				SpeedMean = 1500,				-- mean speed of sparks at emission (normal distribution)
				SpeedStdDev = 50,			-- standard deviation of spark speed at emission
				Drag = 7,					-- drag of sparks (zero will make them continue at same speed)
				RotationMean = 0,			-- mean initial rotation in degrees (e.g. -180, 45, 0) (normal distribution)
				RotationStdDev = 45,		-- standard deviation of initial rotation in degrees (zero will make them start at the same angle)
				RotationalSpeedMean = 5,	-- mean rotational speed in degrees per second (e.g. -180, 45, 0) (normal distribution)
				RotationalSpeedStdDev = 0,	-- standard deviation of rotational speed in degrees per second (zero will make them rotate at the same rate)
				AgeMean = 3.0,				-- mean age in seconds (normal distribution)
				AgeStdDev = 0.5,				-- standard deviation of age in seconds (zero makes them last the same length of time)
				AlphaKeys = { 0.1, 1 },
				ScaleKeys = { 0.1, 0.2 },	-- fractions of life span between which the spark reaches full scale (balloon in -> full scale -> shrink out)
			},
			{
				Angle = 90,					-- angle of keyframe in degrees (e.g. -180, 45, 0)
				RadialOffsetMin = 0,		-- minimum distance from effect origin
				RadialOffsetMax = 20,		-- maximum distance from effect origin
				ScaleMean = 0.4,				-- mean scale (normal distribution)
				ScaleStdDev = 0.1,			-- standard deviation of scale (0 will make them all the same size)
				SpeedStretch = 0,			-- factor of speed by which to elongate the spark in the direction of travel (avoid using with rotation)
				SpeedMean = 900,				-- mean speed of sparks at emission (normal distribution)
				SpeedStdDev = 10,			-- standard deviation of spark speed at emission
				Drag = 3,					-- drag of sparks (zero will make them continue at same speed)
				RotationMean = 0,			-- mean initial rotation in degrees (e.g. -180, 45, 0) (normal distribution)
				RotationStdDev = 45,		-- standard deviation of initial rotation in degrees (zero will make them start at the same angle)
				RotationalSpeedMean = 180,	-- mean rotational speed in degrees per second (e.g. -180, 45, 0) (normal distribution)
				RotationalSpeedStdDev = 0,	-- standard deviation of rotational speed in degrees per second (zero will make them rotate at the same rate)
				AgeMean = 2.5,				-- mean age in seconds (normal distribution)
				AgeStdDev = 0.25,				-- standard deviation of age in seconds (zero makes them last the same length of time)
				AlphaKeys = { 0.1, 1 },
				ScaleKeys = { 0.1, 0.2 },	-- fractions of life span between which the spark reaches full scale (balloon in -> full scale -> shrink out)
			},
		},
	},
}