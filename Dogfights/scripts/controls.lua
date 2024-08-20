function Elevators(id, value)
	if data.planes[tostring(id)] then
		data.planes[tostring(id)].elevator = value
	end
end

function ElevatorsTarget(id, value)
	if data.planes[tostring(id)] then
		data.planes[tostring(id)].elevator_target = value
	end
end

function Throttles(id, value)
	if data.planes[tostring(id)] then
		data.planes[tostring(id)].throttle = value
	end
end
function SetPlaneMouseTarget(id, value)
	if data.planes[tostring(id)] then
		data.planes[tostring(id)].mouse_pos = value
	end
end
function ScriptEventControls(id, value0, value1, value2)
	ElevatorsTarget(id, value0)
	Throttles(id, value1)
	SetPlaneMouseTarget(id, value2)
end

function DropBombsSchedule(id, weapon, clientId, timer)
	if not NodeExists(id) then return end
	
	local saveName = GetNodeProjectileSaveName(id)
	local teamId = NodeTeam(id)
	local count = GetProjectileParamFloat(saveName, teamId, "sb_planes.weapon" .. tostring(weapon) .. ".count", 0)
	local period = GetProjectileParamFloat(saveName, teamId, "sb_planes.weapon" .. tostring(weapon) .. ".period", 0.06)
	local perround = GetProjectileParamFloat(saveName, teamId, "sb_planes.weapon" .. tostring(weapon) .. ".perround", 1)
	for i = 0, count - 1 do
		if i == 0 then
			for ii = 0, perround - 1 do
				DropBombs({id, weapon, clientId, ii})
			end
		else
			for ii = 0, perround - 1 do
				ScheduleCall(i * period, DropBombs, {id, weapon, clientId, ii})
			end
		end
	end
	data.planes[tostring(id)].timers[weapon] = timer
end
function SetPlaneFree(id, bool)
	if type(data.planes[tostring(id)]) == "table" then
		data.planes[tostring(id)].free = bool
	end
end

