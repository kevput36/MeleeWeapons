AddCSLuaFile()
SWEP.Base = "bizz_melee_base"

SWEP.PrintName = "Machete"
SWEP.Author = "Bizzclaw"
SWEP.Contact = "N/A"
SWEP.Purpose = "Sharp Melee weapon."
SWEP.Spawnable = true
SWEP.Category = "Melee - Bizzclaw"

SWEP.ViewMovelFOV = 70

SWEP.ViewModel = "models/weapons/a_machete.mdl"
SWEP.WorldModel = "models/weapons/b_machete.mdl"
 
SWEP.AutoswitchTo = false
SWEP.AutoswitchFrom = false

SWEP.Slot = 1
SWEP.SlotPos = 2

SWEP.DrawCrosshair = false
SWEP.DrawAmmo = false

SWEP.HideMachete = false
SWEP.HitDistance = 65
--Weapon's reach
SWEP.DamageType = DMG_SLASH
--Damage type
--DMG_CLUB is for blunt weapons
--DMG_SLASH is for sharp weapons
SWEP.Primary.Recoil		= 5
SWEP.Primary.Damage		= 30
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

SWEP.BlockPos = Vector(-7.008, -4.165, -7.277)
SWEP.BlockAng = Vector(25.243, 3.582, -37.757)


SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.SwingSound = Sound( "npc/fast_zombie/claw_miss"..math.random(1,2)..".wav" )
SWEP.HitSound = Sound( "Flesh.ImpactHard" )