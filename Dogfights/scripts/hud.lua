function ReleaseControl(id)
	--stop controlling plane
	user_control = 0
	SendScriptEvent("SetPlaneFree", SSEParams(id, true), "script.lua", true)
	LockControls(false)
	EnableCameraControls(true)
	ShowHUD(true, true)
	SetControlText("sbplanes_bl", "speed", "")
	SetControlText("sbplanes_bl", "altitude", "")
	SetControlText("sbplanes_bl", "angle", "")
	SetControlColour("sbplanes_bl", "aim", Colour(255, 255, 255, 0))
	SetControlText("sbplanes_br", "gun1", "")
	SetControlText("sbplanes_br", "gun2", "")
	SetControlText("sbplanes_br", "gun3", "")
	SetControlSpriteByParent("SB_PP_Root", "SB_PP_Pin", "ui/textures/Edit-A.png")
end

function LoadHUD()
	local spacing = 20
	AddTextControl("", "sbplanes_bl", "", ANCHOR_BOTTOM_LEFT, Vec3(10,590), false, "Normal")
	AddTextControl("sbplanes_bl", "speed", "", ANCHOR_BOTTOM_LEFT, Vec3(0, -0 * spacing), false, "Normal")
	AddTextControl("sbplanes_bl", "altitude", "", ANCHOR_BOTTOM_LEFT, Vec3(0, -1 * spacing), false, "Normal")
	AddTextControl("sbplanes_bl", "angle", "", ANCHOR_BOTTOM_LEFT, Vec3(0, -2 * spacing), false, "Normal")
	AddSpriteControl("sbplanes_bl", "aim", path .. "/effects/media/aim_icon.dds", ANCHOR_BOTTOM_LEFT, Vec3(16,16), Vec3(35, -2 * spacing + 1.8), false)
	SetControlColour("sbplanes_bl", "aim", Colour(255, 255, 255, 0))
	
	AddTextControl("", "sbplanes_br", "", ANCHOR_BOTTOM_RIGHT, Vec3(1050,590), false, "Normal")
	AddTextControl("sbplanes_br", "gun1", "", ANCHOR_BOTTOM_RIGHT, Vec3(0, -2 * spacing), false, "Normal")
	AddTextControl("sbplanes_br", "gun2", "", ANCHOR_BOTTOM_RIGHT, Vec3(0, -1 * spacing), false, "Normal")
	AddTextControl("sbplanes_br", "gun3", "", ANCHOR_BOTTOM_RIGHT, Vec3(0, -0 * spacing), false, "Normal")
end

function UpdateHUD(frame)
	if user_control > 0 then
		--remove hud
		LockControls(true)
		EnableCameraControls(false)
		ShowHUD(false, true)
		if KeybindsDisplayUp then
			ShowControl("SB_PP_Root", "SB_PP_Box", false)
			KeybindsDisplayUp = false
		end
		SetControlSpriteByParent("SB_PP_Root", "SB_PP_Pin", path .. "/blank.png")
		--camera follow
		CancelCameraMove()
		SetNamedScreenByZoom("pilot", NodePosition(user_control), camera_zoom_target)
		RestoreScreen("pilot", frametime + 0.04, 0, true)
		--flight stats
		local velocity = NodeVelocity(user_control)
		local speed = math.sqrt(velocity.x ^ 2 + velocity.y ^ 2)
		local pos = NodePosition(user_control)
		CastRay(pos, AddVec(pos, Vec3(0,999900)), RAY_STANDARD_CLEARANCE, FIELD_NONE)
		local altitude = GetRayHitPosition().y - pos.y
		local degrees = 0
		--angle readout for helis
		if GetProjectileParamBool(GetNodeProjectileSaveName(user_control), GetLocalTeamId(), "sb_planes.helicopter", false) == true then
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
		local gun1name = GetProjectileParamString(GetNodeProjectileSaveName(user_control), NodeTeam(user_control), "sb_planes.weapon1.name", "")
		local gun2name = GetProjectileParamString(GetNodeProjectileSaveName(user_control), NodeTeam(user_control), "sb_planes.weapon2.name", "")
		local gun3name = GetProjectileParamString(GetNodeProjectileSaveName(user_control), NodeTeam(user_control), "sb_planes.weapon3.name", "")
		--gun stats 1
		if gun1name == "" then
			SetControlText("sbplanes_br", "gun1", "")
		else
			local timer = data.planes[tostring(user_control)].timers[1]
			if timer < 0.04 then
				if Fire1 == " " then
					SetControlTextW("sbplanes_br", "gun1", towstring(gun1name) .. L"[".. STRINGS[lang].spacebar .. L"]")
				else
					SetControlText("sbplanes_br", "gun1", gun1name .. "[" .. Fire1 .. "]")
				end
				SetControlColour("sbplanes_br", "gun1", White())
			else
				SetControlText("sbplanes_br", "gun1", gun1name .. " " .. tostring(math.ceil(timer)) .. "s")
				SetControlColour("sbplanes_br", "gun1", Colour(255, 64, 64, 255))
			end
		end
		--gun stats 2
		if gun2name == "" then
			SetControlText("sbplanes_br", "gun2", "")
		else
			local timer = data.planes[tostring(user_control)].timers[2]
			if timer < 0.04 then
				SetControlText("sbplanes_br", "gun2", gun2name .. "[" .. Fire2 .. "]")
				SetControlColour("sbplanes_br", "gun2", White())
			else
				SetControlText("sbplanes_br", "gun2", gun2name .. " " .. tostring(math.ceil(timer)) .. "s")
				SetControlColour("sbplanes_br", "gun2", Colour(255, 64, 64, 255))
			end
		end
		--gun stats 3
		if gun3name == "" then
			SetControlText("sbplanes_br", "gun3", "")
		else
			local timer = data.planes[tostring(user_control)].timers[3]
			if timer < 0.04 then
				SetControlText("sbplanes_br", "gun3", gun3name .. "[" .. Fire3 .. "]")
				SetControlColour("sbplanes_br", "gun3", White())
			else
				SetControlText("sbplanes_br", "gun3", gun3name .. " " .. tostring(math.ceil(timer)) .. "s")
				SetControlColour("sbplanes_br", "gun3", Colour(255, 64, 64, 255))
			end
		end
	end
end