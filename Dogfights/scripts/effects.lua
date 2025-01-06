--all effects
function EffectsSync()
	--planes_trails = {}
	planes_effects = {}
	for k, v in pairs(data.planes) do
		local id = tonumber(k)
		PlaneAddEffects(id)
	end
end
function PlaneAddEffects(id)
	planes_effects[tostring(id)] = {}
	PlaneSpawnTrail(id)
	local helicopter = GetProjectileParamBool(GetNodeProjectileSaveName(id), NodeTeam(id), "sb_planes.helicopter", false)
	if helicopter then
		PlaneSpawnSprite(id)
	end
end
function PlaneRemoveEffects(id)
	PlaneRemoveTrail(id)
	local helicopter = GetProjectileParamBool(GetNodeProjectileSaveName(id), NodeTeam(id), "sb_planes.helicopter", false)
	if helicopter then
		PlaneRemoveSprite(id)
	end
	planes_effects[tostring(id)] = nil
end
--trail effects
function PlaneSpawnTrail(id)
	local effect = GetProjectileParamString(GetNodeProjectileSaveName(id), NodeTeam(id), "sb_planes.trail_effect", "")
	if NodeTeam(id)%100 == 2 then
		effect = effect .. "2.lua"
	else
		effect = effect .. "1.lua"
	end	
	local effect_id = SpawnEffect(effect, NodePosition(id))
	AddToEffectLifeSpan(effect_id, 198469420.0)
	planes_effects[tostring(id)].trail = effect_id
end

function PlaneRemoveTrail(id)
	if planes_effects[tostring(id)] and planes_effects[tostring(id)].trail then
		CancelEffect(planes_effects[tostring(id)].trail)
	end
	planes_effects[tostring(id)].trail = nil
end

function PlaneUpdateTrail(id, throttle)
	if planes_effects[tostring(id)] and planes_effects[tostring(id)].trail then
		local effect_id = planes_effects[tostring(id)].trail
		SetEffectPosition(effect_id, NodePosition(id))
		SetAudioParameter(effect_id, "throttle", throttle)
		SetAudioParameter(effect_id, "doppler_shift", DopplerCalculate(NodePosition(id), NodeVelocity(id)))
	end
end

--reload effect
function ReloadEffect(id, saveName, weapon)
	if user_control == id then
		local effect_path = GetProjectileParamString(saveName, NodeTeam(id), "sb_planes.weapon" .. tostring(weapon) .. ".reload_effect", "")
		SpawnEffect(effect_path, Vec3(0,0))
	end
end

--helicopter sprite projectile overlay effects
function PlaneSpawnSprite(id)
	local effect = GetProjectileParamString(GetNodeProjectileSaveName(id), NodeTeam(id), "sb_planes.sprite", "")
	local effect_left_id = SpawnEffect(effect .. "left.lua", NodePosition(id))
	local effect_right_id = SpawnEffect(effect .. "right.lua", NodePosition(id))
	AddToEffectLifeSpan(effect_left_id, 198469420.0)
	AddToEffectLifeSpan(effect_right_id, 198469420.0)
	local id_string = tostring(id)
	planes_effects[id_string].helicopter = true
	planes_effects[id_string].sprite_left = effect_left_id
	planes_effects[id_string].sprite_right = effect_right_id
	planes_effects[id_string].pos_previous = NodePosition(id)
	planes_effects[id_string].pos_now = NodePosition(id)
	planes_effects[id_string].angle_previous = data.planes[id_string].angle
	planes_effects[id_string].angle_now = data.planes[id_string].angle
	--set default team heading
	if NodeVelocity(id).x < 0 then
		planes_effects[tostring(id)].heading_left = true
	else
		planes_effects[tostring(id)].heading_left = false
	end
end

function PlaneRemoveSprite(id)
	local id_string = tostring(id)
	if planes_effects[id_string] and planes_effects[id_string].sprite_left then
		CancelEffect(planes_effects[id_string].sprite_left)
		CancelEffect(planes_effects[id_string].sprite_right)
	end
	planes_effects[id_string].helicopter = false
	planes_effects[id_string].sprite_left = nil
	planes_effects[id_string].sprite_right = nil
	planes_effects[id_string].pos_previous = nil
	planes_effects[id_string].pos_now = nil
	planes_effects[id_string].angle_previous = nil
