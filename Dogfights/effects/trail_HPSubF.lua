
--  age (in seconds) at which the explosion actor deletes itself
--  make sure this exceedes the age of all effects
LifeSpan = 5.0

Effects =
{
   {
      Type = "trail",
      Texture = "mods/weapon_pack/effects/media/trail.dds",
      LocalPosition = { x = 0, y = 0, z = 9.0 },
      Colour = { 254, 111, 89, 128 },
      Width = 5,
      Length = 0.1,
      Keyframes = 20,
      KeyframePeriod = 0.01,
      RepeatRate = 0.001,
      ScrollRate = 0,
      FattenRate = 0,
   },
	{
		Type = "trail",
		Texture = "objects/projectiles/missile/trail.dds",
		LocalPosition = { x = 0, y = 0, z = 9.0 },
      Colour = { 255, 200, 200, 100 },
		Width = 1.5,
		Length = 0.25,
		Keyframes = 100,
		KeyframePeriod = 0.05,
		RepeatRate = 0.001,
		ScrollRate = 0,
		FattenRate = 0,
	}
}
