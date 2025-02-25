function Merge(t1, t2) for k, v in pairs(t2) do t1[k] = v end end

Merge(Device,
{	
	ammo_sbpp_Biplane = L"複葉機",
	
	ammo_sbpp_f16 = L"F-16 ファイティング・ファルコン",
	
	ammo_sbpp_p51 = L"P-51 マスタング",
	
	ammo_sbpp_hellcat = L"F6F ヘルキャット",
	
	ammo_sbpp_ac130 = L"AC-130 ガンシップ",
	
	ammo_sbpp_apache = L"AH-64 アパッチ",
	
	ammo_sbpp_littlebird = L"AH-6 リトルバード",
	
	ammo_sbpp_b52 = L"B-52 ストラトフォートレス",
})

Merge(Weapon,
{
	--plane weaponry
	sbpp_m1911 = L"M1911",
	sbpp_flechettes = L"フレシェット弾",
	sbpp_grenades = L"手榴弾",
	sbpp_gau8 = L"GAU-8 アヴェンジャー",
	sbpp_bombs = L"Mk.82 爆弾",
	sbpp_flares = L"フレア",
	sbpp_paveway = L"ペイブウェイ",
	sbpp_vulcan = L"M61 バルカン",
	sbpp_sidewinders = L"サイドワインダー",
	sbpp_bomb250kg = L"250kg 爆弾",
	sbpp_gau12 = L"GAU-12 イコライザー",
	sbpp_bofors = L"40mm ボフォース",
	sbpp_howitzer105mm = L"105mm榴弾砲",
	sbpp_chaingun = L"M230機関砲",
	sbpp_hydra = L"ハイドラ ロケット弾",
	sbpp_hellfire = L"ヘルファイア ミサイル",
	sbpp_m134 = L"M134 ミニガン",
	
	sbpp_rp3 = L"RP-3",
	sbpp_mig15gun1 = L"NR-23 機関砲",
	sbpp_mig15gun2 = L"N-37 機関砲",
	sbpp_50cal = L"ブローニングM2重機関銃",
	sbpp_303cal = L"ブローニングM1919重機関銃",
	sbpp_alcm = L"AGM-86C 空中発射巡航ミサイル",
})