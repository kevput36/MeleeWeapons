AddCSLuaFile()
SWEP.Base = "clavus_construct" -- TY clavus
SWEP.PrintName = "meleebase"
SWEP.Author = "Bizzclaw"
SWEP.Contact = "N/A"
SWEP.Purpose = "Sharp Melee weapon."
SWEP.Spawnable = false
SWEP.Category = "Melee - Bizzclaw"
SWEP.UseHands = true
 
SWEP.ViewMovelFOV = 60

SWEP.ViewModel = "models/weapons/c_bizz_melee_1ht.mdl"
SWEP.WorldModel = "models/weapons/b_machete.mdl"

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_Spine4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, -3.225), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, -4.183), angle = Angle(0, 0, 0) }
}

function SWEP:PreDrawViewModel( vm, wep, ply )
	vm:SetMaterial( "engine/occlusionproxy" )
end

SWEP.AutoswitchTo = false
SWEP.AutoswitchFrom = false

SWEP.Slot = 1
SWEP.SlotPos = 0

SWEP.DrawCrosshair = false
SWEP.DrawAmmo = false

SWEP.Primary.Recoil		= 5
SWEP.Primary.Damage		= 25
SWEP.Primary.NumShots		= 0
SWEP.Primary.Cone			= 0.075
SWEP.Primary.Delay 		= .9

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= 1					
SWEP.Primary.Automatic		= false				
SWEP.Primary.Ammo			= ""

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false				
SWEP.Secondary.Ammo		= "none"

SWEP.BlockPos = Vector(-7.008, -7.165, -5.277)
SWEP.BlockAngle = Vector(32.243, 3.582, -37.757)

SWEP.HideMachete = true
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true

SWEP.SwingSound = {
	"npc/zombie/claw_miss1.wav",
	"npc/zombie/claw_miss2.wav",
}
--sound made made by the weapon swinging
SWEP.HitSound = ""
--sound made on confirmed hit, probably to be removed soon.
SWEP.Holdtype = "Melee2"
--initial holdtype when not blocking
SWEP.StaminaCost = 0.2
--does nothing unless you have kogitsune's Stamina System (Fixed by bizzclaw, me.)
SWEP.HitDistance = 65
--Weapon's reach
SWEP.DamageType = DMG_SLASH
SWEP.Type = "Sharp"
SWEP.Sharpness = 50
SWEP.Weight = 3
--SWEP.Type = "Blunt" -- example
--"Sharp" is for Sharp weapons, "Blunt" is for blunt weapons
--Damagetype, important for creating effects.
SWEP.CanBlock = true

function SWEP:EntityFaceBack(ent)

	local angle = self.Owner:GetAngles().y - ent:GetAngles().y

	if angle < -180 then angle = 360 + angle end
	if angle <= 90 and angle >= -90 then return true end

	return false
end

SWEP.ChargedTime = 0
SWEP.AtkStance = "idle"
SWEP.NextAttk = 0
SWEP.DrawDelay = 0
function SWEP:AttackPrep(direction)
	direction = "right"
	wt = self.Weight
	if (CurTime() < self.NextAttk) or (self.DrawDelay > CurTime()) then return end -- wait
	local anim 
	if diection == "right" then
		anim = "1h_attackprep_right_idle"
	elseif diection == "left" then
		anim = "1h_attackprep_right_left"
	else
		anim = "1h_attackprep_right_idle"
	end
	self.AtkStance = "prep"
	self.ChargedTime = CurTime()
	if CLIENT then
		self:EmitSound("npc/zombie/foot_slide"..math.random(1,3)..".wav",100,math.random(90,120))
	end
	vm = self.Owner:GetViewModel()
	
	local swingspeed = 3
	vm:SetPlaybackRate(swingspeed)
	vm:ResetSequence( vm:LookupSequence(anim ) )
	self.ChargedTime = CurTime()
	
end

