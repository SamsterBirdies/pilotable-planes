dofile("scripts/type.lua")
--[[local r1 = FindWeapon("runway")
if r1 then
	r1.Upgrades[1].EnergyCost = 5000
end]]
local r2 = FindWeapon("runway2")
if r2 then
	r2.EnergyCost = 9000
	if not r2.Upgrades then r2.Upgrades = {} end
	r2.Upgrades =
	{
		{
			Enabled = true,
			SaveName = "sbpp_runway3",
			MetalCost = 1000,
			EnergyCost = 12000,
			
		}
	}
	table.insert(Weapons, IndexOfWeapon("runway2") + 1,
		InheritType(FindWeapon("runway2"),nil,
			{	
				SaveName = "sbpp_runway3",
				FileName = path .. "/weapons/runway3.lua",
				MetalCost = 2000,
				EnergyCost = 22000,
				BuildTimeComplete = 180.0,
				Prerequisite = "upgrade",
				Enabled = false,
				Upgrades = {},
				BuildQueueModifier = 
				{ 
					["dlc2_runway"] = 2, 
					["dlc2_runway2"] = 1,
				},
			}
		)
	)
end



--[=[hardpoint = FindWeapon("hardpoint")
if hardpoint then
   table.insert(hardpoint.Upgrades,
   {
      Enabled = true,
      SaveName = "hardpointflak",
      MetalCost = 100,
      EnergyCost = 1000,
      Button = "hud-context-upgrade-deckgun",
      --Prerequisite = {{"armoury"},{"upgrade"}},
   })
   --[[if hardpoint.ProxyUpgrades then Log(tostring(hardpoint.ProxyUpgrades)) end
   hardpoint.ProxyUpgrades =
   {
       {
           MetalCost = 100,
           EnergyCost = 1000,
           SaveName = "hardpointhaflak",
       },
   }]]
   table.insert(Weapons, IndexOfWeapon("hardpoint") + 1,
   {
      Enabled = false,
      SaveName = "hardpointflak",
      FileName = path .. "/weapons/HardPointFlak/hardpointflak.lua",
      SelectEffect = "ui/hud/weapons/ui_weapons",
      Prerequisite = "upgrade",-- "armoury",
      Icon = "hud-hardpoint-icon",-- "hud-flak-icon", --"hud-turret-icon",
      GroupButton = "hud-group-flak", --"hud-group-turret",
      Detail = "hud-detail-hardpoint",--"hud-detail-flak", "hud-detail-turret",
      BuildTimeComplete = 45.0,
      BuildTimeIntermediate = 11,
      BuildOnGroundOnly = false,
      MaxUpAngle = 20,
      MaxSpotterAssistance = 1,
      MetalCost = 600,--700
      EnergyCost = 2500,--4000
      ScrapPeriod = 10,
      MetalReclaimMax = 0.5,
      EnergyReclaimMax = 0.5,
      MetalReclaimMin = 0.25,
      EnergyReclaimMin = 0.1,
      MetalRepairCost = 100,
      EnergyRepairCost = 500,
      --[[Upgrades = {
         Enabled = true,
         EnergyCost = 0,
         SaveName = "hardpointhaflak",
         CanDowngrade = false,
         MetalCost = 0,
         Button = "hud-context-turret2-focus",
         TransferReloadProgress = true,
         BuildDuration = 1
     },]]


   })--[[
   table.insert(Weapons, IndexOfWeapon("hardpoint") + 1,
   {
      Enabled = false,
      SaveName = "hardpointhaflak",
      FileName = path .. "/weapons/HardPointHAFlak/hardpointhaflak.lua",
      SelectEffect = "ui/hud/weapons/ui_weapons",
      Prerequisite = "upgrade",-- "armoury",
      Icon = "hud-hardpoint-icon",-- "hud-flak-icon", --"hud-turret-icon",
      GroupButton = "hud-group-flak", --"hud-group-turret",
      Detail = "hud-detail-hardpoint",--"hud-detail-flak", "hud-detail-turret",
      BuildTimeComplete = 45.0,
      BuildTimeIntermediate = 11,
      BuildOnGroundOnly = false,
      MaxUpAngle = 20,
      MaxSpotterAssistance = 1,
      MetalCost = 600,--700
      EnergyCost = 2500,--4000
      ScrapPeriod = 10,
      MetalReclaimMax = 0.5,
      EnergyReclaimMax = 0.5,
      MetalReclaimMin = 0.25,
      EnergyReclaimMin = 0.1,
      MetalRepairCost = 100,
      EnergyRepairCost = 500,
      Upgrades = {
         Enabled = true,
         EnergyCost = 0,
         SaveName = "hardpointflak",
         CanDowngrade = false,
         MetalCost = 0,
         Button = "hud-context-turret2-focus",
         TransferReloadProgress = true,
         BuildDuration = 1,
     },

   })]]
end]=]