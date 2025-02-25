function Merge(t1, t2) for k, v in pairs(t2) do t1[k] = v end end

Merge(Device,
{	
	ammo_sbpp_Biplane = L"双翼机",
	ammo_sbpp_BiplaneTip2 = L"能够发射机载M1911以及洒落反战壕武器及手雷。",
	
	ammo_sbpp_f16 = L"F-16战隼战机",
	ammo_sbpp_f16Tip2 = L"能够发射M61航空机炮以及AIM-9响尾蛇导弹。",
	
	ammo_thunderboltTip2 = L"能够发射GAU-8复仇者机炮以及投掷Mk82小直径炸弹。",
	
	ammo_sbpp_p51 = L"P-51野马战斗机",
	ammo_sbpp_p51Tip2 = L"能够发射六发霰弹以及投掷250Kg当量炸弹。",
	
	ammo_sbpp_hellcat = L"F6F地狱猫战斗机",
	ammo_sbpp_hellcatTip2 = L"能够发射六发霰弹以及投掷250Kg当量炸弹。",
	
	ammo_sbpp_ac130 = L"AC-130炮艇",
	ammo_sbpp_ac130Tip2 = L"能够发射25mm GAU-12速射机炮,40mm博福斯高炮以及105mm榴弹炮。",
	ammo_sbpp_ac130Tip3 = L"武器需要使用鼠标瞄准。",
	ammo_sbpp_ac130Tip4 = L"需要飞机跑道II型才能使用。",
	
	ammo_sbpp_apache = L"阿帕奇武装直升机",
	ammo_sbpp_apacheTip2 = L"能够发射30mm链炮,九头蛇火箭弹以及地狱火导弹。",
	ammo_sbpp_apacheTip3 = L"地狱火导弹会向鼠标位置开火。",
	
	ammo_sbpp_littlebird = L"AH-6小鸟",
	ammo_sbpp_littlebirdTip2 = L"能够发射M134迷你砲以及九头蛇火箭弹。",
	
	ammo_sbpp_mig15 = L"米格-15",
	
	ammo_sbpp_spitfire = L"噴火戰鬥機",
	
	ammo_sbpp_b52 = L"B-52同溫層堡壘",
})

Merge(Weapon,
{
	--plane weaponry
	sbpp_m1911 = L"M1911",
	sbpp_flechettes = L"飛鏢彈",
	sbpp_grenades = L"手榴弹",
	sbpp_gau8 = L"GAU-8复仇者机炮",
	sbpp_bombs = L"Mk82炸彈",
	sbpp_flares = L"熱誘彈",
	sbpp_paveway = L"宝石路",
	sbpp_vulcan = L"火神式機砲",
	sbpp_sidewinders = L"響尾蛇飛彈",
	sbpp_bomb250kg = L"250kg炸弹",
	sbpp_gau12 = L"GAU-12平衡者机炮",
	sbpp_bofors = L"40公厘波佛斯",
	sbpp_howitzer105mm = L"105公厘榴弹炮",
	sbpp_chaingun = L"鏈炮",
	sbpp_hydra = L"九頭蛇航空火箭彈",
	sbpp_hellfire = L"地獄火飛彈",
	sbpp_m134 = L"M134迷你砲機槍",
	
	sbpp_rp3 = L"RP-3",
	sbpp_mig15gun1 = L"NR-23機炮",
	sbpp_mig15gun2 = L"N-37機炮",
	sbpp_50cal = L"白朗寧M2重機槍",
	sbpp_303cal = L"白朗寧M1919中型機槍",
	sbpp_alcm = L"AGM-86C导弹",
})