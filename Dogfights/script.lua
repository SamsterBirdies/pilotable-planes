--include
dofile(path .. "/scripts/debugMagic.lua")
dofile("scripts/forts.lua")
dofile(path .. "/scripts/sseparams.lua")
dofile(path .. "/scripts/better_log.lua")
debugging = 0 --0 = none, 1 = performance,
DEG90 = 1.5708 --90 degrees in radians
--init local user controls
user_control = 0 --plane projectile Id to control
user_control_available = {} --available plane projectile Id's to control
keys_held = {} --"key" = true

--init local effects
onjoin = true --used for rejoining intialization
--planes_trails = {} --to display trails, deprecated
planes_effects = {} --to keep track of effects on planes
frametime = 1/25 --used for the camera
previous_time = 0 --used for the camera
previous_game_time = 0 --used to calculate delta time
delta = 0.016 --real delta unlike the fake one given in OnUpdate(). used for effects
frametime_left = frametime --used for effect interpolation
environment = "environment/canyon"
lang = "English"
--init global gamestate
fps = 25 --for correct timers and other calculations if the framerate is changed
data.planes = {} -- planeid = {timers = {0,0,0}, throttle = 1, elevator = 0, free = true, mousepos = Vec3(0,0)}

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
	fps = GetConstant("Physics.FramesRate")
	frametime = 1 / fps
	LoadHUD()
	ChangeKeybindsControlSetup()
	GetLanguage()
end

function Update(frame)
	--calculate frame time
	frametime = math.min(GetRealTime() - previous_time, 2.56) --2.56 = 0.04 * 64, slowest possible speed.
	previous_time = GetRealTime()
	--display control info
	if frame == 1 then
		Notice("")
		Notice("")
		Notice("")
		LogW(STRINGS[lang].controls)
		LogW(STRINGS[lang].controls2)
		environment = GetEnvironmentPath()
		--Log(environment)
	end
	--hud
	--PerfMark("hud")
	UpdateHUD(frame)
	--PerfMark("hud")
	--update planes
	--PerfMark("planes")
	for k, v in pairs(data.planes) do
		local id = tonumber(k)
		local saveName = GetNodeProjectileSaveName(id)
		local teamId = NodeTeam(id)
		--plane controls
		UpdateControls(frame, id, saveName, teamId)
		--update plane weapon timers
		for kk, vv in pairs(v.timers) do
			--if 1 frame from reloaded then play the reload effect
			if vv > 0 and vv <= (1/fps) then
				ReloadEffect(id, saveName, kk)
			end
			--countdown to 0
			if vv >= (1/fps) then
				data.planes[k].timers[kk] = vv - (1/fps)
			else
				data.planes[k].timers[kk] = 0
			end
		end
		--plane physics
		UpdatePlanePhysics(id, saveName, teamId)
		UpdateHeliPhysics(id, saveName, teamId)
		--effect trails
		PlaneUpdateTrail(id, data.planes[tostring(id)].throttle)
	end
	--PerfMark("planes")
	PlaneUpdateSprite()
end

function OnWeaponFired(teamId, saveName, weaponId, projectileNodeId, projectileNodeIdFrom)
	if saveName == "runway" or saveName == "runway2" then
		--set the user control if its the first plane fired
		if GetLocalTeamId() == teamId then
			table.insert(user_control_available, projectileNodeId)
		end
		data.planes[tostring(projectileNodeId)] =
		{
			timers = {0,0,0},
			throttle = 1,
			elevator = 0,
			elevator_target = 0,
			free = true,
			mouse_pos = Vec3(0,0),
			angle = -1.5708,
		}
		planes_effects[tostring(projectileNodeId)] = {}
		PlaneAddEffects(projectileNodeId)
   elseif saveName == "HardPointSubFlak" then
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
	delta = fake_delta - previous_game_time
	previous_game_time = fake_delta
	frametime_left = frametime_left - delta
	--trail effect initialization
	if onjoin then
		EffectsSync()
		ScheduleCall(1, ChangeKeybindsControlSetup)
		onjoin = false
	end
	--PerfUpdate(delta)
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