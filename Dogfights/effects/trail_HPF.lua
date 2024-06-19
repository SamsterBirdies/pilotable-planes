dofile(path .. "/effects/util.lua")
dofile("effects/device_explode_util.lua")
--  age (in seconds) at which the explosion actor deletes itself
--  make sure this exceedes the age of all effects
LifeSpan = 12
SoundEvent = "mods/weapon_pack/effects/20mmcannon_trail.lua"

Effects =
{
   {
      Type = "trail",
      Texture = "mods/weapon_pack/effects/media/trail.dds",
      LocalPosition = { x = 0, y = 0, z = 9.0 },
      Colour = { 254, 111, 89, 128 },
      Width = 20,
      Length = 0.15,
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
      Colour = { 255, 200, 200, 200 },
      Width = 2,
      Length = 0.3,
      Keyframes = 100,
      KeyframePeriod = 0.05,
      RepeatRate = 0.001,
      ScrollRate = 0,
      FattenRate = 0,
   },
}