function SWEP:Attack(direction)
	local curclass = self:GetClass()
	local curowner = self.Owner
	local pulldelay = 0.06 -- time we wait for the weapon to be pulled back first before it swings
	if CurTime() <= self.ChargedTime + pulldelay then 
		timer.Simple((CurTime() + pulldelay) - self.ChargedTime, function()
			if curclass == curowner:GetActiveWeapon():GetClass() then
				self:Attack(direction) -- retry the attack
			end
		end)
		return
	end
	local wt = self.Weight
	local delay = (wt * 0.002)
	if self.AtkStance == "prep" then
		if diection == "right" then
			anim = "1h_attack_right"
		elseif diection == "left" then
			anim = "1h_attack_left"
		else
			anim = "1h_attack_right"
		end
		 self.AtkStance = "attack"
		vm = self.Owner:GetViewModel()
		vm:SetPlaybackRate(2.0)
		vm:ResetSequence( vm:LookupSequence(anim))
		vm:SetPlaybackRate(3.0)
		self.NextAttk = CurTime() + 0.5 -- will configure delay based on weight later
		self:TraceDamage(direction, delay)
		local sound = tostring(table.Random(self.SwingSound))
		self:EmitSound(sound,100,math.random(90,120))
	end
	self.NextAttk = CurTime() + 0.4
	self:Idle()
end


