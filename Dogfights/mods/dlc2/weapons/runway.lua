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