--[[------------------------------------------------------------------
  CONFIGURATION
  Customization variables
]]--------------------------------------------------------------------

if SERVER then return end

local COLOR_DEFAULT       = Color(255, 200, 100);
local COLOR_CRIT          = Color(255, 0, 0);
local COLOR_QI1           = Color(255, 230, 70);
local COLOR_QI2           = Color(255, 48, 0);
local COLOR_SUITPOWER     = Color(255, 180, 90);
local COLOR_PICKUP        = Color(255, 215, 90);
local COLOR_FLASHLIGHT    = Color(220, 200, 0);

local cvarlist = {
  ["hl2rbhud_enable"]               = 1,
  ["hl2rbhud_scale"]                = 1,
  ["hl2rbhud_qi_scale"]             = 1,
  ["hl2rbhud_qi_mode"]              = 1,
  ["hl2rbhud_qi_invert"]            = 0,
  ["hl2rbhud_qi_zoom"]              = 1,
  ["hl2rbhud_qi_hide_vehicle"]      = 1,
  ["hl2rbhud_health"]               = 1,
  ["hl2rbhud_suit"]                 = 1,
  ["hl2rbhud_ammo"]                 = 1,
  ["hl2rbhud_quickinfo"]            = 1,
  ["hl2rbhud_pickup"]               = 1,
  ["hl2rbhud_pickup_scale"]         = 1,
  ["hl2rbhud_custom_icons"]         = 1,
  ["hl2rbhud_weapon"]               = 1,
  ["hl2rbhud_flashlight"]           = 0,
  ["hl2rbhud_no_suit"]              = 0,
  ["hl2rbhud_ammo_hide_vehicle"]    = 1,
  ["hl2rbhud_health_colour_r"]      = COLOR_DEFAULT.r,
  ["hl2rbhud_health_colour_g"]      = COLOR_DEFAULT.g,
  ["hl2rbhud_health_colour_b"]      = COLOR_DEFAULT.b,
  ["hl2rbhud_health_colour_a"]      = COLOR_DEFAULT.a,
  ["hl2rbhud_health_colour_low_r"]  = COLOR_CRIT.r,
  ["hl2rbhud_health_colour_low_g"]  = COLOR_CRIT.g,
  ["hl2rbhud_health_colour_low_b"]  = COLOR_CRIT.b,
  ["hl2rbhud_health_colour_low_a"]  = COLOR_CRIT.a,
  ["hl2rbhud_armour_colour_r"]      = COLOR_DEFAULT.r,
  ["hl2rbhud_armour_colour_g"]      = COLOR_DEFAULT.g,
  ["hl2rbhud_armour_colour_b"]      = COLOR_DEFAULT.b,
  ["hl2rbhud_armour_colour_a"]      = COLOR_DEFAULT.a,
  ["hl2rbhud_suit_colour_r"]        = COLOR_SUITPOWER.r,
  ["hl2rbhud_suit_colour_g"]        = COLOR_SUITPOWER.g,
  ["hl2rbhud_suit_colour_b"]        = COLOR_SUITPOWER.b,
  ["hl2rbhud_suit_colour_a"]        = COLOR_SUITPOWER.a,
  ["hl2rbhud_ammo_colour_r"]        = COLOR_DEFAULT.r,
  ["hl2rbhud_ammo_colour_g"]        = COLOR_DEFAULT.g,
  ["hl2rbhud_ammo_colour_b"]        = COLOR_DEFAULT.b,
  ["hl2rbhud_ammo_colour_a"]        = COLOR_DEFAULT.a,
  ["hl2rbhud_ammo_colour_low_r"]    = COLOR_CRIT.r,
  ["hl2rbhud_ammo_colour_low_g"]    = COLOR_CRIT.g,
  ["hl2rbhud_ammo_colour_low_b"]    = COLOR_CRIT.b,
  ["hl2rbhud_ammo_colour_low_a"]    = COLOR_CRIT.a,
  ["hl2rbhud_pickup_colour_r"]      = COLOR_PICKUP.r,
  ["hl2rbhud_pickup_colour_g"]      = COLOR_PICKUP.g,
  ["hl2rbhud_pickup_colour_b"]      = COLOR_PICKUP.b,
  ["hl2rbhud_pickup_colour_a"]      = COLOR_PICKUP.a,
  ["hl2rbhud_qi_h1_colour_r"]       = COLOR_QI1.r,
  ["hl2rbhud_qi_h1_colour_g"]       = COLOR_QI1.g,
  ["hl2rbhud_qi_h1_colour_b"]       = COLOR_QI1.b,
  ["hl2rbhud_qi_h1_colour_a"]       = COLOR_QI1.a,
  ["hl2rbhud_qi_h2_colour_r"]       = COLOR_QI2.r,
  ["hl2rbhud_qi_h2_colour_g"]       = COLOR_QI2.g,
  ["hl2rbhud_qi_h2_colour_b"]       = COLOR_QI2.b,
  ["hl2rbhud_qi_h2_colour_a"]       = COLOR_QI2.a,
  ["hl2rbhud_qi_a1_colour_r"]       = COLOR_QI1.r,
  ["hl2rbhud_qi_a1_colour_g"]       = COLOR_QI1.g,
  ["hl2rbhud_qi_a1_colour_b"]       = COLOR_QI1.b,
  ["hl2rbhud_qi_a1_colour_a"]       = COLOR_QI1.a,
  ["hl2rbhud_qi_a2_colour_r"]       = COLOR_QI2.r,
  ["hl2rbhud_qi_a2_colour_g"]       = COLOR_QI2.g,
  ["hl2rbhud_qi_a2_colour_b"]       = COLOR_QI2.b,
  ["hl2rbhud_qi_a2_colour_a"]       = COLOR_QI2.a,
  ["hl2rbhud_fl_colour_r"]          = COLOR_FLASHLIGHT.r,
  ["hl2rbhud_fl_colour_g"]          = COLOR_FLASHLIGHT.g,
  ["hl2rbhud_fl_colour_b"]          = COLOR_FLASHLIGHT.b,
  ["hl2rbhud_fl_colour_a"]          = COLOR_FLASHLIGHT.a,
  ["hl2rbhud_fl_background"]        = 100,
  ["hl2rbhud_fl_x"]                 = 55,
  ["hl2rbhud_fl_y"]                 = 163
}
local cvar = {}

