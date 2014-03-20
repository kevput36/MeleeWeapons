AddCSLuaFile()
SWEP.Base = "bizz_melee_2_base"

SWEP.PrintName = "Machete"
SWEP.Author = "Bizzclaw"
SWEP.Contact = "N/A"
SWEP.Purpose = "Sharp Melee weapon."
SWEP.Spawnable = true
SWEP.Category = "Melee - Bizzclaw"

SWEP.ViewMovelFOV = 70

SWEP.WorldModel = "models/warz/melee/machete.mdl"
SWEP.ViewModel = "models/weapons/bizzclaw/c_bizz_melee_1handed.mdl" 
 
SWEP.AutoswitchTo = false
SWEP.AutoswitchFrom = false

SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.DrawCrosshair = false
SWEP.DrawAmmo = false

SWEP.HideMachete = false
SWEP.HitDistance = 65 -- blade length
--Weapon's reach
SWEP.DamageType = DMG_SLASH
--Damage type
--DMG_CLUB is for blunt weapons
--DMG_SLASH is for sharp weapons
SWEP.Primary.Damage		= 30

SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.SwingSound = { 
	"npc/fast_zombie/claw_miss"..math.random(1,2)..".wav",
{
SWEP.HitSound = Sound( "Flesh.ImpactHard" )

SWEP.RightPrepAnim = "1h_attackprep_right_idle"
SWEP.LeftPrepAnim = "1h_attackprep_left_idle"
SWEP.RightattackAnim = "1h_attack_right"
SWEP.LeftattackAnim = "1h_attack_right"

SWEP.VElements = {
	["v_machete"] = { type = "Model", model = "models/warz/melee/machete.mdl", bone = "ValveBiped.Bip01_R_Finger1", rel = "", pos = Vector(1.669, 0.643, -1.14), angle = Angle(-4.587, -29.555, 180), size = Vector(1.049, 1.049, 1.049), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
