--[[------------------------------------------------------------------
  ICONS
  Ammunition and weapon icons
]]--------------------------------------------------------------------

if CLIENT then

  local STRING_TYPE = "table";

  HL2RBHUD.WeaponIcons = {}; -- weapon icons
  HL2RBHUD.AmmoIcons = {}; -- ammunition icons
  HL2RBHUD.ItemIcons = {}; -- item icons
  HL2RBHUD.ItemOverride = {}; -- items that should not be drawn

  --[[------------------------------------------------------------------
    Adds an ammo icon
    @param {string} sprite
    @param {string} ammunition type
  ]]--------------------------------------------------------------------
  function HL2RBHUD:AddAmmoIcon(sprite, ammoType)
    HL2RBHUD.AmmoIcons[ammoType] = sprite;
  end

  --[[------------------------------------------------------------------
    Returns the sprite given the ammo type
    @param {number} ammunition type
    @return {string} sprite
  ]]--------------------------------------------------------------------
  function HL2RBHUD:GetAmmoIcon(ammoType)
    return HL2RBHUD.AmmoIcons[ammoType];
  end

  --[[------------------------------------------------------------------
    Adds an item icon
    @param {string} sprite
    @param {string} item class
  ]]--------------------------------------------------------------------
  function HL2RBHUD:AddItemIcon(sprite, item)
    HL2RBHUD.ItemIcons[item] = sprite;
  end

  --[[------------------------------------------------------------------
    Returns the sprite given the item class
    @param {string} item class
    @return {string} sprite
  ]]--------------------------------------------------------------------
  function HL2RBHUD:GetItemIcon(item)
    return HL2RBHUD.ItemIcons[item];
  end

  --[[------------------------------------------------------------------
    Overrides an item so it doesn't draw in the history
    @param {string} item class
  ]]--------------------------------------------------------------------
  function HL2RBHUD:AddItemOverride(item)
    HL2RBHUD.ItemOverride[item] = true;
  end

  --[[------------------------------------------------------------------
    Adds a custom function to draw a weapon's icon
    @param {string} weapon class
    @param {function} draw function (e.g. function(x, y, alpha))
  ]]--------------------------------------------------------------------
  function HL2RBHUD:AddWeaponIcon(weaponClass, func)
    HL2RBHUD.WeaponIcons[weaponClass] = func;
  end

  --[[------------------------------------------------------------------
    Adds a sprite as a weapon icon
    @param {string} sprite
    @param {string} weapon class
    @param {boolean} centered
  ]]--------------------------------------------------------------------
  function HL2RBHUD:AddWeaponSprite(sprite, weaponClass, centered, scale)
    if (centered == nil) then centered = true; end
    scale = scale or 1;
    HL2RBHUD.WeaponIcons[weaponClass] = {sprite = sprite, centered = centered, scale = scale};
  end

  --[[------------------------------------------------------------------
    Whether a registered weapon icon is a sprite
    @return {boolean} is a sprite
  ]]--------------------------------------------------------------------
  function HL2RBHUD:IsWeaponSprite(weaponClass)
    return type(HL2RBHUD.WeaponIcons[weaponClass]) == STRING_TYPE;
  end

  --[[------------------------------------------------------------------
    Whether a weapon has a registered icon
    @return {boolean} has icon
  ]]--------------------------------------------------------------------
  function HL2RBHUD:HasWeaponIcon(weaponClass)
    return HL2RBHUD.WeaponIcons[weaponClass] ~= nil;
  end

  --[[------------------------------------------------------------------
    Returns a weapon icon data
    @return {table} weapon icon data
  ]]--------------------------------------------------------------------
  function HL2RBHUD:GetWeaponIcon(weaponClass)
    return HL2RBHUD.WeaponIcons[weaponClass];
  end

end
