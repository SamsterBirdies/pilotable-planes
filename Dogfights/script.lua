--include
dofile(path .. "/scripts/debugMagic.lua")
dofile("scripts/forts.lua")
dofile(path .. "/scripts/sseparams.lua")
dofile(path .. "/scripts/better_log.lua")
debugging = 0 --0 = none, 1 = performance,
DEG90 = 1.5708 --90 degrees in radians
ZOOM_MUL = 400 --camera zoom levels to cm
--init local user controls
user_control = 0 --plane projectile Id to control
user_control_available = {} --available plane projectile Id's to control
keys_held = {} --"key" = true

--init local effects
onjoin = true --used for rejoining intialization
planes_effects = {} --to keep track of effects on planes
frametime = 1/25 --used for the camera
previous_time = 0 --used for the camera
camera_zoom_target = 0 --used for smoother camera zooming
camera_zoom_min = 1
camera_zoom_max = 25
screen_max_y = 600 --max Y for hud and camera zooming
previous_game_time = 0 --used to calculate delta time
delta = 0.016 --real delta unlike the fake one given in OnUpdate(). used for effects
frametime_left = frametime --used for effect interpolation
camera_pos = Vec3(0,0,0) --used for doppler
camera_velocity = Vec3(0,0,0)
environment = "environment/canyon"
lang = "English"
hud_open = false --saves some performance by only setting up the hud once upon opening.

--init global gamestate
fps = 25 --for correct timers and other calculations if the framerate is changed
frames_per_tick = 4 --for SendScriptEvent timings.
data.planes = {} -- planeid = {timers = {0,0,0}, throttle = 1, elevator = 0, free = true, mousepos = Vec3(0,0)}
heli_effect = true --turns off heli wind effect when too many helis to save performance. fun for long burst.

--mod organization
dofile(path .. "/scripts/math.lua")
dofile(path .. "/scripts/localization.lua")
dofile(path .. "/scripts/hud.lua")
dofile(path .. "/scripts/keybinds.lua")
dofile(path .. "/scripts/controls.lua")
dofile(path .. "/scripts/effects.lua")
dofile(path .. "/scripts/plane_physics.lua")
--dofile(path .. "/scripts/perf_counter.lua")

--events
function Load()
	--timings
	fps = GetConstant("Physics.FramesRate")
	frames_per_tick = GetConstant("Physics.FramesPerTick")
	frametime = 1 / fps
	--hud init
	screen_max_y = GetMaxScreenY()
	LoadHUD()
	--max camera zoom
	camera_zoom_max = GetCameraMaxZoom()
	--localization
	GetLanguage()
	--keybind ui setup
	if GetLocalTeamId() ~= -3 then --avoid adding ui for observers
		ChangeKeybindsControlSetup()
	end
end

function OnRestart()
	--reset values
	ReleaseControl(user_control)
	hud_open = false
	planes_effects = {}
	data.planes = {}
	user_control = 0
	user_control_available = {}
	keys_held = {}
end

function Update(frame)
	
	--calculate frame time
	frametime = math.min(GetRealTime() - previous_time, 2.56) --2.56 = 0.04 * 64, slowest possible speed.
	previous_time = GetRealTime()
	
	--get camera statistics
	camera_pos = GetCameraFocus()
	camera_pos.z = GetCameraZoom() * ZOOM_MUL
	if user_control > 0 then
		camera_velocity = NodeVelocity(user_control)
	else
		camera_velocity = Vec3(0,0,0)
	end
	
	if frame == 1 then
		--display log notice
		Notice("")
		Notice("")
		Notice("")
		LogW(STRINGS[lang].controls)
		LogW(STRINGS[lang].controls2)
		--get environment
		environment = GetEnvironmentPath()
	end
	
	--hud
	UpdateHUD(frame)
	
	--update planes
	local plane_count = 0
	for k, v in pairs(data.planes) do
		plane_count = plane_count + 1
		local id = tonumber(k)
		local saveName = GetNodeProjectileSaveName(id)
		local teamId = NodeTeam(id)
		local planetimers = data.planes[k].timers
		--plane controls
		UpdateControls(frame, id, saveName, teamId)
		--update plane weapon timers
		for kk, vv in pairs(v.timers) do
			--if 1 frame from reloaded then play the reload effect
			if vv > 0 and vv <= (1/fps) then
				ReloadEffect(id, saveName, kk)
			end
			--countdown to 0. Do not ask me how this works, it just does.
			if kk < 4 
			or kk < 7 and planetimers[kk - 3] == 0 and planetimers[kk + 3] < data.planes[k].timers_max[kk + 3] 
			or kk < 7 and planetimers[kk + 3] == 0 
			then
				if vv >= (1/fps) then
					planetimers[kk] = vv - (1/fps)
				else
					planetimers[kk] = 0
				end
				if kk > 3 and kk < 7 and planetimers[kk + 3] == 0 then
					if planetimers[kk - 3] < planetimers[kk] then
						planetimers[kk - 3] = planetimers[kk]
					end
				end
			end
			--bank
			if kk < 4 and planetimers[kk] == 0 and planetimers[kk + 3] == 0 and planetimers[kk + 6] < data.planes[k].timers_max[kk + 6] then
				planetimers[kk + 6] = planetimers[kk + 6] + 1
				planetimers[kk + 3] = data.planes[k].timers_max[kk + 3]
			end
				
		end
		--plane physics
		UpdatePlanePhysics(id, saveName, teamId)
		UpdateHeliPhysics(id, saveName, teamId)
		--effect trails
		PlaneUpdateTrail(id, data.planes[tostring(id)].throttle)
	end
	--turn off heli wind effect when many planes to save performance
	if plane_count > 24 then
		heli_effect = false
	else
		heli_effect = true
	end
	PlaneUpdateSprite()