function DropBombs(param)
	local id = param[1]
	if not NodeExists(id) then return end
	local weapon = param[2]
	local clientId = param[3]
	local playeffect = param[4]
	local teamId = NodeTeam(id)
	local saveName = GetNodeProjectileSaveName(id)
	local position = NodePosition(id)
	local velocity = NodeVelocity(id)
	local effect = GetProjectileParamString(saveName, teamId, "sb_planes.weapon" .. tostring(weapon) .. ".effect", "mods/dlc2/effects/bomb_release.lua")
	local rotation = GetProjectileParamFloat(saveName, teamId, "sb_planes.weapon" .. tostring(weapon) .. ".rotation", 1.5708)
	local stddev = GetProjectileParamFloat(saveName, teamId, "sb_planes.weapon" .. tostring(weapon) .. ".stddev", 0)
	local projectile = GetProjectileParamString(saveName, teamId, "sb_planes.weapon" .. tostring(weapon) .. ".projectile", "")
	local speed = GetProjectileParamFloat(saveName, teamId, "sb_planes.weapon" .. tostring(weapon) .. ".speed", 300)
	local distance = GetProjectileParamFloat(saveName, teamId, "sb_planes.weapon" .. tostring(weapon) .. ".distance", 300)
	local aimed = GetProjectileParamBool(saveName, teamId, "sb_planes.weapon" .. tostring(weapon) .. ".aimed", false)
	local helicopter = GetProjectileParamBool(saveName, teamId, "sb_planes.helicopter", false)
	local aim_missile = GetProjectileParamBool(saveName, teamId, "sb_planes.weapon" .. tostring(weapon) .. ".aim_missile", false)
	--local min_aim = GetProjectileParamFloat(saveName, teamId, "sb_planes.weapon" .. tostring(weapon) .. ".min_aim", 3.14)
	--local max_aim = GetProjectileParamFloat(saveName, teamId, "sb_planes.weapon" .. tostring(weapon) .. ".max_aim", -3.14)
	--if aimed then get the mouse pos angle
	local angle
	if aimed then
		local mouse_pos = data.planes[tostring(id)].mouse_pos
		local plane_angle = Vec2Rad(velocity)
		angle = RadVec2Vec(position, mouse_pos)
		--limit angles (too confusing ill do it some other time)
		--[[
		Log(tostring(plane_angle))
		Log(tostring(angle))
		if plane_angle < -1.5708 then
			angle = angle - math.pi
		end
		angle = math.min(min_aim + plane_angle, angle)
		angle = math.max(max_aim + plane_angle, angle)
		if plane_angle < -1.5708 then
			angle = angle + math.pi
		end]]
	elseif helicopter then
		if position.x > data.planes[tostring(id)].mouse_pos.x then
			angle = data.planes[tostring(id)].angle - DEG90 - rotation
		else
			angle = data.planes[tostring(id)].angle + DEG90 + rotation
		end
	else
		--get angle
		angle = Vec2Rad(velocity)
		--flip direction facing left weapon rotation
		if angle > 1.5708 or angle < -1.5708 then
			angle = angle - rotation 
		else
			angle = angle + rotation
		end
	end
	
	angle = GetNormalFloat(stddev, angle, "bombs") --stddev
	--get spawn pos
	local bombpos = AddVec(position, MultiplyVec(Rad2Vec(angle), distance))
	--spawn
	if playeffect == 0 then
		local effect_id = SpawnEffectEx(effect, bombpos, Rad2Vec(angle))
		ScheduleCall(0, SetAudioParameter, effect_id, "doppler_shift", DopplerCalculate(position, velocity))
	end
	local projectile_id = dlc2_CreateProjectile(projectile, saveName, NodeTeam(id), bombpos, AddVec(velocity, MultiplyVec(Rad2Vec(angle), speed)), 60)
	SetProjectileClientId(projectile_id, clientId)
	if aim_missile then
		SetMissileTarget(projectile_id, data.planes[tostring(id)].mouse_pos)
	else
		local target = AddVec(bombpos, MultiplyVec(Rad2Vec(angle), 900000))
		SetMissileTarget(projectile_id, target)
	end
end

function OnKeyControls(key, down)
	--record held keys
	if down then
		keys_held[key] = true
	else
		keys_held[key] = nil
	end
	
	--stop controlling plane
	if key == "backspace" or key == "esc" or key == "mouse right" then
		ReleaseControl(user_control)
	end
	for i = 0, 9 do
		if key == tostring(i) then
			ReleaseControl(user_control)
			break
		end
	end
	
	--cycle plane control
	if key == SelectNext and down then
		if user_control == 0 then
			if #user_control_available > 0 then
				user_control = user_control_available[1]
			end
		else
			for k, v in pairs(user_control_available) do
				--find controlled plane.
				if v == user_control then
					local index = k
					--8 planes can be in use, cycle planes until a free plane is found
					for i = 1, 10 do
						index = k + 1
						if index > #user_control_available then
							index = 1
						end
						if data.planes[tostring(user_control_available[index])].free then
							SendScriptEvent("SetPlaneFree", SSEParams(user_control, true), "script.lua", true)
							user_control = user_control_available[index]
							SendScriptEvent("SetPlaneFree", SSEParams(user_control, false), "script.lua", true)
							break
						end
					end
					break
				end
			end
		end
	elseif key == SelectPrev and down then
		if user_control == 0 then
			if #user_control_available > 0 then
				user_control = user_control_available[1]
			end
		else
			for k, v in pairs(user_control_available) do
				if v == user_control then
					local index = k
					for i = 1, 10 do
						index = k - 1
						if index < 1 then
							index = #user_control_available
						end
						if data.planes[tostring(user_control_available[index])].free then
							SendScriptEvent("SetPlaneFree", SSEParams(user_control, true), "script.lua", true)
							user_control = user_control_available[index]
							SendScriptEvent("SetPlaneFree", SSEParams(user_control, false), "script.lua", true)
							break
						end
					end
					break
				end
			end
		end
	end
	
	--click plane to select
	if key == "mouse left" and down then
		--todo: check if cursor is in the radius of available planes
		local mousepos = ScreenToWorld(GetMousePos())
		for k, v in pairs(user_control_available) do
			local planepos = NodePosition(v)
			if math.abs(planepos.x - mousepos.x) < 200 and math.abs(planepos.y - mousepos.y) < 200 then
				--if the plane is available then control it.
				if data.planes[tostring(v)].free then
					SendScriptEvent("SetPlaneFree", SSEParams(user_control, true), "script.lua", true)
					user_control = v
					SendScriptEvent("SetPlaneFree", SSEParams(user_control, false), "script.lua", true)
				else
					Notice("")
					LogW(STRINGS[lang].plane_occupied)
				end
				break
			end
		end
	end
	
	--plane controls
	if user_control > 0 then
		--zoom scrolling
		if key == "mouse wheel" then
			if down then
				CancelCameraMove()
				SetNamedScreenByZoom("pilot", GetCameraFocus(), GetCameraZoom() + 1)
				RestoreScreen("pilot", 0, 0, true)
			else	
				CancelCameraMove()
				SetNamedScreenByZoom("pilot", GetCameraFocus(), GetCameraZoom() - 1)
				RestoreScreen("pilot", 0, 0, true)
			end
		end
	end
