--[[------------------------------------------------------------------
  WEAPON ICONS
  Default HL2 weapon icons
]]--------------------------------------------------------------------

if CLIENT then

    local WEAPON_FONT = "hl2rbhud_weapon_icon";
    local BRIGHT = "_b";
    local W, H = 125, 90;
    local scale = 1.5;
    local W_ICONS1b = {texture = surface.GetTextureID("hl2rbhud/w_icons1b"), w = 256, h = 256};
    local W_ICONS2 = {texture = surface.GetTextureID("hl2rbhud/w_icons2"), w = 256, h = 256};
    local W_ICONS2b = {texture = surface.GetTextureID("hl2rbhud/w_icons2b"), w = 256, h = 256};
    local W_ICONS3b = {texture = surface.GetTextureID("hl2rbhud/w_icons3b"), w = 256, h = 256};

    -- Create fonts
    surface.CreateFont(WEAPON_FONT, {
      font = "HalfLife2",
      weight = 500,
      antialias = true,
      additive = true,
      size = HL2RBHUD:GetScreenScale() * 126
    });

    surface.CreateFont(WEAPON_FONT .. BRIGHT, {
      font = "HalfLife2",
      weight = 500,
      antialias = true,
      additive = true,
      blursize = 11,
    	scanlines = 4,
      size = HL2RBHUD:GetScreenScale() * 126
    });

    -- Create function
    local function DrawHL2WeaponIcon(x, y, char, alpha)
      x = x + (W * HL2RBHUD:GetScreenScale());
      y = y + (H * HL2RBHUD:GetScreenScale());
      draw.SimpleText(char, WEAPON_FONT .. BRIGHT, x, y, HL2RBHUD.WEAPON_COLOUR, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
      draw.SimpleText(char, WEAPON_FONT, x, y, HL2RBHUD.WEAPON_COLOUR, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
    end

    -- HL2 weapon characters
    local HL2 = {
      ["weapon_crowbar"] = "c",
      ["weapon_pistol"] = "d",
      ["weapon_357"] = "e",
      ["weapon_smg1"] = "a",
      ["weapon_ar2"] = "l",
      ["weapon_shotgun"] = "b",
      ["weapon_crossbow"] = "g",
      ["weapon_rpg"] = "i",
      ["weapon_frag"] = "k",
      ["weapon_slam"] = "o",
      ["weapon_stunstick"] = "n",
      ["weapon_bugbait"] = "j",
      ["weapon_physcannon"] = "m",
      ["weapon_physgun"] = "h"
    };

    -- Add default Half-Life 2 weapons
    for class, icon in pairs(HL2) do
      HL2RBHUD:AddWeaponIcon(class, function(x, y) DrawHL2WeaponIcon(x, y, icon); end);
    end

    -- Add annabelle
    HL2RBHUD:AddSprite("ANNABELLE_ICON", W_ICONS2, 0, 128, 128, 64);
    HL2RBHUD:AddWeaponSprite("ANNABELLE_ICON", "weapon_annabelle");

    -- Add HL2 beta weapon sprites
    HL2RBHUD:AddSprite("MTB_PISTOL", W_ICONS1b, 128, 0, 128, 64);
    HL2RBHUD:AddSprite("MTB_SMG1", W_ICONS1b, 128, 192, 128, 64);
    HL2RBHUD:AddSprite("MTB_SMG2", W_ICONS1b, 128, 128, 128, 64);
    HL2RBHUD:AddSprite("MTB_AR1", W_ICONS2b, 0, 0, 128, 64);
    HL2RBHUD:AddSprite("MTB_AR2", W_ICONS2b, 0, 64, 128, 64);
    HL2RBHUD:AddSprite("MTB_SHOTGUN", W_ICONS2b, 0, 128, 128, 64);
    HL2RBHUD:AddSprite("MTB_TAU", W_ICONS3b, 0, 0, 128, 64);
    HL2RBHUD:AddSprite("MTB_SNIPER", W_ICONS2, 0, 192, 128, 64);

    -- Add HL2 beta weapon icons
    HL2RBHUD:AddWeaponSprite("MTB_PISTOL", "tfa_hl2b_pistol", nil, scale);
    HL2RBHUD:AddWeaponSprite("MTB_SMG1", "tfa_hl2b_smg1", nil, scale);
    HL2RBHUD:AddWeaponSprite("MTB_SMG2", "tfa_hl2b_smg2", nil, scale);
    HL2RBHUD:AddWeaponSprite("MTB_AR1", "tfa_hl2b_ar1", nil, scale);
    HL2RBHUD:AddWeaponSprite("MTB_AR2", "tfa_hl2b_ar2", nil, scale);
    HL2RBHUD:AddWeaponSprite("MTB_SHOTGUN", "tfa_hl2b_shotgun", nil, scale);
    HL2RBHUD:AddWeaponSprite("MTB_TAU", "tfa_hl2b_taucannon", nil, scale);
    HL2RBHUD:AddWeaponSprite("MTB_SNIPER", "tfa_hl2b_sniperrifle", nil, scale);

end