-- [[ Generate convars ]] --
for name, value in pairs(cvarlist) do cvar[name] = CreateClientConVar(name, value, true) end

--[[------------------------------------------------------------------
  Whether the HUD is enabled
  @param {boolean} is enabled
]]--------------------------------------------------------------------
function HL2RBHUD:IsEnabled()
  return cvar.hl2rbhud_enable:GetBool();
end

--[[------------------------------------------------------------------
  Returns the HUD scale
  @return {number} scale
]]--------------------------------------------------------------------
function HL2RBHUD:GetScale()
  return cvar.hl2rbhud_scale:GetFloat() * 1.3;
end

--[[------------------------------------------------------------------
  Whether the health and armour elements are enabled
  @return {boolean} is enabled
]]--------------------------------------------------------------------
function HL2RBHUD:IsHealthEnabled()
  return cvar.hl2rbhud_health:GetBool();
end

--[[------------------------------------------------------------------
  Whether the auxiliary power elements are enabled
  @return {boolean} is enabled
]]--------------------------------------------------------------------
function HL2RBHUD:IsAuxPowerEnabled()
  return cvar.hl2rbhud_suit:GetBool();
end

--[[------------------------------------------------------------------
  Whether the ammunition indicator is enabled
  @return {boolean} is enabled
]]--------------------------------------------------------------------
function HL2RBHUD:IsAmmoEnabled()
  return cvar.hl2rbhud_ammo:GetBool();
end

--[[------------------------------------------------------------------
  Whether the quick info element is enabled
  @return {boolean} is enabled
]]--------------------------------------------------------------------
function HL2RBHUD:IsQuickInfoEnabled()
  return cvar.hl2rbhud_quickinfo:GetBool();
end

--[[------------------------------------------------------------------
  Whether the quick info is inverted
  @return {boolean} is inverted
]]--------------------------------------------------------------------
function HL2RBHUD:IsQuickInfoInverted()
  return cvar.hl2rbhud_qi_invert:GetBool();
end

--[[------------------------------------------------------------------
  Returns the quick info scale
  @return {number} scale
]]--------------------------------------------------------------------
function HL2RBHUD:GetQuickInfoScale()
  return cvar.hl2rbhud_qi_scale:GetFloat();
end

--[[------------------------------------------------------------------
  Returns the selected flashlight mode
  @return {number} flashlight mode
]]--------------------------------------------------------------------
function HL2RBHUD:GetFlashlightMode()
  return cvar.hl2rbhud_flashlight:GetInt();
end

--[[------------------------------------------------------------------
  Gets the flashlight x position
  @return {number} x
]]--------------------------------------------------------------------
function HL2RBHUD:GetFlashlightX()
  return cvar.hl2rbhud_fl_x:GetInt();
end

--[[------------------------------------------------------------------
  Gets the flashlight y position
  @return {number} y
]]--------------------------------------------------------------------
function HL2RBHUD:GetFlashlightY()
  return cvar.hl2rbhud_fl_y:GetInt();
end

--[[------------------------------------------------------------------
  Returns the selected quick info behaviour mode
  @return {number} quick info mode
]]--------------------------------------------------------------------
function HL2RBHUD:GetQuickInfoMode()
  return cvar.hl2rbhud_qi_mode:GetInt();
