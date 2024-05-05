LifeSpan = 11111
Sprites = {}
table.insert(Sprites,
{
	Name = "sbpp_ApacheRotorSpin_left",
			
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
	Name = "sbpp_ApacheTailRotorSpin_left",
			
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
		Sprite = path .. "/weapons/apache/apacheBase2.png",
		Additive = false,
		TimeToLive = 10000,
		Angle = 0,
		InitialSize = 2,
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
		LocalPosition = { x = 0, y = 0, z = 0 },
		LocalVelocity = { x = 0, y = 0, z = 0 },
		Acceleration = { x = 0, y = 0, z = 0 },
		Drag = 0.0,
		Sprite = "sbpp_ApacheRotorSpin_left",
		Additive = false,
		TimeToLive = 10000,
		Angle = 0,
		InitialSize = 2,
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
		LocalPosition = { x = 0, y = 0, z = 0 },
		LocalVelocity = { x = 0, y = 0, z = 0 },
		Acceleration = { x = 0, y = 0, z = 0 },
		Drag = 0.0,
		Sprite = "sbpp_ApacheTailRotorSpin_left",
		Additive = false,
		TimeToLive = 10000,
		Angle = 0,
		InitialSize = 2,
		ExpansionRate = 0,
		AngularVelocity = 0,
		RandomAngularVelocityMagnitude = 0,
		Colour1 = { 255, 255, 255, 255 },
		Colour2 = { 255, 255, 255, 255 },
		KillParticleOnEffectCancel = true,
	},
}