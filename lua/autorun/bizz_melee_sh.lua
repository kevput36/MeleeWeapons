if SERVER then
	AddCSLuaFile()
end

local unblockable = {
	"npc_antlionguard",
	"npc_strider"
}


function ScaleDamage_bodybreak(  ply, hitgroup, dmginfo ) -- for dynamic hitbox's when fighting, hit someon's arm to reduce their damge temporarily or hit them in the leg to make them crouch for a bit. Hitting their head will also cause it's own issues.
	local attacker = dmginfo:GetAttacker()
	 if ( ply:IsPlayer() and ply:IsValid()) then
		if (string.find( attacker:GetActiveWeapon():GetClass(), "bizz_melee" )) then
			if dmginfo:IsDamageType( DMG_CLUB ) then
				dmgtype = 1 -- blunt
			else
				dmgtype = 0 -- sharp
			end
			if hitgroup == HITGROUP_HEAD then
				print("head hit with blunt object")
			end
		end
	 end
end
hook.Add("ScaleDamage","Bodypart Hit Functions", ScaleDamage_bodybreak)


hook.Add("Initialize", "initializeclocktime", function()  
	util.AddNetworkString( "Blocking" )
	util.AddNetworkString( "UnBlocking" )
end)

net.Receive("Blocking1", function( len )
	local wep = net.ReadEntity()
	wep:SetWeaponHoldType( "slam" ) 
end)

net.Receive("UnBlocking", function( len )
	local wep = net.ReadEntity()
	wep:SetWeaponHoldType( "slam" ) 
end)


--[[
function ChangePlayerStance()
	for k, v in pairs (player.GetAll()) do
		if v:IsValid and v:IsAlive() then
			if (string.find( v:HasWeapon(), "bizz_melee" )) then
				if (string.find( v:GetActiveWeapon():GetClass(), "bizz_melee" )) then
					local Stamina = v:GetDTFloat( 3 )
					local blocking = v:KeyDown(IN_ATTACK2) and Stamina > 0.2
					if blocking and not v:GetActiveWeapon().Blocking then
						v:GetActiveWeapon():SetWeaponHoldType( "slam" ) -- blocking holdtype
						v:GetActiveWeapon().Blocking = true
						net.Start("Blocking1")
						net.WriteEntity( v )
					elseif not blocking and v:GetActiveWeapon().Blocking then
						v:GetActiveWeapon():SetWeaponHoldType( v:GetActiveWeapon().Holdtype ) -- standard holdtype
						v:GetActiveWeapon().Blocking = false
					end
				end
			end
		end
	end
end
hook.Add("Think", "Melee_Stances", ChangePlayerStance )
]]

function EntityTakeDamageBlocking( target, dmginfo )

    if ( target:IsPlayer() and target:IsValid())  then
		if dmginfo:IsDamageType( DMG_CLUB ) or dmginfo:IsDamageType( DMG_SLASH ) then
			if target:KeyDown(IN_ATTACK2) and ((string.find( target:GetActiveWeapon():GetClass(), "bizz_melee" )) or (string.find( target:GetActiveWeapon():GetClass(), "weapon_fas" ))) then
	--		if target:GetActiveWeapon():GetDTBool(1) and (string.find( target:GetActiveWeapon():GetClass(), "bizz_melee" )) then
				local Stamina = target:GetDTFloat( 3 )
					if gamemode.Get("postnukerp") then
						strength = target:GetSkill("Backpacking")
					else
						strength = 0
					end
				SkillMult = (1 - (strength * 0.06))
				local plyhealth = target:Health()
				local dmgdealt = dmginfo:GetDamage( )
				local damstamina = (dmgdealt * 0.03) * SkillMult
				local attacker = dmginfo:GetAttacker()
				if !attacker:IsPlayer() then
					attackerangle = attacker:GetAngles().y
				else
					attackerangle = attacker:EyeAngles().y
				end
			
			local angle = attackerangle - target:GetAngles().y
			if angle < -180 then 
				angle = 360 +angle 
			end
			if angle <= 90 and angle >= -90 then 
				block = 0 -- not blockable
			else 
				block = 1 -- blockable
			end

				if block == 1 then -- 0s and 1s, everything comes down to them anyways. :P
						if Stamina > 0.2 then
							if dmginfo:IsDamageType( DMG_CLUB ) or dmginfo:IsDamageType( DMG_SLASH ) then
								if not table.HasValue(unblockable, attacker:GetClass()) then
									dmginfo:ScaleDamage( 0 ) -- setting this to 0 so we don't get any out of place blood particles when parrying
								end
							--	target:SetHealth( plyhealth - (dmgdealt * 0.04) )-- instead we set the players health to a lower value manually
								if plyhealth <= 0 then
									target:Kill() -- to fix a the rare problem of people living with 0 HP
								end
								if Stamina - damstamina < 0.2 then
									target:EmitSound("physics/metal/metal_solid_impact_bullet"..math.random(1,4)..".wav",120,100)
								else
									target:EmitSound("physics/metal/metal_solid_impact_soft"..math.random(1,3)..".wav",100,100)
								end
								--damage stamina.
								target:SetDTFloat( 3, (Stamina - damstamina) )
							else
								return
							end
						end	
		--			end
				end
			end
			return dmginfo
		end
	end
end
hook.Add("EntityTakeDamage","Scale Blocking Damage", EntityTakeDamageBlocking)