end

function PlaneHeadingLeft(id)
	--if not controlled, dont change the direction its facing
	local id_string = tostring(id)
	if data.planes[id_string].free then
		return planes_effects[id_string].heading_left
	end
	--make heli face the direction that cursor is on
	if data.planes[id_string].mouse_direction < 0 then
		return true
	else
		return false
	end
end

function DopplerCalculate(position, velocity)
	--take camera velocity into account
	local velocity2 = SubtractVec(camera_velocity, velocity)
	--vector position relative to camera at current frame
	local position1_relative = SubtractVec(position, camera_pos) 
	local position1_pythag = (position1_relative.x^2 + position1_relative.y^2 + position1_relative.z^2) ^ 0.5 --distance from camera
	--vector position relative to camera at next frame
	local position2_relative = SubtractVec(AddVec(position, velocity2), camera_pos)
	local position2_pythag = (position2_relative.x^2 + position2_relative.y^2 + position2_relative.z^2) ^ 0.5 --distance from camera
	--delta distance from camera (next dist - current dist)
	return position2_pythag - position1_pythag
end

function PlaneUpdateSprite()
	for k, v in pairs(planes_effects) do
		if v.helicopter then
			v.pos_previous = v.pos_now
			v.pos_now =  NodePosition(tonumber(k))
			v.angle_previous = v.angle_now
			v.angle_now = data.planes[tostring(k)].angle
			v.heading_left = PlaneHeadingLeft(tonumber(k))
		end
	end
	frametime_left = 1 / fps
end

function PlaneOnUpdateSprite()
	for k, v in pairs(planes_effects) do
		if v.helicopter then
			local sprite_id = 0
			--hide unused sprite
			if v.heading_left then
				SetEffectPosition(v.sprite_right, Vec3(0, 2^30))
				sprite_id = v.sprite_left
			else
				SetEffectPosition(v.sprite_left, Vec3(0, 2^30))
				sprite_id = v.sprite_right
			end
			--interpolate sprite position
			local vec_dist = SubtractVec(v.pos_now, v.pos_previous)
			local vec_dist_divided = SubtractVec(vec_dist, (MultiplyVec(vec_dist, frametime_left * fps)))
			SetEffectPosition(sprite_id, AddVec(v.pos_previous, vec_dist_divided))
			--interpolate sprite rotation
			local rotation_distance = SubtractVec(Rad2Vec(data.planes[tostring(k)].angle), Rad2Vec(planes_effects[tostring(k)].angle_previous))
			local rotation_divided = SubtractVec(rotation_distance, (MultiplyVec(rotation_distance, frametime_left * fps)))
			SetEffectDirection(sprite_id, AddVec(Rad2Vec(v.angle_previous), rotation_divided))
		end
	end
end

local dust_effects = 
{
	['environment/alpine'] = 'snow',
	['environment/polluted'] = 'grey',
	['environment/desert'] = 'sand',
	['../../../workshop/content/410900/2985388631/environment/Mars'] = 'mars',
	['../../../workshop/content/410900/1308302446/environment/Mars'] = 'mars',
}
function EffectsHeliDust(nodeId, saveName, pos, normal, surface_type)
	if saveName ~= "sbpp_heliwind" then return end
	if GetSurfaceSaveName(surface_type) == 'whitecaps' then return end
	local angle = Vec2Rad(normal)
	if NodeVelocity(nodeId).x > 0 then
		angle = angle + DEG90
	else
		angle = angle - DEG90
	end
	local dust_effect = ''
	if dust_effects[environment] then
		dust_effect = dust_effects[environment]
	end
	local effectId = SpawnEffect(path .. '/effects/helidust' .. dust_effect .. '.lua', pos)
	SetEffectDirection(effectId, Rad2Vec(angle))
end