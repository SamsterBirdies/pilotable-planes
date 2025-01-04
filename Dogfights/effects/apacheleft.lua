LifeSpan = 1
SCALE = 2
Sprites = {}
table.insert(Sprites,
{
	Name = "sbpp_ApacheRotorSpin",
			
	States =
	{
		Normal =  
		{  
			Frames =
			{
				{ texture = path .. "/weapons/apache/apacheRotor1.png" },
				{ texture = path .. "/weapons/apache/apacheRotor21.png" },
				{ texture = path .. "/weapons/apache/apacheRotor3.png" },
				{ texture = path .. "/weapons/apache/apacheRotor41.png" },
				
				duration = 0.04,
				mipmap = true,
			},
			NextState = "Normal",
		},
	},
})
table.insert(Sprites,
{
	Name = "sbpp_ApacheTailRotorSpin",
			
	States =
	{
		Normal =  
		{  
			Frames =
			{
				{ texture = path .. "/weapons/apache/apacheTailRotor1.png" },
				{ texture = path .. "/weapons/apache/apacheTailRotor2.png" },
				{ texture = path .. "/weapons/apache/apacheTailRotor4.png" },
				{ texture = path .. "/weapons/apache/apacheTailRotor3.png" },
				
				duration = 0.04,
				mipmap = true,
			},
			NextState = "Normal",
		},
	},
})
Effects =
{

	{
		Type = "sprite",
		TimeToTrigger = 0,
		LocalPosition = { x = 0, y = 0, z = 0 },
		LocalVelocity = { x = 0, y = 0, z = 0 },
		Acceleration = { x = 0, y = 0, z = 0 },
		Drag = 0.0,
		Sprite = path .. "/weapons/apache/apacheBaseL.png",
		Additive = false,
		TimeToLive = 10000,
		Angle = 0,
		InitialSize = SCALE,
		ExpansionRate = 0,
		AngularVelocity = 0,
		RandomAngularVelocityMagnitude = 0,
		Colour1 = { 255, 255, 255, 255 },
		Colour2 = { 255, 255, 255, 255 },
		KillParticleOnEffectCancel = true,
	},
	{
		Type = "sprite",
		TimeToTrigger = 0,
		LocalPosition = { x = -19.875 * SCALE, y = 20.625 * SCALE, z = 0 },
		LocalVelocity = { x = 0, y = 0, z = 0 },
		Acceleration = { x = 0, y = 0, z = 0 },
		Drag = 0.0,
		Sprite = "sbpp_ApacheRotorSpin",
		Additive = false,
		TimeToLive = 10000,
		Angle = 0,
		InitialSize = SCALE,
		ExpansionRate = 0,
		AngularVelocity = 0,
		RandomAngularVelocityMagnitude = 0,
		Colour1 = { 255, 255, 255, 255 },
		Colour2 = { 255, 255, 255, 255 },
		KillParticleOnEffectCancel = true,
	},
	{
		Type = "sprite",
		TimeToTrigger = 0,
		LocalPosition = { x = 83.625 * SCALE, y = 12.75 * SCALE, z = 0 },
		LocalVelocity = { x = 0, y = 0, z = 0 },
		Acceleration = { x = 0, y = 0, z = 0 },
		Drag = 0.0,
		Sprite = "sbpp_ApacheTailRotorSpin",
		Additive = false,
		TimeToLive = 10000,
		Angle = 0,
		InitialSize = SCALE,
		ExpansionRate = 0,
		AngularVelocity = 0,
		RandomAngularVelocityMagnitude = 0,
		Colour1 = { 255, 255, 255, 255 },
		Colour2 = { 255, 255, 255, 255 },
		KillParticleOnEffectCancel = true,
	},
}