AddCSLuaFile()

SWEP.Base = "bizz_melee_base"

SWEP.PrintName = "Crowbar"
SWEP.Author = "Bizzclaw"
SWEP.Contact = "N/A"
SWEP.Purpose = "Blunt Melee weapon."
SWEP.Spawnable = true
SWEP.Category = "Melee - Bizzclaw"

SWEP.ViewMovelFOV = 60

SWEP.ViewModel = "models/weapons/c_bizz_melee_1ht.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
 
SWEP.AutoswitchTo = false
SWEP.AutoswitchFrom = false

SWEP.Slot = 1
SWEP.SlotPos = 2

SWEP.DrawCrosshair = false
SWEP.DrawAmmo = false

SWEP.HitDistance = 65
--Weapon's reach
SWEP.DamageType = DMG_CLUB
--Damagetype

SWEP.AttackAnims = {"1h_attack_right",}
SWEP.Primary.Recoil		= 5
SWEP.Primary.Damage		= 25
SWEP.Primary.NumShots		= 0
SWEP.Primary.Cone			= 0.075
SWEP.Primary.Delay 		= 1.2

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

--SWEP.SwingSound = Sound( "weapons/iceaxe/iceaxe_swing1.wav" )
SWEP.SwingSound = {
	"npc/zombie/claw_miss1.wav",
	"npc/zombie/claw_miss2.wav",
}
SWEP.HitSound = Sound( "Flesh.ImpactHard" )

SWEP.VElements = {
	["v_machete"] = { type = "Model", model = "models/warz/melee/machete.mdl", bone = "ValveBiped.Bip01_R_Finger1", rel = "", pos = Vector(1.669, 0.643, -1.14), angle = Angle(-4.587, -29.555, 180), size = Vector(1.049, 1.049, 1.049), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_Spine4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, -3.225), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, -4.183), angle = Angle(0, 0, 0) }
}



SWEP.WElements = {
	["world_crowbar"] = { type = "Model", model = "models/weapons/w_crowbar.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.736, 1.157, -4.171), angle = Angle(84.886, -180, -46.023), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}