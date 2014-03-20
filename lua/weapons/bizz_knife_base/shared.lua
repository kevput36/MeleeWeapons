AddCSLuaFile()
SWEP.Base = "bizz_melee_base"

SWEP.PrintName = "knifebase"
SWEP.Author = "Bizzclaw"
SWEP.Contact = "N/A"
SWEP.Purpose = "Sharp Melee weapon."
SWEP.Spawnable = false
SWEP.Category = "Melee - Bizzclaw"

SWEP.ViewMovelFOV = 70

SWEP.ViewModel = "models/weapons/a_machete.mdl"
SWEP.WorldModel = "models/props_junk/garbage_glassbottle003a_chunk01.mdl"
 
SWEP.AutoswitchTo = false
SWEP.AutoswitchFrom = false

SWEP.Slot = 2
SWEP.SlotPos = 2

SWEP.DrawCrosshair = false
SWEP.DrawAmmo = false

SWEP.HitDistance = 65
--Weapon's reach
SWEP.DamageType = DMG_SLASH
--Damage type
--DMG_CLUB is for blunt weapons
--DMG_SLASH is for sharp weapons
SWEP.Primary.Recoil		= 5
SWEP.Primary.Damage		= 0
SWEP.Primary.NumShots		= 0
SWEP.Primary.Cone			= 0.075
SWEP.Primary.Delay 		= 0.9

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= 1					
SWEP.Primary.Automatic		= false				
SWEP.Primary.Ammo			= ""

SWEP.Secondary.ClipSize		= -1					
SWEP.Secondary.DefaultClip	= -1					
SWEP.Secondary.Automatic	= false				
SWEP.Secondary.Ammo		= "none"
SWEP.Holdtype = "knife"

SWEP.BlockPos = Vector(-7.008, -7.165, -5.277)
SWEP.BlockAng = Vector(32.243, 3.582, -37.757)


SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.SwingSound = Sound( "npc/fast_zombie/claw_miss"..math.random(1,2)..".wav" )
SWEP.HitSound = Sound( "Flesh.ImpactHard" )
SWEP.CanBlock = false

function SWEP:Think()
	if !self.CanBlock then
		return
	end
	local blocking  = self.Owner:KeyDown(IN_ATTACK2) and Stamina > 0.2

	if blocking then
			self:SetWeaponHoldType( "slam" ) -- blocking holdtype
		else
			self:SetWeaponHoldType( self.Holdtype )
		end
	local Stamina = self.Owner:GetDTFloat( 3 )
	
	if blocking then
--			self.Owner:SetNWString("blocking", true)
		self:SetNWBool(1,true)
		timer.Create("delay_"..self.Owner:SteamID().."_test1",0.07, 1,  function() return end)
	elseif (!self.Owner:KeyDown(IN_ATTACK2) and !timer.Exists("delay_"..self.Owner:SteamID().."_test1")) or Stamina < 0.2  then
		self:SetNWBool(1,false)
--			self.Owner:SetNWString("blocking", false)
	else
		return 
	end
end


function SWEP:EntsInSphereBack(pos, range)

	local ents = ents.FindInSphere(pos, range)

	for k, v in pairs(ents) do
		if v ~= self and v ~= self.Owner and (v:IsNPC() or v:IsPlayer()) and IsValid(v) and self:EntityFaceBack(v) then
			return true
		end
	end

	return false
end


