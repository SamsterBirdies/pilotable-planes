if dlc2_Ammunition then
	for k, v in pairs(dlc2_Ammunition) do
		local r2 = false
		local r3 = false
		for kk, vv in pairs(v.Weapons) do
			if vv == "runway2" then r2 = true end
			if vv == "sbpp_runway3" then r3 = true end
		end
		if r2 == true and r3 == false then
			table.insert(v.Weapons, "sbpp_runway3")
		end
	end
end