end

--[[------------------------------------------------------------------
  Whether pickup history is enabled
  @return {boolean} is enabled
]]--------------------------------------------------------------------
function HL2RBHUD:IsPickupHistoryEnabled()
  return cvar.hl2rbhud_pickup:GetBool();
end

--[[------------------------------------------------------------------
  Returns the pickup history relative scale
  @return {number} scale
]]--------------------------------------------------------------------
function HL2RBHUD:GetPickupHistoryScale()
  return cvar.hl2rbhud_pickup_scale:GetFloat();
end

--[[------------------------------------------------------------------
  Whether weapon pickup animation is enabled
  @return {boolean} is enabled
]]--------------------------------------------------------------------
function HL2RBHUD:IsWeaponPickupEnabled()
  return cvar.hl2rbhud_weapon:GetBool();
end

--[[------------------------------------------------------------------
  Whether the HUD should be drawn even without the suit
  @return {boolean} is shown without suit
]]--------------------------------------------------------------------
function HL2RBHUD:ShouldDrawWithNoSuit()
  return cvar.hl2rbhud_no_suit:GetBool();
end

--[[------------------------------------------------------------------
  Whether the weapon pickup animation should use custom icons
  @return {boolean} use custom icons
]]--------------------------------------------------------------------
function HL2RBHUD:ShouldUseCustomIcons()
  return cvar.hl2rbhud_custom_icons:GetBool();
end

--[[------------------------------------------------------------------
  Whether the quick info should be hid when using the suit zoom
  @return {boolean} should hide
]]--------------------------------------------------------------------
function HL2RBHUD:ShouldHideQuickInfoOnZoom()
  return cvar.hl2rbhud_qi_zoom:GetBool();
end

--[[------------------------------------------------------------------
  Whether the quick info should be hid when in a vehicle
  @return {boolean} should hide
]]--------------------------------------------------------------------
function HL2RBHUD:ShouldHideQuickInfoInVehicle()
  return cvar.hl2rbhud_qi_hide_vehicle:GetBool();
end

--[[------------------------------------------------------------------
  Whether the ammunition indicator should hide when in a vehicle
  @return {boolean} should hide
]]--------------------------------------------------------------------
function HL2RBHUD:ShouldHideAmmoInVehicle()
  return cvar.hl2rbhud_ammo_hide_vehicle:GetBool();
end

--[[------------------------------------------------------------------
  Gets the flashlight text colour
  @return {Color} colour
]]--------------------------------------------------------------------
local cache = Color(255, 255, 255, 255);
function HL2RBHUD:GetFlashlightColour()
  cache:SetUnpacked(cvar.hl2rbhud_fl_colour_r:GetInt(), cvar.hl2rbhud_fl_colour_g:GetInt(), cvar.hl2rbhud_fl_colour_b:GetInt(), cvar.hl2rbhud_fl_colour_a:GetInt());
  return cache;
end

--[[------------------------------------------------------------------
  Gets the flashlight background alpha
  @return {number} background opacity
]]--------------------------------------------------------------------
function HL2RBHUD:GetFlashlightBackground()
  return cvar.hl2rbhud_fl_background:GetInt();
end

--[[------------------------------------------------------------------
  Returns the health indicator colour
  @return {Color} colour
]]--------------------------------------------------------------------
local cache = Color(255, 255, 255, 255);
function HL2RBHUD:GetHealthColour()
  cache:SetUnpacked(cvar.hl2rbhud_health_colour_r:GetInt(), cvar.hl2rbhud_health_colour_g:GetInt(), cvar.hl2rbhud_health_colour_b:GetInt(), cvar.hl2rbhud_health_colour_a:GetInt());
  return cache;
end

--[[------------------------------------------------------------------
  Returns the health indicator colour on low health
  @return {Color} colour
]]--------------------------------------------------------------------
local cache = Color(255, 255, 255, 255);
function HL2RBHUD:GetHealthLowColour()
  cache:SetUnpacked(cvar.hl2rbhud_health_colour_low_r:GetInt(), cvar.hl2rbhud_health_colour_low_g:GetInt(), cvar.hl2rbhud_health_colour_low_b:GetInt(), cvar.hl2rbhud_health_colour_low_a:GetInt());
  return cache;
end

--[[------------------------------------------------------------------
  Returns the armour indicator colour
  @return {Color} colour
]]--------------------------------------------------------------------
local cache = Color(255, 255, 255, 255);
function HL2RBHUD:GetArmourColour()
  cache:SetUnpacked(cvar.hl2rbhud_armour_colour_r:GetInt(), cvar.hl2rbhud_armour_colour_g:GetInt(), cvar.hl2rbhud_armour_colour_b:GetInt(), cvar.hl2rbhud_armour_colour_a:GetInt());
  return cache;