end

function UpdateControls(frame, id, saveName, teamId)
	if tostring(user_control) == tostring(id) then
		--elevators
		local elevator_target = 0
		if keys_held["right"] or keys_held[ElevatorUp] then
			elevator_target = 1
		end
		if keys_held["left"] or keys_held[ElevatorDown] then
			elevator_target = -1
		end
		--SendScriptEvent("ElevatorsTarget", SSEParams(user_control, elevator_target), "script.lua", true)
		--throttle
		local throttle = 1
		local throttle_min = GetProjectileParamFloat(saveName, teamId, "sb_planes.throttle_min", 0.5)
		local throttle_max = GetProjectileParamFloat(saveName, teamId, "sb_planes.throttle_max", 1.5)
		if keys_held["down"] or keys_held[ThrottleDown] then
			throttle = throttle_min
		end
		if keys_held["up"] or keys_held[ThrottleUp] then
			throttle = throttle_max
		end
		--SendScriptEvent("Throttles", SSEParams(user_control, throttle), "script.lua", true)
		--get mouse pos
		local mouse_pos = ScreenToWorld(GetMousePos())
		--SendScriptEvent("SetPlaneMouseTarget", SSEParams(user_control, mouse_pos), "script.lua", true)
		SendScriptEvent("ScriptEventControls", SSEParams(user_control, elevator_target, throttle, mouse_pos), "script.lua", true)
		
		--weapons
		--bombs
		if keys_held[Fire2] then
			if data.planes[tostring(user_control)].timers[2] == 0 then
				local timer = GetProjectileParamFloat(saveName, teamId, "sb_planes.weapon2.timer", 15)
				SendScriptEvent("DropBombsSchedule", SSEParams(id, 2, GetProjectileClientId(id), timer), "script.lua", true)
				data.planes[tostring(user_control)].timers[2] = timer
			end
		end
		--gun
		if keys_held[Fire1] then
			if data.planes[tostring(user_control)].timers[1] == 0 then
				local timer = GetProjectileParamFloat(saveName, teamId, "sb_planes.weapon1.timer", 1)
				SendScriptEvent("DropBombsSchedule", SSEParams(id, 1, GetProjectileClientId(id), timer), "script.lua", true)
				data.planes[tostring(user_control)].timers[1] = timer
			end
		end
		--misc
		if keys_held[Fire3] then
			if data.planes[tostring(user_control)].timers[3] == 0 then
				local timer = GetProjectileParamFloat(saveName, teamId, "sb_planes.weapon3.timer", 1)
				SendScriptEvent("DropBombsSchedule", SSEParams(id, 3, GetProjectileClientId(id), timer), "script.lua", true)
				data.planes[tostring(user_control)].timers[3] = timer
			end
		end
	end
end