end

function OnWeaponFired(teamId, saveName, weaponId, projectileNodeId, projectileNodeIdFrom)
	if projectileNodeIdFrom == 0 and GetProjectileParamFloat(GetNodeProjectileSaveName(projectileNodeId), teamId, "sb_planes.elevator", 0) > 0 then
		local planename = GetNodeProjectileSaveName(projectileNodeId)
		--set the user control if its the first plane fired
		if GetLocalTeamId() == teamId then
			table.insert(user_control_available, projectileNodeId)
		end
		data.planes[tostring(projectileNodeId)] =
		{
			timers = {0,0,0,0,0,0,0,0,0}, --reload timer 1,2,3. bank timer 4,5,6. bank count 7,8,9.
			timers_max = {0,0,0,0,0,0,0,0,0},
			throttle = 1,
			elevator = 0,
			elevator_target = 0,
			free = true,
			mouse_pos = Vec3(0,0),
			mouse_direction = 0,
			angle = -1.5708,
		}
		local projectileNodeId_str = tostring(projectileNodeId)
		--create max table
		data.planes[projectileNodeId_str].timers_max[1] = GetProjectileParamFloat(planename, teamId, "sb_planes.weapon1.timer", 10)
		data.planes[projectileNodeId_str].timers_max[2] = GetProjectileParamFloat(planename, teamId, "sb_planes.weapon2.timer", 10)
		data.planes[projectileNodeId_str].timers_max[3] = GetProjectileParamFloat(planename, teamId, "sb_planes.weapon3.timer", 10)
		data.planes[projectileNodeId_str].timers_max[4] = GetProjectileParamFloat(planename, teamId, "sb_planes.weapon1.bank_timer", -1)
		data.planes[projectileNodeId_str].timers_max[5] = GetProjectileParamFloat(planename, teamId, "sb_planes.weapon2.bank_timer", -1)
		data.planes[projectileNodeId_str].timers_max[6] = GetProjectileParamFloat(planename, teamId, "sb_planes.weapon3.bank_timer", -1)
		if data.planes[projectileNodeId_str].timers_max[4] == -1 then data.planes[projectileNodeId_str].timers_max[4] = data.planes[projectileNodeId_str].timers_max[1] end
		if data.planes[projectileNodeId_str].timers_max[5] == -1 then data.planes[projectileNodeId_str].timers_max[5] = data.planes[projectileNodeId_str].timers_max[2] end
		if data.planes[projectileNodeId_str].timers_max[6] == -1 then data.planes[projectileNodeId_str].timers_max[6] = data.planes[projectileNodeId_str].timers_max[3] end
		data.planes[projectileNodeId_str].timers_max[7] = GetProjectileParamFloat(planename, teamId, "sb_planes.weapon1.bank_max", 1)
		data.planes[projectileNodeId_str].timers_max[8] = GetProjectileParamFloat(planename, teamId, "sb_planes.weapon2.bank_max", 1)
		data.planes[projectileNodeId_str].timers_max[9] = GetProjectileParamFloat(planename, teamId, "sb_planes.weapon3.bank_max", 1)
		--set initial timers
		data.planes[projectileNodeId_str].timers[4] = data.planes[projectileNodeId_str].timers_max[4]
		data.planes[projectileNodeId_str].timers[5] = data.planes[projectileNodeId_str].timers_max[5]
		data.planes[projectileNodeId_str].timers[6] = data.planes[projectileNodeId_str].timers_max[6]
		data.planes[projectileNodeId_str].timers[7] = GetProjectileParamFloat(planename, teamId, "sb_planes.weapon1.bank_start", 1)
		data.planes[projectileNodeId_str].timers[8] = GetProjectileParamFloat(planename, teamId, "sb_planes.weapon2.bank_start", 1)
		data.planes[projectileNodeId_str].timers[9] = GetProjectileParamFloat(planename, teamId, "sb_planes.weapon3.bank_start", 1)
		--etc init
		planes_effects[tostring(projectileNodeId)] = {}
		PlaneAddEffects(projectileNodeId)
		HoverHeli(projectileNodeId)
	end
	if saveName == "HardPointSubFlak" then
		SetNodeProjectileAgeTrigger(projectileNodeId, GetNormalFloat(0.1, 0.22,"HPF Age Offset"))--GetRandomFloat(0.18,0.32,"HPF Age Offset"))
	end
