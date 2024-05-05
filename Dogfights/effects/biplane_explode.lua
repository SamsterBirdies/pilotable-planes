dofile("effects/device_explode_large_util.lua")
LifeSpan = 3
Effects =
{
	Debris(path .. "/effects/media/debris/biplane2.png"),
	Debris(path .. "/effects/media/debris/biplane0.png"),
	Debris(path .. "/effects/media/debris/biplane1.png"),
	Debris(path .. "/effects/media/debris/biplane3.png"),
	Debris(path .. "/effects/media/debris/biplane2.png"),
	Debris(path .. "/effects/media/debris/biplane3.png"),
	DeviceExplodeSprite(),
}
SoundEvent = "effects/derrick_explode"