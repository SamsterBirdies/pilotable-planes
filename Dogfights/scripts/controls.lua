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
		data.planes[tostring(id)].mouse_direction = value.x - NodePosition(id).x
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
		--perform angle compensation for plane velocity
		angle = Trig_C_abB(Vec2Mag(velocity), speed, angle - plane_angle)
		if angle < 100 and angle > -100 then
			angle = (math.pi - angle) + plane_angle
		else --if angle compensation is impossible, fallback to inputted angle 
			angle = RadVec2Vec(position, mouse_pos)
		end
	elseif helicopter then
		if data.planes[tostring(id)].mouse_direction < 0 then
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

function HoverHeli(id)
	--make heli stationary or maintain elevation when uncontrolled.
	--check if craft exists and if its a helicopter
	if data.planes[tostring(id)] and GetProjectileParamBool(GetNodeProjectileSaveName(id), NodeTeam(id), "sb_planes.helicopter", false) then
		--turn off elevator sticking
		ElevatorsTarget(id, 0)
		Elevators(id, 0)
		--snap angle to 0 if under 10 degrees
		if data.planes[tostring(id)].angle < -DEG90 + 0.174 and data.planes[tostring(id)].angle > -DEG90 - 0.174 then
			data.planes[tostring(id)].angle = -DEG90
		end
		--calculate nessecary throttle to maintain elevation
		local savename = GetNodeProjectileSaveName(id)
		local teamId = NodeTeam(id)
		local mass = GetProjectileParamFloat(savename, teamId, "ProjectileMass", 1)
		local thrust = GetProjectileParamFloat(savename, teamId, "sb_planes.thrust", 1)
		local throttle_max = GetProjectileParamFloat(savename, teamId, "sb_planes.throttle_max", 1)
		local throttle_min = GetProjectileParamFloat(savename, teamId, "sb_planes.throttle_min", 1)
		--1: F = mg. 2: F/thrust = throttle. 3: throttle / sin(90 - angle) = throttle for hypotenuse. 
		--(latter half of step 3 comes first to avoid division by zero)
		local C_angle = math.sin(DEG90 - (data.planes[tostring(id)].angle + DEG90))
		if C_angle <= 0 then 
			C_angle = 0.001 
		end
		--keep throttle within min and max limit
		local new_throttle = (mass * 981 / thrust) / C_angle
		if new_throttle > throttle_max then 
			new_throttle = throttle_max
		elseif new_throttle < throttle_min then
			new_throttle = throttle_min
		end
		data.planes[tostring(id)].throttle = new_throttle
	end
end
function ControlPlane(id)
	if data.planes[tostring(id)].free then
		SendScriptEvent("SetPlaneFree", SSEParams(user_control, true), "script.lua", true)
		user_control = id
		SendScriptEvent("SetPlaneFree", SSEParams(user_control, false), "script.lua", true)
		return true
	else
		return false
	end
end