end

--[[------------------------------------------------------------------
  Returns the ammunition indicator colour
  @return {Color} colour
]]--------------------------------------------------------------------
local cache = Color(255, 255, 255, 255);
function HL2RBHUD:GetAmmoColour()
  cache:SetUnpacked(cvar.hl2rbhud_ammo_colour_r:GetInt(), cvar.hl2rbhud_ammo_colour_g:GetInt(), cvar.hl2rbhud_ammo_colour_b:GetInt(), cvar.hl2rbhud_ammo_colour_a:GetInt());
  return cache;
end

--[[------------------------------------------------------------------
  Returns the ammunition indicator colour on low ammo
  @return {Color} colour
]]--------------------------------------------------------------------
local cache = Color(255, 255, 255, 255);
function HL2RBHUD:GetAmmoLowColour()
  cache:SetUnpacked(cvar.hl2rbhud_ammo_colour_low_r:GetInt(), cvar.hl2rbhud_ammo_colour_low_g:GetInt(), cvar.hl2rbhud_ammo_colour_low_b:GetInt(), cvar.hl2rbhud_ammo_colour_low_a:GetInt());
  return cache;
end

--[[------------------------------------------------------------------
  Returns the aux power indicator colour
  @return {Color} colour
]]--------------------------------------------------------------------
local cache = Color(255, 255, 255, 255);
function HL2RBHUD:GetAuxPowerColour()
  cache:SetUnpacked(cvar.hl2rbhud_suit_colour_r:GetInt(), cvar.hl2rbhud_suit_colour_g:GetInt(), cvar.hl2rbhud_suit_colour_b:GetInt(), cvar.hl2rbhud_suit_colour_a:GetInt());
  return cache;
end

--[[------------------------------------------------------------------
  Returns the pickup history colour
  @return {Color} colour
]]--------------------------------------------------------------------
local cache = Color(255, 255, 255, 255);
function HL2RBHUD:GetPickupHistoryColour()
  cache:SetUnpacked(cvar.hl2rbhud_pickup_colour_r:GetInt(), cvar.hl2rbhud_pickup_colour_g:GetInt(), cvar.hl2rbhud_pickup_colour_b:GetInt(), cvar.hl2rbhud_pickup_colour_a:GetInt());
  return cache;
end

--[[------------------------------------------------------------------
  Returns the health quick info bracket colour
  @return {Color} colour
]]--------------------------------------------------------------------
local cache = Color(255, 255, 255, 255);
function HL2RBHUD:GetQuickInfoHealthColour()
  cache:SetUnpacked(cvar.hl2rbhud_qi_h1_colour_r:GetInt(), cvar.hl2rbhud_qi_h1_colour_g:GetInt(), cvar.hl2rbhud_qi_h1_colour_b:GetInt(), cvar.hl2rbhud_qi_h1_colour_a:GetInt());
  return cache;
end

--[[------------------------------------------------------------------
  Returns the health quick info bracket colour on low health
  @return {Color} colour
]]--------------------------------------------------------------------
local cache = Color(255, 255, 255, 255);
function HL2RBHUD:GetQuickInfoHealthLowColour()
  cache:SetUnpacked(cvar.hl2rbhud_qi_h2_colour_r:GetInt(), cvar.hl2rbhud_qi_h2_colour_g:GetInt(), cvar.hl2rbhud_qi_h2_colour_b:GetInt(), cvar.hl2rbhud_qi_h2_colour_a:GetInt());
  return cache;
end

--[[------------------------------------------------------------------
  Returns the ammo quick info bracket colour
  @return {Color} colour
]]--------------------------------------------------------------------
local cache = Color(255, 255, 255, 255);
function HL2RBHUD:GetQuickInfoAmmoColour()
  cache:SetUnpacked(cvar.hl2rbhud_qi_a1_colour_r:GetInt(), cvar.hl2rbhud_qi_a1_colour_g:GetInt(), cvar.hl2rbhud_qi_a1_colour_b:GetInt(), cvar.hl2rbhud_qi_a1_colour_a:GetInt());
  return cache;
end

--[[------------------------------------------------------------------
  Returns the ammo quick info bracket colour on low ammo
  @return {Color} colour
]]--------------------------------------------------------------------
local cache = Color(255, 255, 255, 255);
function HL2RBHUD:GetQuickInfoAmmoLowColour()
  cache:SetUnpacked(cvar.hl2rbhud_qi_a2_colour_r:GetInt(), cvar.hl2rbhud_qi_a2_colour_g:GetInt(), cvar.hl2rbhud_qi_a2_colour_b:GetInt(), cvar.hl2rbhud_qi_a2_colour_a:GetInt());
  return cache;
end

HL2RBHUD.cvarlist = cvarlist
HL2RBHUD:IncludeFile("menu.lua");