--[[
 -- failed attempt at trying to make everything networked :(
function SWEP:SendClientAnim(anim, rate)
	if SERVER then
		net.Start("BM.ReciveAnim")
		net.WriteString(anim)
		net.WriteFloat(rate)
		net.WriteEntity( self.Owner )
		net.Send(self.Owner)
	end
end

if CLIENT then -- all cientside, no choppy anims here. 
	net.Receive("BM.ReciveAnim", function(len)
		local ply = net.ReadEntity()
		local anim = net.ReadString()
		local rate = net.ReadFloat()
		local vm = LocalPlayer():GetViewModel()
		local sequence = vm:LookupSequence("1h_attack_right")
--		vm:SetPlaybackRate(rate)
		vm:ResetSequence(sequence)
		print(tostring(sequence))
	end)
end


]]

function MeleeKeyPress(ply, key) -- even though it's more of the mouse being clicked but whatever 
	local hasmelee = false
	if ply:IsValid() and ply:Alive() then
		local wep = ply:GetActiveWeapon()
		for k, v in pairs(ply:GetWeapons()) do
			if (string.find( wep:GetClass(), "bizz_melee" )) then
				hasmelee = true
			end
		end
		wep = ply:GetActiveWeapon()
		if (string.find( wep:GetClass(), "bizz_melee" )) then -- is the palyer using the melee weapon?
			if key == IN_ATTACK then
				wep:AttackPrep("right")
				--attack
			elseif key == IN_ATTACK2 then
				--block
			end
		end
	end
end
hook.Add("KeyPress", "melee.keypress", MeleeKeyPress)

function MeleeKeyRelease(ply, key)
	local hasmelee = false
	if ply:IsValid() and ply:Alive() then
		local wep = ply:GetActiveWeapon()
		for k, v in pairs(ply:GetWeapons()) do
			if (string.find( wep:GetClass(), "bizz_melee" )) then
				hasmelee = true
			end
		end
		if hasmelee then
			if (string.find( wep:GetClass(), "bizz_melee" )) then -- is the palyer using the melee weapon?
				if key == IN_ATTACK then
					wep:Attack("right")
					--attack
				elseif key == IN_ATTACK2 then
					--block
				end
			end
		end
	end
end
hook.Add("KeyRelease", "melee.keyrelease", MeleeKeyRelease)



function SWEP:SecondaryAttack()
	if self.Owner:KeyDown(IN_ATTACK2) and self.CanBlock then
	local blocking  = self:GetNWBool(1)
	self.Weapon:SetNWBool(0, (not self.Weapon:GetNWBool(0)))
	self.Owner:EmitSound("npc/zombie/foot_slide"..math.random(1,3)..".wav",65,150)
	end
	self.Weapon:SetNextSecondaryFire(CurTime() + 0.1)
	return
end

function SWEP:PrimaryAttack()
	return -- does nothing for now, if I don't make this return it will click. 
end

--[[
--SWEP.AttackAnims = { "slash1", "slash2" }
SWEP.AttackAnims = {"1h_attack_right",}
function SWEP:PrimaryAttack()
	local wt = self.Weight
		dmgmult = 1
	--	print (self.Owner:GetVelocity() + self.Owner:GetForward( ))
	if !self.Owner:IsOnGround( ) then
		dmgmult2 = 2
	else
		dmgmult2 = 1
	end
	if self.Weapon:GetNWBool(1)	then return end
	
	delta = FrameTime( )
	local Stamina = self.Owner:GetDTFloat( 3 )
	local stamdrain = (Stamina - self.StaminaCost)
	local stamApproach = math.Approach( Stamina, stamdrain, 0.0001)
	if Stamina <= 0.2 then 
		self.Owner:EmitSound("player/suit_sprint.wav",60,100)
		return 
	end
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Owner:SetDTFloat(3,stamdrain)
	local delay = (wt * 0.002)
	-- We need this because attack sequences won't work otherwise in multiplayer
	if ( !SERVER ) then return end
	local vm = self.Owner:GetViewModel()
	vm:ResetSequence( vm:LookupSequence( "idle" ) )

	local anim = self.AttackAnims[ math.random( 1, #self.AttackAnims ) ]

	timer.Simple( 0, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
	
		local vm = self.Owner:GetViewModel()
		local sequence = vm:LookupSequence( anim )
		vm:ResetSequence(sequence )
		vm:SetPlaybackRate(4.0)
		self:Idle()
	end )

	timer.Simple( 0.05, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		if ( anim == "slash1" ) then
			self.Owner:ViewPunch( Angle( 0, 10, 5 ) )
		elseif ( anim == "slash2" ) then
			self.Owner:ViewPunch( Angle( 10, 0, 0 ) )
		end
	end )

	timer.Simple( 0.2, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		if ( anim == "slash1" ) then
			self.Owner:ViewPunch( Angle( 0, -5, 5 ) )
			direction = "right"
		elseif ( anim == "slash2" ) then
			direction = "down"
			self.Owner:ViewPunch( Angle( -5, 0, 0 ) )
		end
		self.Owner:EmitSound( self.SwingSound )
		
	end )

	timer.Simple( delay, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
--		self:DealDamage( anim )
		self:TraceDamage(direction, delay) 
	end )
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

end
]]
local tracedone = 0
function SWEP:TraceDamage(direction, delay)
	if SERVER then
	--	hitdistance = self.HitDistance
		local hitdistance = 50
		local sharpness = self.Sharpness
		local ply = self.Owner

		if direction == "down" or direction == "up" then -- uppercut/donward cutt
			dir = ply:GetUp()
		elseif direction == "left" or direction == "right" then -- slash
			dir = ply:GetRight()
		else
			dir = ply:GetForward() -- stab
		end
			
		traces = 7
		
		if direction == "left" or direction == "up" then
			traces1 = traces
			traces2 = -traces
		elseif direction == "right" then
			traces1 = -traces
			traces2 = traces
		else
			traces1 = -traces
			traces2 = traces
		end
		stopped = false
		nostop = true
		tracedone = 0
		local weptype = self.Type
		for k = -traces, traces do
			timer.Simple( k * delay, function()
				if not stopped then
				
					mult =  (dir * k * (hitdistance * 0.06))
					if k < 0 then
						distance = ply:GetForward() * k
					else
						distance = ply:GetForward() * -k
					end
					Diagnol = ply:GetUp() * k * 1
					if direction == "right" then
						finalmult = (dir + mult - Diagnol)
					elseif direction == "left" then
						finalmult = (dir - mult - Diagnol)
					else
						finalmult = (dir - mult)
					end
					
					local EyeTrace = util.TraceLine( {
							start = ply:GetShootPos() + (Vector(0,0,-15)),
							endpos = (ply:GetShootPos() + ply:GetAimVector() *  hitdistance + distance) + ply:GetUp() * -3 + finalmult,
							filter = ply
						} )
					if EyeTrace.HitWorld then
						stopped = true
					end	

		--Time for Effects!!!
						mat = EyeTrace.MatType
						if mat == METAL then
							decal = "Impact.Metal"
						elseif mat == SAND then
							decal = "Impact.Sand"
						elseif mat == ANTLION then
							decal = "Impact.Antlion"
						elseif mat == BLOODYFLESH then
							decal = "Impact.BloodyFlesh"
						elseif mat == DIRT then
							decal = "Impact.Sand"-- sand I guess..?
						elseif mat == FLESH then
							decal = "Impact.BloodyFlesh"
						elseif mat == GRATE then
							decal = "Impact.Metal"
						elseif mat == ALIENFLESH then
							decal = "Impact.Antlion"
						elseif mat == CLIP then
							decal = "Impact.Metal"
						elseif mat == PLASTIC then
							decal = "Impact.Concrete"
						elseif mat == FOLIAGE then
							decal = "Impact.Sand"
						elseif mat == COMPUTER then
							decal = "Impact.Metal"
						elseif mat == SLOSH then
							decal = "Impact.Sand"
						elseif mat == TILE then
							decal = "Impact.Metal"
						elseif mat == VENT then
							decal = "Impact.Metal"
						elseif mat == WOOD then
							decal = "Impact.Wood"
						elseif mat == GLASS then
							decal = "Impact.Glass"
						else
							decal = "Impact.Concrete"
						end

					tracedone = tracedone + 1
					if EyeTrace.Hit and nostop then
						local target = EyeTrace.Entity
						print(target)
						nostop = false
						local Pos1 = EyeTrace.HitPos + EyeTrace.HitNormal
						local Pos2 = EyeTrace.HitPos - EyeTrace.HitNormal
						util.Decal("ManhackCut", Pos1, Pos2)
				--		if self.Type == "Blunt" then
							stopped = true
							wt = (delay * 200) * 2
							damage =  (wt * tracedone)
							print(damage)
				--		end
					end
				end
			end)
		end
		tracedone = 0
	end
end


hook.Add("PostDrawOpaqueRenderables", "test", function()
    if 1 == 1 then return end
	hitdistance = 50
	ply = LocalPlayer()
	direction = ("right")
--	if ply:KeyDown(IN_ATTACK) then
		if direction == "down" or direction == "up" then -- uppercut/donward cutt
			dir = ply:GetUp()
		elseif direction == "left" or direction == "right" then -- slash
			dir = ply:GetRight()
		else
			dir = ply:GetForward() -- stab
		end
			
		traces = 7
		
		if direction == "left" or direction == "up" then
			traces1 = traces
			traces2 = -traces
		elseif direction == "right" then
			traces1 = -traces
			traces2 = traces
		else
			traces1 = -traces
			traces2 = traces
		end
		stopped = false
		for k = -traces, traces do
			if not stopped then
				mult =  (dir * k * (hitdistance * 0.07))
				if k < 0 then
					distance = ply:GetForward() * k
				else
					distance = ply:GetForward() * -k
				end
				Diagnol = ply:GetUp() * k * 1
				if direction == "right" then
					finalmult = (dir + mult - Diagnol)
				elseif direction == "left" then
					finalmult = (dir - mult - Diagnol)
				else
					finalmult = (dir - mult)
				end
				
				local EyeTrace = util.TraceLine( {
						start = ply:GetShootPos() + (Vector(0,0,-15)),
						endpos = (ply:GetShootPos() + ply:GetAimVector() *  hitdistance + distance) + (ply:GetUp() * -3) + finalmult,
						filter = ply
					} )
				if EyeTrace.HitWorld then
					stopped = true
				end
				tracedone = tracedone + 1
				render.DrawLine( EyeTrace.HitPos, EyeTrace.StartPos, Color(25 * tracedone * 0.5,0,255,255), true )
			end
		end
		stopped = false
		tracedone = 0
end)

function SWEP:Idle()
	local vm = self.Owner:GetViewModel()
	timer.Create( "idle" .. self:EntIndex(), vm:SequenceDuration(), 1, function()
		if self.AtkStance == "prep" then return end
		vm:SetPlaybackRate(1.0)
		vm:ResetSequence("idle" )
		self.AtkStance = "idle"
		
	end )
end

function SWEP:OnRemove()

	if ( IsValid( self.Owner ) ) then
		local vm = self.Owner:GetViewModel()
		if ( IsValid( vm ) ) then vm:SetMaterial( "" ) end
	end

	timer.Stop( "idle" .. self:EntIndex() )

end

function SWEP:Deploy()
	local vm = self.Owner:GetViewModel()
	vm:ResetSequence( vm:LookupSequence( "idle" ) )

	self:Idle()

	return true
end
--Hides the default machete..unless we're using the machete itself.
if SWEP.HideMachete then
	SWEP.ViewModelBoneMods = {
		["Box01"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
	}
end