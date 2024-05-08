function CreateDust(color, size, speed)
	return
		{
		--DUST CLOUDS
			Type = "sparks",
			TimeToTrigger = 0.04,
			SparkCount = 1,
			LocalPosition = { x = 0, y = 0, z = -200 },	-- how to place the origin relative to effect position and direction (0, 0) 
			Texture = "effects/media/steam",
	
			Gravity = 0,						-- gravity applied to particle (981 is earth equivalent)
			
			EvenDistribution =					-- distribute sparks evenly between two angles with optional variation
			{
				Min = -10,						-- minimum angle in degrees (e.g. -180, 45, 0)
				Max = 10,						-- maximum angle in degrees (e.g. -180, 45, 0)
				StdDev = 5,						-- standard deviation at each iteration in degrees (zero will make them space perfectly even)
			},
	
			Keyframes =							
			{
				{
					Angle = 0,
					RadialOffsetMin = 0,
					RadialOffsetMax = 50,
					ScaleMean = size,
					ScaleStdDev = size / 3,
					SpeedStretch = 0,
					SpeedMean = speed,
					SpeedStdDev = speed / 3,
					Drag = 1,
					RotationMean = 0,
					RotationStdDev = 500,
					RotationalSpeedMean = 0,
					RotationalSpeedStdDev = 500,
					AgeMean = 0.4,
					AgeStdDev = 0.1,
					AlphaKeys = { 0.1, 0.25 },
					ScaleKeys = { 0.1, 1 },
					colour = color,
				},
			},
		}
end