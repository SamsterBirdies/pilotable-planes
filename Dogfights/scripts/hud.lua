function ReleaseControl(id)
	--stop controlling plane
	user_control = 0
	SendScriptEvent("SetPlaneFree", SSEParams(id, true), "script.lua", true)
	LockControls(false)
	EnableCameraControls(true)
	ShowHUD(true, true)
	local control_frame = GetControlFrame()
	SetControlFrame(0)
	SetControlText("sbplanes_bl", "speed", "")
	SetControlText("sbplanes_bl", "altitude", "")
	SetControlText("sbplanes_bl", "angle", "")
	SetControlColour("sbplanes_bl", "aim", Colour(255, 255, 255, 0))
	SetControlText("sbplanes_br", "gun1", "")
	SetControlText("sbplanes_br", "gun2", "")
	SetControlText("sbplanes_br", "gun3", "")
	SetControlText("sbplanes_br", "gun1name", "")
	SetControlText("sbplanes_br", "gun2name", "")
	SetControlText("sbplanes_br", "gun3name", "")
	SetControlColour("sbplanes_br", "gun1aim", Colour(255, 255, 255, 0))
	SetControlColour("sbplanes_br", "gun2aim", Colour(255, 255, 255, 0))
	SetControlColour("sbplanes_br", "gun3aim", Colour(255, 255, 255, 0))
	SetControlColour("sbpphpbar", "bgbg", Colour(255, 255, 255, 0))
	SetControlColour("sbpphpbar", "bg", Colour(255, 255, 255, 0))
    SetControlColour("sbpphpbar", "fg", Colour(255, 255, 255, 0))
	SetControlText("sbplanes_bl", "hp_max", "")
	SetControlText("sbplanes_bl", "hp_remaining", "")
	SetControlColour("sbpphpbar", "hp", Colour(255, 255, 255, 0))
	SetControlSpriteByParent("SB_PP_Root", "SB_PP_Pin", "ui/textures/Edit-A.png")
	SetControlFrame(control_frame)
	hud_open = false
end
function GetMaxScreenY()
	--Gets monitor aspect ratio. used for hud and camera stuff.
	local screen_y_max = 600
	for i = 1889, 150, -10 do
		if IsPointVisible(ScreenToWorld(Vec3(1066, i)), "") then
			screen_y_max = i
			break
		end
	end
	return screen_y_max
end
function GetCameraMaxZoom()
	--max zoom set by constants
	local constants_zoom_max = GetConstant("View.Limits.Zoom.Max")
	--get aspect ratio
	local screen_y_max = screen_max_y
	--get map size
	local world_extents = GetWorldExtents()
	local world_width = world_extents.MaxX - world_extents.MinX
	local world_height = world_extents.MaxY - world_extents.MinY
	--return max zoom for map size
	local max_zoom_width = world_width / 1066
	local max_zoom_height = world_height / screen_y_max
	return math.min(max_zoom_width, max_zoom_height, constants_zoom_max)
end

