--MaxFireClamp = 0.01
for k, v in pairs(dlc2_Ammunition) do
	if v.Projectile == "thunderbolt" or "nighthawk" then
		v.MinFireSpeed = 3600
		v.MaxFireSpeed = 3600.1
	end
end