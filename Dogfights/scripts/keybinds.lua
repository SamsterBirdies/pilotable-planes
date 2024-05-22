--written by Flinnshadow, thanks.
PP_Keys = {"Fire1","Fire2","Fire3","ThrottleUp","ThrottleDown","ElevatorUp","ElevatorDown","SelectNext","SelectPrev"}
Fire1 = " "
Fire2 = "b"
Fire3 = "n"
ThrottleUp = "w"
ThrottleDown = "s"
ElevatorUp = "d"
ElevatorDown = "a"
ScrollIn = "mouse wheel"
ScrollOut = "mouse wheel"
SelectNext = "page up"
SelectPrev = "page down"
Select = "mouse left"
Deselect = "mouse right" --backspace, delete, 1-9 TODO: support for tables, mostly an issue of player input 

KeyChangeStorage = {}

function ChangeKeybindsControlSetup()
   CurrentKeybindBeingSet = false
   KeybindsDisplayUp = false

   DeleteControl("", "SB_PP_Root")
	LoadControl(path .. "/ui/keybinds_control.lua", "")

	SetButtonCallback("SB_PP_Root", "SB_PP_Pin", 0)

	--[[SetButtonCallback("MADListParent", "MADLeft", 1)
	SetButtonCallback("MADListParent", "MADRight", 2)
	SetButtonCallback("MADMod1", "Description1", 3)]]

	--[[SetButtonCallback("MADMod2", "Description2", 4)
	SetButtonCallback("MADMod3", "Description3", 5)
	SetButtonCallback("MADMod4", "Description4", 6)
	SetButtonCallback("MADMod5", "Description5", 7)
	SetButtonCallback("MADMod6", "Description6", 8)
	SetButtonCallback("MADMod7", "Description7", 3)]]

   --ShowControl("", "SB_PP_Root", true)
	ShowControl("SB_PP_Root", "SB_PP_Box", false)

   ShowControl("SB_PP_Box", "DescriptionDisplay", false)

   SetControlSpriteByParent("SB_PP_Root", "SB_PP_Pin", "ui/textures/Edit-A.png")
end

function OnKeyKeybinds(key, down)
	if CurrentKeybindBeingSet and not down then
      KeyChangeStorage[CurrentKeybindBeingSet] = key
      SetControlColour("SB_PP_Root", "SB_PP_"..CurrentKeybindBeingSet.."Key", Colour(255,255,0,255))
	  if key == " " then
	      SetControlText("SB_PP_Root", "SB_PP_"..CurrentKeybindBeingSet.."Key", "space")
	  else
          SetControlText("SB_PP_Root", "SB_PP_"..CurrentKeybindBeingSet.."Key", key) -- idealy TextW but it errors
	  end
      --_G[CurrentKeybindBeingSet] = key
      --[[if key == "enter" then
         _G[CurrentKeybindBeingSet] = CurrentKeybindBeingSet
      else
         CurrentKeybindBeingSet = key
      end]]
      CurrentKeybindBeingSet = false
   end
end
function KeybindsOnControlActivated(name)
	if InReplay() then return end
	if name == "SB_PP_Pin" then -- show/hide panel
		KeybindsDisplayUp = not(KeybindsDisplayUp)
		ShowControl("SB_PP_Root", "SB_PP_Box", KeybindsDisplayUp)
		if KeybindsDisplayUp == true then
			EnableCameraControls(false)
			SetControlSpriteByParent("SB_PP_Root", "SB_PP_Pin", "ui/textures/Edit-S.png")
		else
			EnableCameraControls(true)
			SetControlSpriteByParent("SB_PP_Root", "SB_PP_Pin", "ui/textures/Edit-A.png")
		end
	elseif name == "SB_PP_Confirm" then
      SetNewKeybinds()
	elseif name == "SB_PP_Back" then
      CancelNewKeybinds()
   else
      for i=1,#PP_Keys do
         if "SB_PP_"..PP_Keys[i] == name then
            if CurrentKeybindBeingSet ~= PP_Keys[i] then
               SetControlColour("SB_PP_Root", name.."Key", Colour(255,0,0,255))
               SetControlTextW("SB_PP_Root", name.."Key", L"_")
               CurrentKeybindBeingSet =  PP_Keys[i]
            else CurrentKeybindBeingSet = false end
         end
      end
   end
end

function SetNewKeybinds()
   for key, value in pairs(KeyChangeStorage) do
      _G[key] = value
      SetControlColour("SB_PP_Root", "SB_PP_"..key.."Key", Colour(255,255,255,255))
   end
   KeyChangeStorage = {}
end

function CancelNewKeybinds()
   for key, value in pairs(KeyChangeStorage) do
      SetControlColour("SB_PP_Root", "SB_PP_"..key.."Key", Colour(255,255,255,255))
      SetControlText("SB_PP_Root", "SB_PP_"..key.."Key", _G[key]) -- idealy TextW but it errors
   end
   KeyChangeStorage = {}
end