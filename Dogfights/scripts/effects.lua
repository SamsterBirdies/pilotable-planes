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
	planes_effects[tostring(id)].helicopter = true
	planes_effects[tostring(id)].sprite_left = effect_left_id
	planes_effects[tostring(id)].sprite_right = effect_right_id
	planes_effects[tostring(id)].pos_previous = NodePosition(id)
	planes_effects[tostring(id)].pos_now = NodePosition(id)
	planes_effects[tostring(id)].angle_previous = data.planes[tostring(id)].angle
	planes_effects[tostring(id)].angle_now = data.planes[tostring(id)].angle
	--set default team heading
	if NodeVelocity(id).x < 0 then
		planes_effects[tostring(id)].heading_left = true
	else
		planes_effects[tostring(id)].heading_left = false
	end
end

function PlaneRemoveSprite(id)
	if planes_effects[tostring(id)] and planes_effects[tostring(id)].sprite_left then
		CancelEffect(planes_effects[tostring(id)].sprite_left)
		CancelEffect(planes_effects[tostring(id)].sprite_right)
	end
	planes_effects[tostring(id)].helicopter = false
	planes_effects[tostring(id)].sprite_left = nil
	planes_effects[tostring(id)].sprite_right = nil
	planes_effects[tostring(id)].pos_previous = nil
	planes_effects[tostring(id)].pos_now = nil
	planes_effects[tostring(id)].angle_previous = nil
end

function PlaneHeadingLeft(id)
	--if not controlled, dont change the direction its facing
	if data.planes[tostring(id)].free then
		return planes_effects[tostring(id)].heading_left
	end
	--make heli face the direction that cursor is on
	if planes_effects[tostring(id)].pos_now.x > data.planes[tostring(id)].mouse_pos.x then
		return true
	else
		return false
	end
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
				--BetterLog(sprite_id)
				--Log('left')
			else
				SetEffectPosition(v.sprite_left, Vec3(0, 2^30))
				sprite_id = v.sprite_right
				--BetterLog(sprite_id)
				--Log('right')
			end
			--interpolate sprite position
			local vec_dist = SubtractVec(v.pos_now, v.pos_previous)
			--BetterLog(v.pos_now)
			--BetterLog(v.pos_previous)
			local vec_dist_divided = SubtractVec(vec_dist, (MultiplyVec(vec_dist, frametime_left * 25)))
			SetEffectPosition(sprite_id, AddVec(v.pos_previous, vec_dist_divided))
			--interpolate sprite rotation
			local rotation_distance = SubtractVec(Rad2Vec(data.planes[tostring(k)].angle), Rad2Vec(planes_effects[tostring(k)].angle_previous))
			local rotation_divided = SubtractVec(rotation_distance, (MultiplyVec(rotation_distance, frametime_left * 25)))
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