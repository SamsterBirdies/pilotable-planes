function Merge(t1, t2) for k, v in pairs(t2) do t1[k] = v end end

Merge(Device,
{	
	ammo_sbpp_Biplane = L"Биплан",

	ammo_sbpp_f16 = L"F-16 Боевой сокол",
	
	ammo_sbpp_p51 = L"P-51 Мустанг",

	ammo_sbpp_hellcat = L"F6F Хелкэт",

	ammo_sbpp_ac130 = L"AC-130 Ганшип",
	
	ammo_sbpp_littlebird = L"AH-6 Литтл Бëрд",

})

Merge(Weapon,
{
	--plane weaponry
	sbpp_m1911 = L"M1911",
	sbpp_flechettes = L"Флешетта",
	sbpp_grenades = L"Граната",
	sbpp_gau8 = L"GAU-8 Аvenger",
	sbpp_bombs = L"Mk82 бомба",
	sbpp_flares = L"Фальшфейер",
	sbpp_paveway = L"Paveway бомба",
	sbpp_vulcan = L"M61 Vulcan",
	sbpp_sidewinders = L"Sidewinder ракета",
	sbpp_bomb250kg = L"250kg бомба",
	sbpp_gau12 = L"GAU-12 Equalizer",
	sbpp_bofors = L"Bofors 40мм",
	sbpp_howitzer105mm = L"105-мм гаубица",
	sbpp_chaingun = L"Цепная пушка",
	sbpp_hydra = L"Hydra ракета",
	sbpp_hellfire = L"AGM-114 Hellfire ракета",
	sbpp_m134 = L"M134 Minigun",
})