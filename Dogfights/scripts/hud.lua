function ReleaseControl(id)
	--stop controlling plane
	user_control = 0
	SendScriptEvent("SetPlaneFree", SSEParams(id, true), "script.lua", true)
	LockControls(false)
	EnableCameraControls(true)
	ShowHUD(true, true)
	SetControlText("sbplanes", "speed", "")
	SetControlText("sbplanes", "altitude", "")
	SetControlText("sbplanes", "angle", "")
	SetControlText("sbplanes", "gun1", "")
	SetControlText("sbplanes", "gun2", "")
	SetControlText("sbplanes", "gun3", "")
	SetControlSpriteByParent("SB_PP_Root", "SB_PP_Pin", "ui/textures/Edit-A.png")
end

function LoadHUD()
	AddTextControl("", "sbplanes", "", ANCHOR_BOTTOM_LEFT, Vec3(0,0), false, "Normal")
	AddTextControl("sbplanes", "speed", "", ANCHOR_BOTTOM_LEFT, Vec3(10, 590), false, "Normal")
	AddTextControl("sbplanes", "altitude", "", ANCHOR_BOTTOM_LEFT, Vec3(10, 570), false, "Normal")
	AddTextControl("sbplanes", "angle", "", ANCHOR_BOTTOM_LEFT, Vec3(10, 550), false, "Normal")
	AddTextControl("sbplanes", "gun1", "", ANCHOR_BOTTOM_RIGHT, Vec3(1050, 550), false, "Normal")
	AddTextControl("sbplanes", "gun2", "", ANCHOR_BOTTOM_RIGHT, Vec3(1050, 570), false, "Normal")
	AddTextControl("sbplanes", "gun3", "", ANCHOR_BOTTOM_RIGHT, Vec3(1050, 590), false, "Normal")
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
		SetNamedScreenByZoom("pilot", NodePosition(user_control), GetCameraZoom())
		RestoreScreen("pilot", frametime + 0.04, 0, true)
		--flight stats
		local velocity = NodeVelocity(user_control)
		local speed = math.sqrt(velocity.x ^ 2 + velocity.y ^ 2)
		local pos = NodePosition(user_control)
		CastRay(pos, AddVec(pos, Vec3(0,999900)), RAY_STANDARD_CLEARANCE, FIELD_NONE)
		local altitude = GetRayHitPosition().y - pos.y
		local degrees = RoundFloat(Vec2Rad(velocity) * 180/math.pi, 0) * -1
		if degrees > 90 then
			degrees = 90 - (degrees - 90)
		elseif degrees < -90 then
			degrees = (90 + (degrees + 90)) * -1
		end
		SetControlText("sbplanes", "speed", "Speed: " .. tostring(RoundFloat(speed * 1.944 / 100, 1)) .. " kn")
		SetControlText("sbplanes", "altitude", "Altitude: " .. tostring(RoundFloat(altitude / 100, 0)) .. " m")
		SetControlText("sbplanes", "angle", tostring(degrees) .. "°")
		--gun names
		local gun1name = GetProjectileParamString(GetNodeProjectileSaveName(user_control), NodeTeam(user_control), "sb_planes.weapon1.name", "")
		local gun2name = GetProjectileParamString(GetNodeProjectileSaveName(user_control), NodeTeam(user_control), "sb_planes.weapon2.name", "")
		local gun3name = GetProjectileParamString(GetNodeProjectileSaveName(user_control), NodeTeam(user_control), "sb_planes.weapon3.name", "")
		--gun stats 1
		if gun1name == "" then
			SetControlText("sbplanes", "gun1", "")
		else
			local timer = data.planes[tostring(user_control)].timers[1]
			if timer < 0.04 then
				if Fire1 == " " then
					SetControlText("sbplanes", "gun1", gun1name .. "[space]")
				else
					SetControlText("sbplanes", "gun1", gun1name .. "[" .. Fire1 .. "]")
				end
				SetControlColour("sbplanes", "gun1", White())
			else
				SetControlText("sbplanes", "gun1", gun1name .. " " .. tostring(math.ceil(timer)) .. "s")
				SetControlColour("sbplanes", "gun1", Red())
			end
		end
		--gun stats 2
		if gun2name == "" then
			SetControlText("sbplanes", "gun2", "")
		else
			local timer = data.planes[tostring(user_control)].timers[2]
			if timer < 0.04 then
				SetControlText("sbplanes", "gun2", gun2name .. "[" .. Fire2 .. "]")
				SetControlColour("sbplanes", "gun2", White())
			else
				SetControlText("sbplanes", "gun2", gun2name .. " " .. tostring(math.ceil(timer)) .. "s")
				SetControlColour("sbplanes", "gun2", Red())
			end
		end
		--gun stats 3
		if gun3name == "" then
			SetControlText("sbplanes", "gun3", "")
		else
			local timer = data.planes[tostring(user_control)].timers[3]
			if timer < 0.04 then
				SetControlText("sbplanes", "gun3", gun3name .. "[" .. Fire3 .. "]")
				SetControlColour("sbplanes", "gun3", White())
			else
				SetControlText("sbplanes", "gun3", gun3name .. " " .. tostring(math.ceil(timer)) .. "s")
				SetControlColour("sbplanes", "gun3", Red())
			end
		end	
	end
end