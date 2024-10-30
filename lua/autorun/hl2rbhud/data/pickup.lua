--[[------------------------------------------------------------------
  PICKUP ICONS
  Default HL2 ammunition and item icons
]]--------------------------------------------------------------------

if CLIENT then

  local TEXTURE = surface.GetTextureID("hl2rbhud/a_icons1");
  local DATA = {texture = TEXTURE, w = 256, h = 256};

  -- Add sprites
  HL2RBHUD:AddSprite("ammo_rpg", DATA, 2, 3, 124, 24);
  HL2RBHUD:AddSprite("ammo_sniper", DATA, 59, 32, 67, 12);
  HL2RBHUD:AddSprite("ammo_ar2", DATA, 74, 47, 52, 10);
  HL2RBHUD:AddSprite("ammo_smg1", DATA, 87, 63, 39, 10);
  HL2RBHUD:AddSprite("ammo_pistol", DATA, 103, 79, 23, 9);
  HL2RBHUD:AddSprite("ammo_buckshot", DATA, 90, 93, 36, 13);
  HL2RBHUD:AddSprite("ammo_smg1_grenade", DATA, 93, 112, 33, 16);
  HL2RBHUD:AddSprite("ammo_flare", DATA, 92, 132, 34, 17);
  HL2RBHUD:AddSprite("ammo_energy", DATA, 29, 93, 23, 23);
  HL2RBHUD:AddSprite("ammo_slam", DATA, 154, 112, 37, 32);
  HL2RBHUD:AddSprite("ammo_grenade", DATA, 153, 42, 42, 32);
  HL2RBHUD:AddSprite("ammo_bolt", DATA, 45, 199, 82, 5);
  HL2RBHUD:AddSprite("ammo_357", DATA, 98, 157, 28, 10);
  HL2RBHUD:AddSprite("item_healthkit", DATA, 35, 31, 19, 19);
  HL2RBHUD:AddSprite("item_battery", DATA, 35, 62, 19, 19);

  -- Link to ammo types
  HL2RBHUD:AddAmmoIcon("ammo_rpg", "RPG_Round");
  HL2RBHUD:AddAmmoIcon("ammo_ar2", "AR2");
  HL2RBHUD:AddAmmoIcon("ammo_smg1", "SMG1");
  HL2RBHUD:AddAmmoIcon("ammo_357", "357");
  HL2RBHUD:AddAmmoIcon("ammo_pistol", "Pistol");
  HL2RBHUD:AddAmmoIcon("ammo_buckshot", "Buckshot");
  HL2RBHUD:AddAmmoIcon("ammo_smg1_grenade", "SMG1_Grenade");
  HL2RBHUD:AddAmmoIcon("ammo_grenade", "Grenade");
  HL2RBHUD:AddAmmoIcon("ammo_sniper", "SniperPenetratedRound");
  HL2RBHUD:AddAmmoIcon("ammo_energy", "AR2AltFire");
  HL2RBHUD:AddAmmoIcon("ammo_bolt", "XBowBolt");
  HL2RBHUD:AddAmmoIcon("ammo_slam", "slam");

  -- Add items
  HL2RBHUD:AddItemIcon("item_healthkit", "item_healthkit");
  HL2RBHUD:AddItemIcon("item_battery", "item_battery");
  HL2RBHUD:AddItemOverride("item_healthvial");
  HL2RBHUD:AddItemOverride("item_grubnugget");

end
