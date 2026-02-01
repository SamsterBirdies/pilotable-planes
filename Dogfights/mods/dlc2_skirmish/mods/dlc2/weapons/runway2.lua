for k, v in pairs(dlc2_Ammunition) do
	if v.Projectile == "thunderbolt" then
		v.RowName = "mk2"
		break
	end
end
for k, v in pairs(dlc2_Ammunition) do
	if v.Projectile == "nighthawk" then
		v.RowName = "mk2"
		break
	end
end
AmmoRows =
{
	{ Name = "mk1", Sprite = path .. "/ui/textures/context/mki" },
	{ Name = "mk2", Sprite =  path .. "/ui/textures/context/mkii" },
	{ Name = "mk3", Sprite =  path .. "/ui/textures/context/mkiii" },
}