function PlaneWeapon(id, weapon, saveName, teamId)
	if data.planes[tostring(id)].timers[weapon] == 0 then
		local timer = GetProjectileParamFloat(saveName, teamId, "sb_planes.weapon"..tostring(weapon)..".timer", 10)
		local fireCost = GetProjectileParamFloat(saveName, teamId, "sb_planes.weapon"..tostring(weapon)..".fire_cost_metal", 0)
		local fireCostE = GetProjectileParamFloat(saveName, teamId, "sb_planes.weapon"..tostring(weapon)..".fire_cost_energy", 150)
		SendScriptEvent("AddResources",SSEParams(teamId, Value(fireCost*-1,fireCostE*-1), false, Vec3()), "script.lua", true)
		SendScriptEvent("DropBombsSchedule", SSEParams(id, weapon, GetProjectileClientId(id), timer), "script.lua", true)
		data.planes[tostring(id)].timers[weapon] = timer
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
		SendScriptEvent("HoverHeli", SSEParams(user_control), "script.lua", true)
		ReleaseControl(user_control)
	end
	for i = 0, 9 do
		if key == tostring(i) then
			SendScriptEvent("HoverHeli", SSEParams(user_control), "script.lua", true)
			ReleaseControl(user_control)
			break
		end
	end
	
	--cycle plane control
	if key == SelectNext and down then
		if #user_control_available < 1 then return end
		local index = 0
		if user_control == 0 then
			index = 1
		else
			for k, v in pairs(user_control_available) do
				--find controlled plane.
				if v == user_control then
					index = k
					break
				end
			end
		end			--8 planes can be in use, cycle planes until a free plane is found
		for i = 1, 10 do
			if index > #user_control_available then
				index = 1
			end
			if data.planes[tostring(user_control_available[index])].free then
				camera_zoom_target = GetCameraZoom()
				SendScriptEvent("HoverHeli", SSEParams(user_control), "script.lua", true)
				SendScriptEvent("SetPlaneFree", SSEParams(user_control, true), "script.lua", true)
				user_control = user_control_available[index]
				SendScriptEvent("SetPlaneFree", SSEParams(user_control, false), "script.lua", true)
				break
			end
			index = index + 1
		end
	elseif key == SelectPrev and down then
		if #user_control_available < 1 then return end
		local index = 0
		if user_control == 0 then
			index = #user_control_available
		else
			for k, v in pairs(user_control_available) do
				--find controlled plane.
				if v == user_control then
					index = k
					break
				end
			end
		end
		for i = 1, 10 do
			if index < 1 then
				index = #user_control_available
			end
			if data.planes[tostring(user_control_available[index])].free then
				camera_zoom_target = GetCameraZoom()
				SendScriptEvent("HoverHeli", SSEParams(user_control), "script.lua", true)
				SendScriptEvent("SetPlaneFree", SSEParams(user_control, true), "script.lua", true)
				user_control = user_control_available[index]
				SendScriptEvent("SetPlaneFree", SSEParams(user_control, false), "script.lua", true)
				break
			end
			index = index - 1
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
					camera_zoom_target = GetCameraZoom()
					SendScriptEvent("SetPlaneFree", SSEParams(user_control, true), "script.lua", true)
					user_control = v
					SendScriptEvent("SetPlaneFree", SSEParams(user_control, false), "script.lua", true)
				else --show user if plane is already occupied
					Notice("")
					LogW(L"[HL=FFFF40FF]" .. STRINGS[lang].plane_occupied .. L"[/HL]")
					SpawnEffect("effects/weapon_blocked", planepos)
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
				camera_zoom_target = camera_zoom_target + 1
				if camera_zoom_target > camera_zoom_max then 
					camera_zoom_target = camera_zoom_max 
				end
			else
				camera_zoom_target = camera_zoom_target - 1
				if camera_zoom_target < camera_zoom_min then 
					camera_zoom_target = camera_zoom_min 
				end
			end
		end
		--suggestion to allow commander activation
		if key == CommanderAbility and down then
			SendScriptEvent("ActivateCommander", SSEParams(GetLocalTeamId()), "script.lua", true)
		end
	end

end

function UpdateControls(frame, id, saveName, teamId)
	if tostring(user_control) == tostring(id) then
		--elevators
		local elevator_target = 0
		if keys_held["right"] or keys_held[ElevatorUp] then
			if keys_held[PrecisionModifier] then
				elevator_target = 0.3
			else
				elevator_target = 1
			end
		end
		if keys_held["left"] or keys_held[ElevatorDown] then
			if keys_held[PrecisionModifier] then
				elevator_target = -0.3
			else
				elevator_target = -1
			end
		end
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
		--get mouse pos
		local mouse_pos = ScreenToWorld(GetMousePos())
		SendScriptEvent("ScriptEventControls", SSEParams(user_control, elevator_target, throttle, mouse_pos), "script.lua", true)
		
		--weapons
		--gun
		if keys_held[Fire1] then
			PlaneWeapon(id, 1, saveName, teamId)
		end
		--bombs
		if keys_held[Fire2] then
			PlaneWeapon(id, 2, saveName, teamId)
		end
		--misc
		if keys_held[Fire3] then
			PlaneWeapon(id, 3, saveName, teamId)
		end
	end
end