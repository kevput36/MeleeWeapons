AddCSLuaFile()
SWEP.Base = "bizz_melee_base"

SWEP.PrintName = "Shovel"
SWEP.Author = "Bizzclaw"
SWEP.Contact = "N/A"
SWEP.Purpose = "Blunt Melee weapon."
SWEP.Spawnable = true
SWEP.Category = "Melee - Bizzclaw"

SWEP.ViewMovelFOV = 70

SWEP.ViewModel = "models/weapons/a_machete.mdl"
SWEP.WorldModel = "models/props_junk/shovel01a.mdl"
 
SWEP.AutoswitchTo = false
SWEP.AutoswitchFrom = false

SWEP.Slot = 1
SWEP.SlotPos = 2

SWEP.DrawCrosshair = false
SWEP.DrawAmmo = false

SWEP.HitDistance = 90
--Weapon's reach
SWEP.DamageType = DMG_CLUB
--Damage type
--DMG_CLUB is for blunt weapons
--DMG_SLASH is for sharp weapons
SWEP.Primary.Recoil		= 5
SWEP.Primary.Damage		= 20
SWEP.Primary.NumShots		= 0
SWEP.Primary.Cone			= 0.075
SWEP.Primary.Delay 		= 1.6

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

SWEP.SwingSound = Sound( "npc/zombie/claw_miss"..math.random(1,2)..".wav" )
SWEP.HitSound = Sound( "Flesh.ImpactHard" )

SWEP.VElements = {
	["veiw_shovel"] = { type = "Model", model = "models/props_junk/shovel01a.mdl", bone = "Box01", rel = "", pos = Vector(-1.9, 0.12,0, 0), angle = Angle(0, 86.935, 90), size = Vector(0.469, 0.469, 0.469), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["World_shovel"] = { type = "Model", model = "models/props_junk/shovel01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 1.279, -12.453), angle = Angle(-8, -180, 0), size = Vector(0.98, 0.8, 0.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}