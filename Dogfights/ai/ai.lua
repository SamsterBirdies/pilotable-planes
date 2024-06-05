ShootableProjectile["sbpp_f16"] = true
ShootableProjectile["sbpp_Biplane"] = true
ShootableProjectile["sbpp_grenade"] = true
ShootableProjectile["sbpp_sidewinder"] = true
ShootableProjectile["sbpp_hellcat"] = true
ShootableProjectile["sbpp_p51"] = true
ShootableProjectile["sbpp_ac130"] = true
ShootableProjectile["sbpp_apache"] = true
ShootableProjectile["sbpp_hydra"] = true
ShootableProjectile["sbpp_hellfire"] = true

PlaneSaveNames = {"thunderbolt","nighthawk","sbpp_f16","sbpp_Biplane","sbpp_hellcat","sbpp_p51","sbpp_ac130","sbpp_apache"}
--[[function OnPortalUsed(nodeA, nodeB, nodeADest, nodeBDest, objectTeamId, objectId, isBeam)
   if plane then
      if objectTeamId%MAX_SIDES == teamId then
         table.insert(data.TrackedProjectiles, { ProjectileNodeId = nodeId, AntiAirWeapons = {}, Claims = {} })
      end
   end
end]]


function OnWeaponFired(weaponTeamId, saveName, weaponId, projectileNodeId, projectileNodeIdFrom)
	if data.gameWinner and data.gameWinner ~= teamId then return end

	if weaponTeamId%MAX_SIDES == enemyTeamId then
		local projectileSaveName = GetNodeProjectileSaveName(projectileNodeId)

		if ShootableProjectile[projectileSaveName] then
			--LogDetail("Enemy weapon " .. saveName .. " fired, tracking " .. (#data.TrackedProjectiles + 1))
			local delay = 0
			if not NoAntiAirReactionTime[saveName] then
				delay = GetRandomFloat(data.AntiAirReactionTimeMin, data.AntiAirReactionTimeMax, "OnWeaponFired 2 T" .. teamId .. ", " .. weaponId .. ", " .. projectileNodeId)
			end
			ScheduleCall(delay, TrackProjectile, projectileNodeId)
		end
	end

	if data.BuildIntoSmoke then
		local projType = GetNodeProjectileSaveName(projectileNodeId)
		if Fort and projType == "smoke" then
			ScheduleCall(0.5, BuildIntoSmoke, projectileNodeId, 4)
		end
	end
end

function TrackProjectile(nodeId)
	local nodeTeamId = NodeTeam(nodeId) -- returns TEAM_ANY if non-existent
	if nodeTeamId%MAX_SIDES == enemyTeamId then -- node may have changed team since firing
      IsPlane = false
      for _, planeSaveName in ipairs(PlaneSaveNames) do
         if GetNodeProjectileSaveName(nodeId) == planeSaveName then
            IsPlane = true
            break
         end
      end
		table.insert(data.TrackedProjectiles, {IsPlane = IsPlane, ProjectileNodeId = nodeId, AntiAirWeapons = {}, Claims = {} })
	end
end

function TryShootDownProjectiles()
	if data.gameWinner and data.gameWinner ~= teamId then return end

	for id,lockdown in pairs(data.AntiAirLockDown) do
		if data.gameFrame - lockdown[1] > 2.5*30 then
			data.AntiAirLockDown[id] = nil
		end
	end

	for k,v in ipairs(data.TrackedProjectiles) do
		local nodeTeamId = AA_NodeTeam(v.ProjectileNodeId)
      
		if not v.IsPlane and nodeTeamId%MAX_SIDES ~= enemyTeamId then --[[nodeTeamId == TEAM_ANY ]]
			for a,b in ipairs(v.AntiAirWeapons) do
				if IsAIDeviceAvailable(b) then
					TryCloseWeaponDoorsWithDelay(b, "TryShootDownProjectiles CloseDoors proj " .. v.ProjectileNodeId .. ", ")
				end
			end

			table.remove(data.TrackedProjectiles, k)
		end
	end

	if not data.Disable and not data.DisableAntiAir then
		local weaponCount = GetAntiAirWeaponCount()
		if data.NextAntiAirIndex >= weaponCount then
			data.NextAntiAirIndex = 0
		end

		if #data.TrackedProjectiles > 0 then
			local fireTestFlags = FIREFLAG_TEST | FIREFLAG_IGNOREFASTDOORS | FIREFLAG_TERRAINBLOCKS | FIREFLAG_EXTRACLEARANCE
			local rayFlags = RAY_EXCLUDE_CONSTRUCTION | RAY_NEUTRAL_BLOCKS | RAY_PORTAL_BLOCKS | RAY_EXCLUDE_FASTDOORS | RAY_EXTRA_CLEARANCE
			for index = data.NextAntiAirIndex, weaponCount - 1 do
				local id = GetAntiAirWeaponId(index)
				local type = GetDeviceType(id)
				local weaponPos = GetWeaponBarrelPosition(id)
				local speed = AntiAirFireSpeed[type] or GetWeaponTypeProjectileSpeed(type)
				local antiAirFireProb = data.AntiAirFireProbability[type]
				local weaponOverride = data.AntiAirWeaponOverride[id]
				if weaponOverride then
					antiAirFireProb = weaponOverride
				end
				local fieldBlockFlags = 0
				if GetWeaponFieldsBlockFiring(id) then
					fieldBlockFlags = FIELD_BLOCK_FIRING
				end

				local range = nil
				if AntiAirFireLeadTimeMax[type] then
					range = AntiAirFireLeadTimeMin[type]*speed
				end

				if antiAirFireProb and not data.AntiAirLockDown[id] and IsDeviceFullyBuilt(id) and IsAIDeviceAvailable(id) and not IsDummy(id)
					and (GetRandomFloat(0, 1, "TryShootDownProjectiles FireProb " .. id) < antiAirFireProb) then
					--LogEnum("AntiAir " .. id .. " type " .. type)

					local dangerOfImpact = false
					local closestTimeToImpact = 1000000
					local bestTarget = nil
					local best_t = nil
					local best_pos = nil
					local best_vel = nil
					for k,v in ipairs(data.TrackedProjectiles) do
						--Log("Evaluating projectile " .. v.ProjectileNodeId)

						if v.IsVirtual and (data.AntiAirFiresAtVirtualWithin[type] == nil or v.TimeLeft > data.AntiAirFiresAtVirtualWithin[type]) then
							continue
						end

						local projectileId = v.ProjectileNodeId
						local projectileType = AA_GetNodeProjectileType(v.ProjectileNodeId)
						local projectileSaveName = AA_GetNodeProjectileSaveName(v.ProjectileNodeId)
						local antiAirInclude = data.AntiAirInclude[type]
						local antiAirExclude = data.AntiAirExclude[type]

						if projectileType >= 0
							and (projectileType ~= PROJECTILE_TYPE_MISSILE or AA_IsMissileAttacking(projectileId)) and TableLength(v.Claims) == 0
		 					and (antiAirInclude == nil or antiAirInclude[projectileSaveName] == true)
							and (antiAirExclude == nil or antiAirExclude[projectileSaveName] ~= true) then

							local pos = AA_NodePosition(projectileId)
							local currVel = AA_NodeVelocity(projectileId)
							local delta = weaponPos - pos

							-- calculate the time it will take to get our projectile to the target position
							local fireDelay = GetWeaponTypeFireDelay(type, teamId)
							local fireRoundsEachBurst = GetWeaponTypeRoundsEachBurst(type, teamId)
							local firePeriod = GetWeaponTypeRoundsPeriod(type, teamId)
							local leadTime = fireDelay + 0.5*(fireRoundsEachBurst - 1)*firePeriod

							local d = Vec3Length(delta)
							local targetSpeed = Vec3Length(currVel)
							local timeToImpact = d/(targetSpeed + speed) + leadTime
							local timeToSelf = d/targetSpeed

							pos, vel = PredictProjectilePos(projectileId, timeToImpact)
							local direction = Vec3(vel.x, vel.y)
							Vec3Unit(direction)

							if projectileType == PROJECTILE_TYPE_MISSILE then 
								currVel.x = vel.x
								currVel.y = vel.y
							end

							local deltaUnit = Vec3(delta.x, delta.y)
							Vec3Unit(deltaUnit)

							local minTimeToImpact = AntiAirMinTimeToImpact[type] or data.AntiAirMinTimeToImpact

							-- avoid ray cast if there's no chance it will pass further testing
							-- ignore projectile if it's too close to shoot at
							if (timeToImpact < closestTimeToImpact or timeToSelf < minTimeToImpact) then
								-- don't fire at projectiles that are behind the weapon
								local weaponForward = GetDeviceForward(id)
								local dot = Vec3Dot(weaponForward, deltaUnit)
								if dot < 0 then
									local rayHit = CastRayFromDevice(id, pos, 1, rayFlags, fieldBlockFlags)
									local hitDoor = GetRayHitDoor()
									local lineOfSight = rayHit == RAY_HIT_NOTHING or hitDoor
									local incomingAngle = ToDeg(math.acos(Vec3Dot(deltaUnit, direction)))

									local trajectoryThreat = lineOfSight and incomingAngle < 15
									if lineOfSight then -- and projectileType == PROJECTILE_TYPE_MORTAR then
										local g = AA_GetProjectileGravity(projectileId)
										if g == 0 or projectileType == PROJECTILE_TYPE_MISSILE then g = 0.00001 end
										local a = 0.5*g/(currVel.x*currVel.x)
										local dydx = currVel.y/currVel.x;
										local x = -delta.x
										local y = -delta.y
										local b = dydx - 2*a*x
										local c = y - (a*x*x + b*x)
										local discriminant = b*b - 4*a*c
										if discriminant > 0 then
											local discriminantSqRt = math.sqrt(discriminant)
											local interceptA = (-b + discriminantSqRt)/(2*a)
											local interceptB = (-b - discriminantSqRt)/(2*a)
											local threatA = math.abs(interceptA) < 200
											local threatB = math.abs(interceptB) < 200
									
											if not threatA and not threatB then
												trajectoryThreat = false
											end
											if ShowAntiAirTrajectories and threatA then
												SpawnCircle(weaponPos + Vec3(interceptA, 0), 10, Red(128), data.AntiAirPeriod)
											end
											if ShowAntiAirTrajectories and threatB then
												SpawnCircle(weaponPos + Vec3(interceptB, 0), 10, Red(128), data.AntiAirPeriod)
											end
										end

										if range then
											-- work out roughly where the projectile enters the range of the weapon
											local entryPoint = nil
											local start = -delta.x
											local targetTime = 0
											local doorOffset = 0
											if hitDoor then
												doorOffset = -AntiAirDoorDelay
											end

											local step = 200
											local timeStep = step/math.abs(currVel.x)
											if delta.x < 0 then
												step = -step
											end
											local p1 = a*start*start + b*start + c
											for i = start + step, weaponPos.x, step do
												targetTime = targetTime + timeStep

												local p2 = a*i*i + b*i + c
												if ShowAntiAirTrajectories then
													SpawnLine(weaponPos + Vec3(i - step, p1), weaponPos + Vec3(i, p2), Green(64), data.AntiAirPeriod)
												end
												p1 = p2

												local targetPos = weaponPos + Vec3(i, p2)
												local dist = Vec3Dist(weaponPos, targetPos)
												if range and dist < range then
													if ShowAntiAirTrajectories then
														SpawnCircle(targetPos, 20, White(), data.AntiAirPeriod)
													end
													entryPoint = targetPos
													--Log("entry at " .. targetTime)
													break
												end
											end

											if not entryPoint
												or (AntiAirFireLeadTimeMin[type] == nil or (targetTime + doorOffset) < AntiAirFireLeadTimeMin[type])
												or (AntiAirFireLeadTimeMax[type] == nil or (targetTime + doorOffset) >= AntiAirFireLeadTimeMax[type]) then
													continue
											elseif targetTime <= range/speed then
												timeToImpact = targetTime
												pos = entryPoint
											end
										end
									end

									local danger = timeToSelf < minTimeToImpact and trajectoryThreat

									if lineOfSight -- must be able to shoot it
										and (danger or danger == dangerOfImpact) -- ignore unthreatening projectiles if one has been found
										and timeToImpact < closestTimeToImpact then -- target the closest projectile
										--Log("  Best target so far, impact " .. timeToImpact .. " self " .. timeToSelf)
										closestTimeToImpact = timeToImpact
										bestTarget = v
										best_pos = pos
										best_vel = MissileVelToTarget(projectileType, projectileId, vel, pos)

										if ShowAntiAirLockdowns and danger and DoorCountAI(id) > 0 then
											SpawnLine(weaponPos, pos, Red(128), 2.5)
										end
									end
									dangerOfImpact = dangerOfImpact or danger

									-- optimise: avoid further ray casts
									if dangerOfImpact then
										break
									end
								end
							end
						end
					end

					-- shoot at the closest projectile found
					if bestTarget and IsWeaponReadyToFire(id) then
						local uncertainty = 1
						local maxUncertainty = 1

						--Log("best_pos " .. tostring(best_pos) .. " target node " .. bestTarget.ProjectileNodeId)

						local projectileGroup = {}
						if closestTimeToImpact > maxUncertainty then
							-- search for nearby targets and aim for the middle
							local accPos = Vec3()
							local accVel = Vec3()
							local count = 0
							for k,v in ipairs(data.TrackedProjectiles) do
								--Log("  checking projectile " .. tostring(v.ProjectileNodeId))
								if AA_IsMissileAttacking(v.ProjectileNodeId) then
									local pos, vel = PredictProjectilePos(v.ProjectileNodeId, closestTimeToImpact)
									--Log("    is attacking, time " .. closestTimeToImpact .. " pos " .. tostring(pos))
									if Vec3Length(pos - best_pos) < 500 then
										--Log("      within range")
										local projectileType = AA_GetNodeProjectileType(v.ProjectileNodeId)
										accPos = accPos + pos
										accVel = accVel + MissileVelToTarget(projectileType, v.ProjectileNodeId, vel, pos)
										count = count + 1
										table.insert(projectileGroup, v)
									end
								end
							end

							if ShowAntiAirTargets and count > 1 then
								SpawnCircle(best_pos, 500, White(64), data.AntiAirPeriod)
							end

							if count > 0 then
								best_pos = (1/count)*accPos;
								best_vel = (1/count)*accVel;
							end
						end

						local v = bestTarget
						local pos = best_pos
						local vel = best_vel
						local timeToImpact = closestTimeToImpact
						--LogEnum("Targeting projectile " .. v.ProjectileNodeId .. " with time to impact " .. closestTimeToImpact)

						local projectileSaveName = AA_GetNodeProjectileSaveName(v.ProjectileNodeId)
						local projectileType = AA_GetNodeProjectileType(v.ProjectileNodeId)
						local blocked = false

						if timeToImpact < maxUncertainty then
							-- become more certain as the projectile gets closer
							uncertainty = uncertainty*(timeToImpact/maxUncertainty)
						end

						-- aim at projected target position in the future, with some deviation for balance
						local right = Vec3Unit(Vec3(-vel.y, vel.x))
						pos = pos + uncertainty*GetNormalFloat(data.AntiAirLateralStdDev[projectileType], 0, "TryShootDownProjectiles LateralDev " .. id)*right

						if ShowAntiAirTargets then
							SpawnLine(best_pos, pos, White(128), data.AntiAirPeriod)
						end

						if ShowAntiAirTargets then
							SpawnEffect("effects/weapon_blocked.lua", best_pos)
							SpawnEffect("effects/weapon_blocked.lua", pos)
						end

						ReserveWeaponAim(id, 1.5*data.AntiAirPeriod)

						-- some weapons should not open doors to shoot down some projectiles (e.g. mini-guns against mortars) unless they are protected
						-- also if there isn't much time left don't open the door
						local slowDoorsBlock = data.AntiAirOpenDoor[type] ~= nil and data.AntiAirOpenDoor[type][projectileSaveName] == false
						local power = data.AntiAirPower[type] or 1
						local doorDelay = 0

						local fireResult = FireWeaponWithPower(id, pos, 0, FIREWEAPON_STDDEVTEST_DEFAULT, fireTestFlags, power)
						if fireResult == FIRE_DOOR then
							doorDelay = AntiAirDoorDelay
						end

						if dangerOfImpact or
							slowDoorsBlock or
							data.AntiAirLockDown[id] then

							blocked = fireResult ~= FIRE_SUCCESS

							--if blocked then
								--LogDetail(id .. " blocked: " .. fireResult .. " danger " .. tostring(dangerOfImpact))
							--end

							-- see if the door is high to make an exception to the open door setting
							if fireResult == FIRE_DOOR and not dangerOfImpact and not data.AntiAirLockDown[id] then
								local nA = GetRayHitLinkNodeIdA()
								local nB = GetRayHitLinkNodeIdB()
								--LogDetail(id .. " testing door: " .. nA .. ", " .. nB)
								if nA > 0 and nB > 0 then
									local posA = AA_NodePosition(nA)
									local posB = AA_NodePosition(nB)
									if posA.y < weaponPos.y - 10 and posB.y < weaponPos.y - 10 then
										--Log(id .. " opening high door for " .. projectileType)
										blocked = false
									end
								end
							end
							--LogDetail(type .. " in danger or does not open doors for " .. projectileType .. ", blocked = " .. tostring(blocked))
						else
							-- don't aim at things we can't see
							local rayFlags = RAY_EXCLUDE_CONSTRUCTION | RAY_NEUTRAL_BLOCKS | RAY_PORTAL_BLOCKS
							local rayHit = CastRayFromDevice(id, pos, 1, rayFlags, fieldBlockFlags)
							blocked = rayHit ~= RAY_HIT_NOTHING
						end
						
						if not blocked then
							local projSaveName = GetWeaponSelectedAmmo(id)
							local projParams = GetProjectileParams(projSaveName, teamId)

							if hasbit(projParams.FieldType, FIELD2_DECOY_ENEMY_BIT) then
								pos = AimDecoyAtEnemy(pos, id, projParams, fieldBlockFlags)
							end

							local stdDev = data.AntiAirErrorStdDev[type]
							--LogDetail("Shooting down projectile " .. v.ProjectileNodeId .. " weapon " .. id)
							local result = FireWeaponWithPower(id, pos, stdDev or 0, FIREWEAPON_STDDEVTEST_DEFAULT, FIREFLAG_EXTRACLEARANCE, power)
							if result == FIRE_SUCCESS then
								-- close door in a little delay once the projectile is lost
								if AntiAirClaimsProjectile[type] then
									v.Claims[id] = true
									for i,p in pairs(projectileGroup) do
										p.Claims[id] = true
									end
								end
								InsertUnique(v.AntiAirWeapons, id)
								data.NextAntiAirIndex = index + 1
								
								if IsSlowFiringAntiAir(id) then
									local timeRemaining = GetWeaponFiringTimeRemaining(id)
									TryCloseWeaponDoorsWithDelay(id, "slow firing AA ", timeRemaining)
								end

								-- give a chance to keep firing anti-air weapons
								if GetRandomFloat(0, 100, "TryShootDownProjectiles Persist " .. id) < 50 then
									break
								end
							else
								if result == FIRE_DOOR then
									-- door will be opening, will try again soon
							
									-- remember to close doors that were opened but didn't have an opportunity to close
									InsertUnique(v.AntiAirWeapons, id)
								end
								LogDetail(FIRE[result])
							end
						end
					end

					if dangerOfImpact and DoorCountAI(id) > 0 then
						local timeRemaining = GetWeaponFiringTimeRemaining(id)
						if bestTarget then
							--LogDetail(type .. " has danger of impact from " .. bestTarget.ProjectileNodeId .. " closing doors of " .. id)
							data.AntiAirLockDown[id] = { data.gameFrame, bestTarget.ProjectileNodeId }
						end
						ScheduleCall(timeRemaining, TryCloseWeaponDoors, id)
					end
				end

				data.NextAntiAirIndex = index + 1
			end
		end
	end

	ScheduleCall(data.AntiAirPeriod, TryShootDownProjectiles)
end
