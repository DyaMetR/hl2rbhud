--[[------------------------------------------------------------------
  CORE
  The core file of the HUD, where the other files are included and the
  default HUD is hid
]]--------------------------------------------------------------------

HL2RBHUD:IncludeFile("config/config.lua");
HL2RBHUD:IncludeFile("util/sprites.lua");
HL2RBHUD:IncludeFile("util/numericdisplay.lua");
HL2RBHUD:IncludeFile("util/highlight.lua");
HL2RBHUD:IncludeFile("util/intersect.lua");
HL2RBHUD:IncludeFile("elements/health.lua");
HL2RBHUD:IncludeFile("elements/armour.lua");
HL2RBHUD:IncludeFile("elements/ammo.lua");
HL2RBHUD:IncludeFile("elements/auxpower.lua");
HL2RBHUD:IncludeFile("elements/quickinfo.lua");
HL2RBHUD:IncludeFile("elements/icons.lua");
HL2RBHUD:IncludeFile("elements/pickup.lua");
HL2RBHUD:IncludeFile("data/pickup.lua");
HL2RBHUD:IncludeFile("data/weapons.lua");

-- Load add-ons
local files, directories = file.Find("autorun/hl2rbhud/add-ons/*.lua", "LUA");
for _, file in pairs(files) do
  HL2RBHUD:IncludeFile("add-ons/"..file);
end

if CLIENT then

  -- White colour
  HL2RBHUD.WHITE = Color(255, 255, 255, 255);

  -- Load presets
  HL2RBHUD:CachePresets();

  -- Draw the HUD
  hook.Add("HUDPaint", "hl2rbhud_draw", function()
    if (not HL2RBHUD:IsEnabled() or
        not LocalPlayer():Alive() or
        (not LocalPlayer():IsSuitEquipped() and not HL2RBHUD:ShouldDrawWithNoSuit())
    ) then return end
    local scale = HL2RBHUD:GetScale();
    HL2RBHUD:DrawHealth(47, ScrH() - 15, scale);
    HL2RBHUD:DrawArmour(47 + math.Round(102 * scale), ScrH() - 15, scale);
    HL2RBHUD:DrawAmmo(ScrW() - 25, ScrH() - 15, LocalPlayer():GetActiveWeapon(), scale);
    HL2RBHUD:DrawAuxPower(47 + (198 * scale), ScrH() - 15 - (26 * scale), scale);
    HL2RBHUD:DrawQuickInfo(HL2RBHUD:GetQuickInfoScale());
    HL2RBHUD:DrawPickupHistory(ScrW() - (37 * scale * HL2RBHUD:GetPickupHistoryScale()), ScrH() - 83 - (50 * scale), scale);
  end);

  -- Hide HUD
  local hide = {
    CHudHealth = true,
    CHudBattery = true,
    CHudAmmo = true,
    CHudSecondaryAmmo = true,
    CHudSuitPower = true,
    CHudQuickInfo = true
  };
  hook.Add("HUDShouldDraw", "hl2rbhud_hide", function(name)
    if (not HL2RBHUD:IsEnabled()) then return end
    hide.CHudHealth = HL2RBHUD:IsHealthEnabled();
    hide.CHudBattery = HL2RBHUD:IsHealthEnabled();
    hide.CHudAmmo = HL2RBHUD:IsAmmoEnabled();
    hide.CHudSecondaryAmmo = HL2RBHUD:IsAmmoEnabled();
    hide.CHudSuitPower = HL2RBHUD:IsAuxPowerEnabled();
    hide.CHudQuickInfo = HL2RBHUD:IsQuickInfoEnabled();
    if (hide[name]) then return false; end
  end);

end
