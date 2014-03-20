AddCSLuaFile()
SWEP.Base = "bizz_knife_base"

SWEP.PrintName = "DV-2"
SWEP.Author = "Bizzclaw(derped)"
SWEP.Contact = "N/A"
SWEP.Purpose = "Sharp Melee weapon."
SWEP.Spawnable = true
SWEP.Category = "Melee - Bizzclaw"

SWEP.ViewMovelFOV = 70

SWEP.ViewModel = "models/weapons/a_dv2.mdl"
SWEP.WorldModel = "models/weapons/b_dv2.mdl"
 
SWEP.AutoswitchTo = false
SWEP.AutoswitchFrom = false

SWEP.Slot = 1
SWEP.SlotPos = 3

SWEP.DrawCrosshair = false
SWEP.DrawAmmo = false

SWEP.HitDistance = 43
--Weapon's reach
SWEP.DamageType = DMG_SLASH
--Damage type
--DMG_CLUB is for blunt weapons
--DMG_SLASH is for sharp weapons
SWEP.Primary.Recoil		= 5
SWEP.Primary.Damage		= 20
SWEP.Primary.NumShots		= 0
SWEP.Primary.Cone			= 0.075
SWEP.Primary.Delay 		= 0.2

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

SWEP.HideMachete = false

SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false

SWEP.SwingSound = Sound( "weapons/knife/knife_slash"..math.random(1,2)..".wav" )
SWEP.HitSound = Sound( "physics/flesh/flesh_impact_bullet1.wav" )