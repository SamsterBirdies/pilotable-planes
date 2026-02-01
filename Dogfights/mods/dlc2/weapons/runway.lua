--MaxFireClamp = 0.01
for k, v in pairs(dlc2_Ammunition) do
	if v.Projectile == "thunderbolt" then
		table.remove(dlc2_Ammunition, k)
		break
	end
end
for k, v in pairs(dlc2_Ammunition) do
	if v.Projectile == "nighthawk" then
		table.remove(dlc2_Ammunition, k)
		break
	end
end
Projectile = nil
AmmoRows =
{
	{ Name = "mk1", Sprite = path .. "/ui/textures/context/mki" },
	{ Name = "mk2", Sprite =  path .. "/ui/textures/context/mkii" },
	{ Name = "mk3", Sprite =  path .. "/ui/textures/context/mkiii" },
}