function LoadHUD()
	local spacing = 20
	local spacingr = 20
	local max_y = screen_max_y
	local width = 130 --for hp bar
	local control_frame = GetControlFrame()
	SetControlFrame(0)
	--left panel
	AddTextControl("", "sbplanes_bl", "", ANCHOR_BOTTOM_LEFT, Vec3(10, max_y - 10), false, "Normal")
	--hp bar
	AddTextControl("sbplanes_bl", "hp_remaining", "", ANCHOR_BOTTOM_LEFT, Vec3(3, -0.25), false, "Readout")
	AddTextControl("sbplanes_bl", "hp_max", "", ANCHOR_BOTTOM_RIGHT, Vec3(width - 3, -0.25), false, "Readout")
	AddTextControl("sbplanes_bl", "sbpphpbar", "", ANCHOR_BOTTOM_LEFT, Vec3(0, 2), false, "Normal")
	--add controls
	AddSpriteControl("sbpphpbar", "bgbg", path .. "/effects/media/white.png", ANCHOR_BOTTOM_LEFT, Vec3(width + 8,20), Vec3(-4, 4), false)
	AddSpriteControl("sbpphpbar", "bg", path .. "/effects/media/white.png", ANCHOR_BOTTOM_LEFT, Vec3(width,12), Vec3(0, 0), false)
    AddSpriteControl("sbpphpbar", "fg", path .. "/effects/media/white.png", ANCHOR_BOTTOM_LEFT, Vec3(width,12), Vec3(0, 0), false)
    AddSpriteControl("sbpphpbar", "hp", path .. "/effects/media/hp.png", ANCHOR_CENTER_CENTER, Vec3(10,10), Vec3(width / 2, -6), false)
	--change colors
	SetControlColour("sbpphpbar", "bgbg", Colour(255, 255, 255, 0))
	SetControlColour("sbpphpbar", "bg", Colour(64, 64, 64, 0))
    SetControlColour("sbpphpbar", "fg", Colour(96, 255, 96, 0))
    --SetControlColour("sbplanes_bl", "hp_remaining", Colour(64, 64, 64, 255))
    --SetControlColour("sbplanes_bl", "hp_max", Colour(64, 64, 64, 255))
	--flying stats
	AddTextControl("sbplanes_bl", "speed", "", ANCHOR_BOTTOM_LEFT, Vec3(0, -1 * spacing), false, "Normal")
	AddTextControl("sbplanes_bl", "altitude", "", ANCHOR_BOTTOM_LEFT, Vec3(0, -2 * spacing), false, "Normal")
	AddTextControl("sbplanes_bl", "angle", "", ANCHOR_BOTTOM_LEFT, Vec3(0, -3 * spacing), false, "Normal")
	AddSpriteControl("sbplanes_bl", "aim", path .. "/effects/media/aim_icon.dds", ANCHOR_BOTTOM_LEFT, Vec3(16,16), Vec3(35, -3 * spacing + 1.8), false)
	SetControlColour("sbplanes_bl", "aim", Colour(255, 255, 255, 0))
	
	--right panel
	AddTextControl("", "sbplanes_br", "", ANCHOR_BOTTOM_RIGHT, Vec3(1050, max_y - 10), false, "Normal")
	AddTextControl("sbplanes_br", "gun1name", "", ANCHOR_BOTTOM_RIGHT, Vec3(0, -4 * spacingr - 17), false, "Fine")
	AddTextControl("sbplanes_br", "gun1", "", ANCHOR_BOTTOM_RIGHT, Vec3(0, -4 * spacingr), false, "Normal")
	AddSpriteControl("sbplanes_br", "gun1aim", path .. "/effects/media/aim_icon.dds", ANCHOR_BOTTOM_LEFT, Vec3(15,15), Vec3(1, -4 * spacingr + 2), false)
	AddTextControl("sbplanes_br", "gun2name", "", ANCHOR_BOTTOM_RIGHT, Vec3(0, -2 * spacingr - 17), false, "Fine")
	AddTextControl("sbplanes_br", "gun2", "", ANCHOR_BOTTOM_RIGHT, Vec3(0, -2 * spacingr), false, "Normal")
	AddSpriteControl("sbplanes_br", "gun2aim", path .. "/effects/media/aim_icon.dds", ANCHOR_BOTTOM_LEFT, Vec3(15,15), Vec3(1, -2 * spacingr + 2), false)
	AddTextControl("sbplanes_br", "gun3name", "", ANCHOR_BOTTOM_RIGHT, Vec3(0, -0 * spacingr - 17), false, "Fine")
	AddTextControl("sbplanes_br", "gun3", "", ANCHOR_BOTTOM_RIGHT, Vec3(0, -0 * spacingr), false, "Normal")
	AddSpriteControl("sbplanes_br", "gun3aim", path .. "/effects/media/aim_icon.dds", ANCHOR_BOTTOM_LEFT, Vec3(15,15), Vec3(1, -0 * spacingr + 2), false)
	SetControlSize("sbplanes_br", "gun1aim", Vec3(0,0))
	SetControlSize("sbplanes_br", "gun2aim", Vec3(0,0))
	SetControlSize("sbplanes_br", "gun3aim", Vec3(0,0))
	SetControlFrame(control_frame)
end

