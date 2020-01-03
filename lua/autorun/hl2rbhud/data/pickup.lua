--[[------------------------------------------------------------------
  PICKUP ICONS
  Default HL2 ammunition and item icons
]]--------------------------------------------------------------------

if CLIENT then

  local TEXTURE = surface.GetTextureID("hl2rbhud/a_icons1");
  local DATA = {texture = TEXTURE, w = 256, h = 256};

  -- Add sprites
  HL2RBHUD:AddSprite("RPGAMMO", DATA, 2, 3, 124, 24);
  HL2RBHUD:AddSprite("SNIPERAMMO", DATA, 59, 32, 67, 12);
  HL2RBHUD:AddSprite("ARAMMO", DATA, 74, 47, 52, 10);
  HL2RBHUD:AddSprite("SMGAMMO", DATA, 87, 63, 39, 10);
  HL2RBHUD:AddSprite("PISTOLAMMO", DATA, 103, 79, 23, 9);
  HL2RBHUD:AddSprite("BUCKSHOT", DATA, 90, 93, 36, 13);
  HL2RBHUD:AddSprite("SMGGRENADE", DATA, 93, 112, 33, 16);
  HL2RBHUD:AddSprite("FLARE", DATA, 92, 132, 34, 17);
  HL2RBHUD:AddSprite("ENERGYAMMO", DATA, 29, 93, 23, 23);
  HL2RBHUD:AddSprite("SLAM", DATA, 80, 158, 46, 29);
  HL2RBHUD:AddSprite("GRENADE", DATA, 94, 198, 32, 33);
  HL2RBHUD:AddSprite("XBOWBOLT", DATA, 136, 13, 78, 3);
  HL2RBHUD:AddSprite("357AMMO", DATA, 136, 32, 27, 12);
  HL2RBHUD:AddSprite("HEALTHKIT", DATA, 35, 31, 19, 19);
  HL2RBHUD:AddSprite("BATTERY", DATA, 35, 62, 19, 19);

  -- Link to ammo types
  HL2RBHUD:AddAmmoIcon("RPGAMMO", "RPG_Round");
  HL2RBHUD:AddAmmoIcon("ARAMMO", "AR2");
  HL2RBHUD:AddAmmoIcon("SMGAMMO", "SMG1");
  HL2RBHUD:AddAmmoIcon("357AMMO", "357");
  HL2RBHUD:AddAmmoIcon("PISTOLAMMO", "Pistol");
  HL2RBHUD:AddAmmoIcon("BUCKSHOT", "Buckshot");
  HL2RBHUD:AddAmmoIcon("SMGGRENADE", "SMG1_Grenade");
  HL2RBHUD:AddAmmoIcon("GRENADE", "Grenade");
  HL2RBHUD:AddAmmoIcon("SNIPERAMMO", "SniperPenetratedRound");
  HL2RBHUD:AddAmmoIcon("ENERGYAMMO", "AR2AltFire");
  HL2RBHUD:AddAmmoIcon("XBOWBOLT", "XBowBolt");
  HL2RBHUD:AddAmmoIcon("SLAM", "slam");

  -- Add items
  HL2RBHUD:AddItemIcon("HEALTHKIT", "item_healthkit");
  HL2RBHUD:AddItemIcon("BATTERY", "item_battery");
  HL2RBHUD:AddItemOverride("item_healthvial");
  HL2RBHUD:AddItemOverride("item_grubnugget");

end