SWEP.AttackAnims = { "slash1","slash2" }
function SWEP:PrimaryAttack()
	dmgmult = 1
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	
	if ( !SERVER ) then return end

	-- We need this because attack sequences won't work otherwise in multiplayer
	local vm = self.Owner:GetViewModel()
	vm:ResetSequence( vm:LookupSequence( "idle") )

	local anim = self.AttackAnims[ math.random( 1, #self.AttackAnims ) ]

	timer.Simple( 0, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
	
		local vm = self.Owner:GetViewModel()
		vm:ResetSequence( vm:LookupSequence( anim ) )

		self:Idle()
	end )

	timer.Simple( 0.05, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		if ( anim == "slash1" ) then
			self.Owner:ViewPunch( Angle( 0, 2, 1 ) )
		elseif ( anim == "slash" ) then
			self.Owner:ViewPunch( Angle( 0, 2, 1 ) )
		elseif ( anim == "slash2" ) then
			self.Owner:ViewPunch( Angle( 2, 0, 0 ) )
		elseif ( anim == "stab" ) then
			self.Owner:ViewPunch( Angle( 0, 0, 1 ) )
		end
	end )

	timer.Simple( 0.2, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		if ( anim == "slash1" ) then
			self.Owner:ViewPunch( Angle( 0, -1, 5 ) )
		elseif ( anim == "slash2" ) then
			self.Owner:ViewPunch( Angle( -1, 0, 0 ) )
		elseif ( anim == "stab" ) then
			self.Owner:ViewPunch( Angle( 0, 0, 1 ) )
		end
		self.Owner:EmitSound( self.SwingSound )
		
	end )

	timer.Simple( 0.2, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		self:DealDamage( anim )
	end )

	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )

end

function SWEP:SecondaryAttack()
	dmgmult = 1.6
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	if ( !SERVER ) then return end

	-- We need this because attack sequences won't work otherwise in multiplayer
	local vm = self.Owner:GetViewModel()
	vm:ResetSequence( vm:LookupSequence( "idle" ) )

	local anim = "stab"

	timer.Simple( 0, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
	
		local vm = self.Owner:GetViewModel()
		vm:ResetSequence( vm:LookupSequence( anim ) )

		self:Idle()
	end )

	timer.Simple( 0.05, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		if ( anim == "slash1" ) then
			self.Owner:ViewPunch( Angle( 0, 2, 1 ) )
		elseif ( anim == "slash" ) then
			self.Owner:ViewPunch( Angle( 0, 2, 1 ) )
		elseif ( anim == "slash2" ) then
			self.Owner:ViewPunch( Angle( 2, 0, 0 ) )
		elseif ( anim == "stab" ) then
			self.Owner:ViewPunch( Angle( 0, 0, 1 ) )
		end
	end )

	timer.Simple( 0.2, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		if ( anim == "slash1" ) then
			self.Owner:ViewPunch( Angle( 0, -1, 5 ) )
		elseif ( anim == "slash2" ) then
			self.Owner:ViewPunch( Angle( -1, 0, 0 ) )
		elseif ( anim == "stab" ) then
			self.Owner:ViewPunch( Angle( 0, 0, 1 ) )
		end
		self.Owner:EmitSound( self.SwingSound )
		
	end )

	timer.Simple( 0.2, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		self:DealDamage( anim )
	end )

	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay + 0.3 )
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay + 0.4 )

end
--[[
function SWEP:DealDamage( anim )
	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
		filter = self.Owner
	} )

	if ( !IsValid( tr.Entity ) ) then 
		tr = util.TraceHull( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
			filter = self.Owner,
			mins = self.Owner:OBBMins() / 3,
			maxs = self.Owner:OBBMaxs() / 3
		} )
	end

	if ( tr.Hit ) then self.Owner:EmitSound( self.HitSound ) end

	if  IsValid( tr.Entity ) then
		if gamemode.Get("postnukerp") then
			strength = self.Owner:GetSkill("Backpacking")
		else
			strength = 0
		end
		
		local dmginfo = DamageInfo() 
		
		dmginfo:SetDamageType( self.DamageType )
		if ( anim == "slash1" ) then
			if tr.Entity:IsNPC() or tr.Entity:IsPlayer() or tr.Entity:GetClass() =="npc_feralghouls" then	
				dmginfo:SetDamageForce( self.Owner:GetRight() * 49125 + self.Owner:GetForward() * 99984 ) -- Yes we need those specific numbers
			end
		elseif ( anim == "stab" ) then
					if !self.Owner:IsPlayer() then
				attackerangle = self.Owner:GetAngles().y
			else
				attackerangle = self.Owner:EyeAngles().y
			end
		
		local angle = attackerangle - tr.Entity:GetAngles().y
		if angle < -180 then 
			angle = 360 +angle 
		end
		if angle <= 90 and angle >= -90 then 
		--	print ("Backstab!")
			dmgmult = 5
			tr.Entity:EmitSound("weapons/knife/knife_stab.wav")
		end
		if tr.Entity:IsNPC() or tr.Entity:IsPlayer() or tr.Entity:GetClass() =="npc_feralghouls" then	
			dmginfo:SetDamageForce( self.Owner:GetUp() * 51589 + self.Owner:GetForward() * 100128 )
		end
		elseif ( anim == "slash" ) then
			if tr.Entity:IsNPC() or tr.Entity:IsPlayer() or tr.Entity:GetClass() =="npc_feralghouls" then	
				dmginfo:SetDamageForce( self.Owner:GetUp() * 51589 + self.Owner:GetForward() * 100128 )
			end
		elseif ( anim == "slash2" ) then
			if tr.Entity:IsNPC() or tr.Entity:IsPlayer() or tr.Entity:GetClass() =="npc_feralghouls" then	
				dmginfo:SetDamageForce( self.Owner:GetUp() * 51589 + self.Owner:GetForward() * 100128 )
			end
		end
		dmginfo:SetInflictor( self )
		local attacker = self.Owner
		if ( !IsValid( attacker ) ) then attacker = self end
		dmginfo:SetAttacker( attacker )
		dmginfo:SetDamage( (self.Primary.Damage + (strength * 0.5 )) * dmgmult)
		tr.Entity:TakeDamageInfo( dmginfo )
	end
end
]]