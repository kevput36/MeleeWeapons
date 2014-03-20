AddCSLuaFile()
SWEP.Base = "bizz_knife_base"

SWEP.PrintName = "Broken Bottle Shank"
SWEP.Author = "Bizzclaw"
SWEP.Contact = "N/A"
SWEP.Purpose = "Sharp Melee weapon."
SWEP.Spawnable = true
SWEP.Category = "Melee - Bizzclaw"

SWEP.ViewMovelFOV = 100

SWEP.ViewModel = "models/weapons/a_kabar.mdl"
SWEP.WorldModel = "models/props_junk/garbage_glassbottle003a_chunk01.mdl"
 
SWEP.AutoswitchTo = false
SWEP.AutoswitchFrom = false

SWEP.Slot = 1
SWEP.SlotPos = 2

SWEP.DrawCrosshair = false
SWEP.DrawAmmo = false

SWEP.HitDistance = 43
--Weapon's reach
SWEP.DamageType = DMG_SLASH
--Damage type
--DMG_CLUB is for blunt weapons
--DMG_SLASH is for sharp weapons
SWEP.Primary.Recoil		= 5
SWEP.Primary.Damage		= 15
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

SWEP.ViewModelFlip = true
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false

SWEP.SwingSound = Sound( "weapons/knife/knife_slash"..math.random(1,2)..".wav" )
SWEP.HitSound = Sound( "physics/flesh/flesh_impact_bullet1.wav" )

SWEP.AttackAnims = {"slash", "slash"}

SWEP.VElements = {
	["v_bottle"] = { type = "Model", model = "models/props_junk/garbage_glassbottle003a_chunk01.mdl", bone = "Cylinder01", rel = "", pos = Vector(0, 0, -1.794), angle = Angle(0, 340, 0), size = Vector(0.693, 0.693, 0.693), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["w_bottle"] = { type = "Model", model = "models/props_junk/garbage_glassbottle003a_chunk01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.782, .5, -6.431), angle = Angle(-5, -90, 0.347), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


SWEP.ViewModelBoneMods = {
	["Cylinder01"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}