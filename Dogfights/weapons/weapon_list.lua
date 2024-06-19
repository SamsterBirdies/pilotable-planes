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