function UpdateHUD(frame)
	if user_control > 0 then
		local control_frame = GetControlFrame()
		SetControlFrame(0)
		local user_control_str = tostring(user_control)
		local projectile_name = GetNodeProjectileSaveName(user_control)
		local teamId = NodeTeam(user_control)
		local pos = NodePosition(user_control)
		--remove hud
		
		if not hud_open then
			if KeybindsDisplayUp then
				ShowControl("SB_PP_Root", "SB_PP_Box", false)
				KeybindsDisplayUp = false
			end
			LockControls(true)
			EnableCameraControls(false)
			ShowHUD(false, true)
			SetControlSpriteByParent("SB_PP_Root", "SB_PP_Pin", path .. "/blank.png")
			SetControlColour("sbpphpbar", "bgbg", Colour(255, 255, 255, 64))
			SetControlColour("sbpphpbar", "bg", Colour(32, 32, 32, 128))
			SetControlColour("sbpphpbar", "fg", Colour(96, 255, 96, 164))
			SetControlColour("sbpphpbar", "hp", Colour(255, 255, 255, 255))
		end
		--camera follow
		CancelCameraMove()
		SetNamedScreenByZoom("pilot", AddVec(pos, MultiplyVec(camera_pos_offset, camera_zoom_target)), camera_zoom_target)
		RestoreScreen("pilot", frametime + 0.04, 0, true)

		--hp bar
		local hp_max = GetProjectileParamFloat(projectile_name, teamId, "AntiAirHitpoints", 1)
		local hp_remaining = GetProjectileAntiAirHitpoints(user_control)
		--local hp_remaining = frame % hp_max
		local hp_percent = hp_remaining / hp_max
		SetControlText("sbplanes_bl", "hp_max", tostring(math.floor(hp_max)))
		SetControlText("sbplanes_bl", "hp_remaining", tostring(math.floor(hp_remaining)))
		SetControlSize("sbpphpbar", "fg", Vec3(hp_percent * 130, 12))
		SetControlColour("sbpphpbar", "fg", Colour(350 - (hp_percent * 270), 60 + (hp_percent * 270), 96, 164))
		
		--flight stats
		local velocity = NodeVelocity(user_control)
		local speed = math.sqrt(velocity.x ^ 2 + velocity.y ^ 2)
		CastRay(pos, AddVec(pos, Vec3(0,999900)), RAY_STANDARD_CLEARANCE, FIELD_NONE)
		local altitude = GetRayHitPosition().y - pos.y
		local degrees = 0
		--angle readout for helis
		if GetProjectileParamBool(projectile_name, teamId, "sb_planes.helicopter", false) == true then
			degrees = RoundFloat(data.planes[tostring(user_control)].angle * 180/math.pi, 0) * -1
			if planes_effects[tostring(user_control)].heading_left then
				degrees = degrees + 90
			else
				degrees = degrees - 90
			end
		--angle readout for planes
		else
			degrees = RoundFloat(Vec2Rad(velocity) * 180/math.pi, 0) * -1
		end
		if degrees > 90 then
			degrees = 90 - (degrees - 90)
		elseif degrees < -90 then
			degrees = (90 + (degrees + 90)) * -1
		end
		SetControlTextW("sbplanes_bl", "speed",  STRINGS[lang].speed .. L": " .. towstring(tostring(RoundFloat(speed * 1.944 / 100, 1))) .. L" kn")
		SetControlTextW("sbplanes_bl", "altitude", STRINGS[lang].altitude .. L": " .. towstring(tostring(RoundFloat(altitude / 100, 0))) .. L" m")
		SetControlText("sbplanes_bl", "angle", tostring(degrees) .. "°")
		if keys_held[PrecisionModifier] then
			SetControlColour("sbplanes_bl", "aim", Colour(255, 255, 255, 255))
		else
			SetControlColour("sbplanes_bl", "aim", Colour(255, 255, 255, 0))
		end
		--gun names
		local firename1 = towstring(Fire1)
		local firename2 = towstring(Fire2)
		local firename3 = towstring(Fire3)
		if firename1 == L" " then firename1 = STRINGS[lang].spacebar end
		if firename2 == L" " then firename2 = STRINGS[lang].spacebar end
		if firename3 == L" " then firename3 = STRINGS[lang].spacebar end
		--gun stats 
		for i = 1, 3 do
			local istr = tostring(i)
			local gunname = GetProjectileParamString(projectile_name, teamId, "sb_planes.weapon"..istr..".name", "")
			local maxangle = GetProjectileParamFloat(projectile_name, teamId, "sb_planes.weapon"..istr..".maxangle", 198420)
			local firename = ""
			if i == 1 then firename = firename1 elseif i == 2 then firename = firename2 else firename = firename3 end
			if gunname == "" then
				SetControlText("sbplanes_br", "gun" .. istr, "")
				SetControlText("sbplanes_br", "gun" .. istr.. "name", "")
				SetControlSize("sbplanes_br", "gun" .. istr.. "aim", Vec3(0,0))
			else
				local timer = data.planes[user_control_str].timers[i]
				local timer2 = data.planes[user_control_str].timers[i + 3]
				local timer3 = data.planes[user_control_str].timers[i + 6]
				local timer_max = data.planes[user_control_str].timers_max[i]
				local timer2_max = data.planes[user_control_str].timers_max[i + 3]
				local timer3_max = data.planes[user_control_str].timers_max[i + 6]
				--ammo count string
				local ammo_count = L""
				if timer3_max < 10 then
					for i = 1, timer3 do
						ammo_count = ammo_count .. L"●"
					end
					for i = 1, timer3_max - timer3 do
						ammo_count = ammo_count .. L"○"
					end
				-- if bank count is 10 or more, dont use the circle thing
				else
					ammo_count = towstring(tostring(timer3) .. "/" .. tostring(timer3_max))
				end
				
				SetControlText("sbplanes_br", "gun"..istr.."name", gunname)
				if timer3 == timer3_max then
					SetControlTextW("sbplanes_br", "gun"..istr, ammo_count .. L" [" .. firename .. L"]")
					SetControlColour("sbplanes_br", "gun"..istr, White())
					SetControlColour("sbplanes_br", "gun"..istr.."name", White())
					SetControlColour("sbplanes_br", "gun"..istr.."aim", White())
					if not MaxVertTest(velocity, maxangle) then
						SetControlColour("sbplanes_br", "gun"..istr, Colour(85, 85, 85, 128))
						SetControlColour("sbplanes_br", "gun"..istr.."name", Colour(85, 85, 85, 128))
						SetControlColour("sbplanes_br", "gun"..istr.."aim", Colour(85, 85, 85, 128))
					end
				elseif timer == 0 then
					SetControlTextW("sbplanes_br", "gun"..istr, towstring(tostring(math.ceil(timer2))) .. L"s " .. L" " .. ammo_count .. L" [" .. firename .. L"]")
					SetControlColour("sbplanes_br", "gun"..istr, Colour(180, 220, 255, 255))
					SetControlColour("sbplanes_br", "gun"..istr.."name", Colour(180, 220, 255, 255))
					SetControlColour("sbplanes_br", "gun"..istr.."aim", Colour(180, 220, 255, 255))
					if not MaxVertTest(velocity, maxangle) then
						SetControlColour("sbplanes_br", "gun"..istr, Colour(60, 73, 85, 128))
						SetControlColour("sbplanes_br", "gun"..istr.."name", Colour(60, 73, 85, 128))
						SetControlColour("sbplanes_br", "gun"..istr.."aim", Colour(60, 73, 85, 128))
					end
				else
					SetControlTextW("sbplanes_br", "gun"..istr, towstring(tostring(math.ceil(timer))) .. L"s " .. L" " .. ammo_count .. L" [" .. firename .. L"]")
					SetControlColour("sbplanes_br", "gun"..istr, Colour(255, 64, 64, 255))
					SetControlColour("sbplanes_br", "gun"..istr.."name", Colour(255, 64, 64, 255))
					SetControlColour("sbplanes_br", "gun"..istr.."aim", Colour(255, 64, 64, 255))
					if not MaxVertTest(velocity, maxangle) then
						SetControlColour("sbplanes_br", "gun"..istr, Colour(85, 20, 20, 128))
						SetControlColour("sbplanes_br", "gun"..istr.."name", Colour(85, 20, 20, 128))
						SetControlColour("sbplanes_br", "gun"..istr.."aim", Colour(85, 20, 20, 128))
					end
				end
				
				if GetProjectileParamBool(projectile_name, teamId, "sb_planes.weapon"..istr..".aimed", false)
				or GetProjectileParamBool(projectile_name, teamId, "sb_planes.weapon"..istr..".aim_missile", false)
				then
					SetControlSize("sbplanes_br", "gun"..istr.."aim", Vec3(15,15))
				else
					SetControlSize("sbplanes_br", "gun"..istr.."aim", Vec3(0,0))
				end
			end
		end
		SetControlFrame(control_frame)
		hud_open = true
	end
end