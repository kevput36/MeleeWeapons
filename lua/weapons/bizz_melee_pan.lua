AddCSLuaFile()
SWEP.Base = "bizz_melee_base"

SWEP.PrintName = "Lead Pipe"
SWEP.Author = "Bizzclaw"
SWEP.Contact = "N/A"
SWEP.Purpose = "Blunt Melee weapon."
SWEP.Spawnable = true
SWEP.Category = "Melee - Bizzclaw"

SWEP.ViewMovelFOV = 70

SWEP.ViewModel = "models/weapons/a_machete.mdl"
SWEP.WorldModel = "models/props_c17/metalpot002a.mdl"
 
SWEP.AutoswitchTo = false
SWEP.AutoswitchFrom = false

SWEP.Slot = 1
SWEP.SlotPos = 2

SWEP.DrawCrosshair = false
SWEP.DrawAmmo = false

SWEP.HitDistance = 60
--Weapon's reach
SWEP.DamageType = DMG_CLUB
--Damage type
--DMG_CLUB is for blunt weapons
--DMG_SLASH is for sharp weapons
SWEP.Primary.Recoil		= 5
SWEP.Primary.Damage		= 10
SWEP.Primary.NumShots		= 0
SWEP.Primary.Cone			= 0.075
SWEP.Primary.Delay 		= .7

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= 1					
SWEP.Primary.Automatic		= false				
SWEP.Primary.Ammo			= ""

SWEP.Secondary.ClipSize		= -1					
SWEP.Secondary.DefaultClip	= -1					
SWEP.Secondary.Automatic	= false				
SWEP.Secondary.Ammo		= "none"

SWEP.BlockPos = Vector(-7.008, -7.165, -5.277)
SWEP.BlockAng = Vector(32.243, 3.582, -37.757)


SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false

SWEP.SwingSound = Sound( "npc/fast_zombie/claw_miss"..math.random(1,2)..".wav" )
SWEP.HitSound = Sound( "Flesh.ImpactHard" )

SWEP.VElements = {
	["pan"] = { type = "Model", model = "models/props_c17/metalpot002a.mdl", bone = "Box01", rel = "", pos = Vector(-3.826, -0.941, 0.94), angle = Angle(180, 0, -5.597), size = Vector(0.772, 0.772, 0.772), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["pan"] = { type = "Model", model = "models/props_c17/metalpot002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.328, 1.939, -6.915), angle = Angle(-87.239, 69.66, -4.865), size = Vector(0.933, 0.933, 0.933), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}