end

function OnProjectileDestroyed(nodeId, teamId, saveName, structureIdHit, destroyType)
	--release user control
	if nodeId == user_control then
		ReleaseControl(nodeId)
	end
	--remove controllable planes
	for k, v in pairs(user_control_available) do
		if v == nodeId then
			table.remove(user_control_available, k)
			break
		end
	end
	--remove plane data
	data.planes[tostring(nodeId)] = nil
	if planes_effects[tostring(nodeId)] then
		PlaneRemoveEffects(nodeId)
	end
end

function OnKey(key, down)
	OnKeyControls(key, down)
	OnKeyKeybinds(key, down)
end
function OnControlActivated(name)
	KeybindsOnControlActivated(name)
end

function OnUpdate(fake_delta)
	--gather time stats
	delta = fake_delta - previous_game_time
	previous_game_time = fake_delta
	frametime_left = frametime_left - delta
	
	--trail effect initialization
	if onjoin then
		EffectsSync()
		if GetLocalTeamId() ~= -3 then
			ScheduleCall(1, ChangeKeybindsControlSetup)
		end
		onjoin = false
	end
	
	--update sprite interpolation
	PlaneOnUpdateSprite()
end

function OnSeek()
	EffectsSync()
end

function OnInstantReplay()
	EffectsSync()
end

function OnTerrainHit(terrainId, damage, projectileNodeId, projectileSaveName, surfaceType, pos, normal, reflectedByEnemy)
	--used for helicopter dust effect
	EffectsHeliDust(projectileNodeId, projectileSaveName, pos, normal, surfaceType)
end
function OnLinkHit(nodeIdA, nodeIdB, objectId, objectTeamId, objectSaveName, damage, pos, reflectedByEnemy)
	EffectsHeliDust(objectId, objectSaveName, pos, Vec3(0,-1), 42069)
end

dofile(path .. "/scripts/debugMagic.lua")

--[[
LocalPortalFatigueIterator = 0
LocalPortalFatigueOverHeat = 0
function OnPortalUsed(nodeA, nodeB, nodeADest, nodeBDest, objectTeamId, objectId, isBeam)
   if objectId == user_control then
      AddSpriteControl("sbplanes", "PortalFatigue"..LocalPortalFatigueIterator, path.."/effects/media/Portal.png", 0,
      Vec3(GetRandomIntegerLocal(1200, 1500),GetRandomIntegerLocal(750, 1300)), --size
      Vec3(GetRandomIntegerLocal(-200, -10),GetRandomIntegerLocal(-200, -10)), --pos
      false)
      ScheduleCall(6,RemovePortalFatigue,LocalPortalFatigueIterator)
      LocalPortalFatigueIterator = LocalPortalFatigueIterator + 1
      LocalPortalFatigueOverHeat = LocalPortalFatigueOverHeat + 1
      if LocalPortalFatigueOverHeat > GetRandomIntegerLocal(6,18) then
         LocalPortalFatigueOverHeat = 0
         ScheduleCall(12+GetNormalFloatLocal(LocalPortalFatigueIterator*0.03, LocalPortalFatigueIterator*0.1),RemovePortalFatigue,LocalPortalFatigueIterator)
         if GetRandomIntegerLocal(1,8) == 8 then StartStream(path.."/effects/media/ear-ringing-sound-effect-26746.mp3",0.03+math.min(0.5,LocalPortalFatigueIterator*0.001)) end
         StartStream(path.."/effects/media/vomit-150122.mp3",0.05+math.min(0.15,LocalPortalFatigueIterator*0.002))
      end
   end
end

function RemovePortalFatigue(itr)
   DeleteControl("sbplanes", "PortalFatigue"..itr)
   LocalPortalFatigueOverHeat = LocalPortalFatigueOverHeat - 0.2
end
]]