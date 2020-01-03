--[[------------------------------------------------------------------
  PICKUP HISTORY
  Displays which items and ammunition amounts have been picked up
]]--------------------------------------------------------------------

if CLIENT then

  -- Parameters
  HL2RBHUD.WEAPON_COLOUR = Color(255, 235, 0);
  local DEFAULT_COLOUR = Color(255, 215, 90);
  local WEAPON_COLOUR = Color(255, 220, 0, 255);
  local BACKGROUND_COLOUR = Color(0, 0, 0, 40);
  local AMMO_SUFIX = "_ammo";
  local TEXT_OFFSET = 1;
  local TIME = 4;
  local SPEED = 0.006;
  local FONT_BUCKET = "hl2rbhud_pickup_bucket";
  local FONT_TEXT = "hl2rbhud_pickup_name";
  local FONT_NUM = "hl2rbhud_pickup_ammo_num";
  local FONT_AMMO = "hl2rbhud_pickup_ammo";
  local PICKUP_STR = "ACQUIRED: %s";
  local BLINKS = 3;
  local BLINK_ALPHA = 0.7;
  local W, H = 256, 180;

  -- Tables
  HL2RBHUD.Pickup = {}; -- pickup history

  -- Get screen scale
  function HL2RBHUD:GetScreenScale()
    return ScrH() / 1080;
  end

  -- Create fonts
  surface.CreateFont(FONT_BUCKET, {
    font = "Verdana",
    size = HL2RBHUD:GetScreenScale() * 24,
    additive = true,
    antialias = true,
    weight = 1000
  });

  surface.CreateFont(FONT_TEXT, {
    font = "Verdana",
    size = HL2RBHUD:GetScreenScale() * 16,
    antialias = true,
    weight = 1000
  });

  -- Variables
  local tick = 0;
  local count = 0;
  local weaponTable = {{}, {}, {}, {}, {}, {}};
  local iSlot, iPos, anim1, active, alpha = 0, 0, 0, false, 0;
  local cur, name, blink, bAmount, blinks = 0, 0, false, 0, 0;

  -- Adds a new row
  local function AddCount()
    if (count < (ScrH() / (66 * HL2RBHUD:GetScale()))) then
      count = count + 1;
    else
      count = 0;
    end
  end

  --[[------------------------------------------------------------------
    Adds an ammo pickup to the history
    @param {string} ammo type
    @param {number} amount
  ]]--------------------------------------------------------------------
  function HL2RBHUD:AddAmmoPickup(ammoType, amount)
    table.insert(HL2RBHUD.Pickup, {class = ammoType, meta = amount, a = 1, pos = count});
    AddCount();
  end

  --[[------------------------------------------------------------------
    Adds an item pickup to the history
    @param {string} item class
  ]]--------------------------------------------------------------------
  function HL2RBHUD:AddItemPickup(itemClass)
    table.insert(HL2RBHUD.Pickup, {class = itemClass, meta = nil, a = 1, pos = count});
    AddCount();
  end

  -- Internal function; draws an ammo pickup
  local function DrawAmmoPickup(x, y, ammoType, amount, scale)
    local colour = HL2RBHUD:GetPickupHistoryColour();

    -- Draw amount
    draw.SimpleText(amount, FONT_NUM, x + (7 * scale), y - math.floor(TEXT_OFFSET * scale), colour, nil, TEXT_ALIGN_CENTER);

    -- Draw icon
    local icon = HL2RBHUD:GetAmmoIcon(ammoType);
    if (icon) then -- if there's an icon, draw it; if not, draw the name
      local w, h = HL2RBHUD:GetSpriteSize(icon);
      HL2RBHUD:DrawSprite(x - (w * scale), y - (h * scale * 0.5), icon, colour, scale);
    else
      draw.SimpleText(language.GetPhrase(ammoType .. AMMO_SUFIX), FONT_AMMO, x, y - (1.5 * scale), colour, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER);
    end
  end

  -- Internal function; draws an item pickup
  local function DrawItemPickup(x, y, item, scale)
    local icon = HL2RBHUD:GetItemIcon(item);
    local colour = HL2RBHUD:GetPickupHistoryColour();
    if (icon) then
      local w, h = HL2RBHUD:GetSpriteSize(icon);
      HL2RBHUD:DrawSprite(x - w, y, icon, colour, scale);
    else
      draw.SimpleText(language.GetPhrase(item), FONT_AMMO, x, y - (1.5 * scale), colour, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER);
    end
  end

  -- Internal function; draws a weapon icon
  local function DrawWeaponIcon(x, y, weapon)
    if (not IsValid(weapon)) then return end
    local class = weapon:GetClass();
    if (HL2RBHUD:HasWeaponIcon(class)) then
      local icon = HL2RBHUD:GetWeaponIcon(class);
      if (HL2RBHUD:IsWeaponSprite(class)) then
        local w, h = HL2RBHUD:GetSpriteSize(icon.sprite);
        local u, v = 125 * HL2RBHUD:GetScreenScale(), 90 * HL2RBHUD:GetScreenScale();
        local scale = HL2RBHUD:GetScreenScale() * icon.scale;
        if (not icon.centered) then w = 0; h = 0; end
        HL2RBHUD:DrawSprite(x + u - ((w * 0.5) * scale), y + v - ((h * 0.5) * scale), icon.sprite, HL2RBHUD.WEAPON_COLOUR, scale);
      else
        icon(x, y);
      end
    else
      if (weapon.DrawWeaponSelection) then
        local infoBox = weapon.DrawWeaponInfoBox;
        weapon.DrawWeaponInfoBox = false;
        weapon:DrawWeaponSelection(x - (HL2RBHUD:GetScreenScale() * 2), y, W, H, alpha * 255);
        weapon.DrawWeaponInfoBox = infoBox;
      end
    end
  end

  -- Internal function; draws only what's needed from the weapon selector
  local function DrawWeaponSelector()
    if (not HL2RBHUD:IsWeaponPickupEnabled()) then return end
    local size, offset = 72 * HL2RBHUD:GetScreenScale(), 18 * HL2RBHUD:GetScreenScale();
    local sWide, sTall, sTallb = 252 * HL2RBHUD:GetScreenScale(), 180 * HL2RBHUD:GetScreenScale(), 45 * HL2RBHUD:GetScreenScale();
    local x, y = (ScrW() * 0.5) - (350 * HL2RBHUD:GetScreenScale()) + (sWide * 0.35) * (1 - anim1), 36 * HL2RBHUD:GetScreenScale();
    local slotOffset = 0;

    local oldAlpha = surface.GetAlphaMultiplier();
    surface.SetAlphaMultiplier(alpha);
    -- Draw slots
    for slot=0, 5 do
      local posOffset = 0;
      local a = x + ((offset + size) * slot); -- slot x position
      if (table.Count(weaponTable[slot + 1]) > 0) then
        -- Draw weapons
        local pos = 0;
        for i, weapon in pairs(weaponTable[slot + 1]) do
          if (not weapon or not IsValid(weapon.weapon)) then
            if (weapon.selected) then alpha = 0; end
            continue
          end -- skip or disable animation if weapon is invalid
          if (iSlot ~= slot and pos > 0) then continue end
          local w, h = size, size; -- weapon slot size
          local background = table.Copy(BACKGROUND_COLOUR);
          local colour = table.Copy(WEAPON_COLOUR);
          local nameCol = table.Copy(colour);

          -- If weapon is not selected, adjust number colour
          if (not weapon.selected) then
            colour.a = 150;
          end

          -- Adjust size and colour based on selected weapon
          if (slot == iSlot) then
            if (weapon.selected) then
              background.a = 90;
              nameCol.a = 255 - (255 * bAmount);
              h = sTall;
            else
              h = sTallb;
            end
            w = size + (sWide - size) * anim1;
          end

          -- Draw background
          local b = h; -- background height
          if (h == sTall) then b = size + (sTall - size) * anim1; end
          draw.RoundedBox(6, a + slotOffset, y + posOffset, w, b, background);

          -- Draw number
          if (pos <= 0 and table.Count(weaponTable[slot + 1]) > 0) then
            draw.SimpleText(slot + 1, FONT_BUCKET, a + (8 * HL2RBHUD:GetScreenScale()) + slotOffset, y + (9 * HL2RBHUD:GetScreenScale()), colour);
          end

          -- Draw weapon name
          if (iSlot == slot and anim1 >= 1) then
            -- Draw weapon icon separately so it doesn't interfere with draw calls
            if (weapon.selected) then
              DrawWeaponIcon(a, y + posOffset, weapon.weapon);
            end

            -- Draw text
            local wepName = language.GetPhrase(weapon.weapon:GetPrintName());
            local format = string.format(PICKUP_STR, wepName);
            surface.SetFont(FONT_TEXT);
            local tW, tH = surface.GetTextSize(wepName);
            if (weapon.selected) then
              local tbl = string.Split(format, '\n');
              local len = 1;
              for i, text in pairs(tbl) do
                local u, v = surface.GetTextSize(text);
                draw.SimpleText(string.sub(format, len, math.min(cur, len + string.len(text))), FONT_TEXT, a + (w * 0.5) - (HL2RBHUD:GetScreenScale() * 2) - (u * 0.5), y + h + posOffset - (8 * HL2RBHUD:GetScreenScale()) - tH + ((i - 1) * v), nameCol);
                len = len + string.len(text);
              end
            else
              local tbl = string.Split(wepName, '\n');
              for i, text in pairs(tbl) do
                local u, v = surface.GetTextSize(text);
                if (i > 1) then text = '\t' .. text; end
                draw.SimpleText(text, FONT_TEXT, a + (w * 0.5) - (HL2RBHUD:GetScreenScale() * 2) - (u * 0.5), y + h + posOffset - (8 * HL2RBHUD:GetScreenScale()) - tH + ((i - 1) * v), nameCol);
              end
            end
          end

          -- Move next weapon
          posOffset = posOffset + h + offset;

          -- Next
          pos = pos + 1;
        end

        -- Move the next slots
        if (slot == iSlot) then
          slotOffset = (size + ((sWide - size) * anim1)) - size;
        end
      else
        draw.RoundedBox(6, a + slotOffset, y, size, size, Color(0, 0, 0, 50));
      end
    end
    surface.SetAlphaMultiplier(oldAlpha);
  end

  --[[------------------------------------------------------------------
    Draw the pickup history
    @param {number} x
    @param {number} y
  ]]--------------------------------------------------------------------
  function HL2RBHUD:DrawPickupHistory(x, y, scale)
    DrawWeaponSelector();
    -- Animate
    if (tick < CurTime()) then
      for i, pickup in pairs(HL2RBHUD.Pickup) do
        if (pickup.a > 0) then
          HL2RBHUD.Pickup[i].a = math.max(pickup.a - SPEED, 0);
        else
          table.remove(HL2RBHUD.Pickup, i);
          if (table.Count(HL2RBHUD.Pickup) <= 0) then
            count = 0;
          end -- reset count if everything's erased
        end
      end

      -- Weapon selector animation
      if (active) then
        if (anim1 < 1) then
          anim1 = math.min(anim1 + 0.035, 1);
        else
          if (cur < name) then
            cur = cur + 0.66;
          else
            active = false;
          end
        end
      elseif (not active and blinks >= BLINKS and bAmount >= 1) then
        alpha = math.max(alpha - 0.017, 0);
      end

      -- Text blink animation
      if (cur >= name and blinks < BLINKS) then
        if (blink) then
          if (bAmount < BLINK_ALPHA) then
            local amount = 0.036;
            if (blinks <= 0) then amount = 0.033; end
            bAmount = math.min(bAmount + amount, BLINK_ALPHA);
          else
            blink = false;
            blinks = blinks + 1;
          end
        else
          if (bAmount > 0) then
            bAmount = math.max(bAmount - 0.17, 0);
          else
            blink = true;
          end
        end
      elseif (blinks >= BLINKS) then
        bAmount = math.min(bAmount + 0.02, 1);
      end

      tick = CurTime() + 0.01;
    end

    -- Draw
    if (not HL2RBHUD:IsPickupHistoryEnabled()) then return end
    for i, pickup in pairs(HL2RBHUD.Pickup) do
      local a = surface.GetAlphaMultiplier();
      surface.SetAlphaMultiplier(pickup.a * 2);
      if (pickup.meta) then
        DrawAmmoPickup(x, y - (50 * scale * pickup.pos), pickup.class, pickup.meta, scale);
      else
        DrawItemPickup(x, y - (50 * scale * pickup.pos), pickup.class, scale);
      end
      surface.SetAlphaMultiplier(a);
    end
  end

  -- Sorts a weapon bucket by key
  local function SortWeaponBucket(a, b)
    return a.pos < b.pos;
  end

  -- Updates the weapon list
  local function UpdateWeapons(selected)
    weaponTable = {{}, {}, {}, {}, {}, {}}; -- Reset weapon table
    for _, weapon in pairs(LocalPlayer():GetWeapons()) do
      table.insert(weaponTable[weapon:GetSlot() + 1], {pos = weapon:GetSlotPos() + 1, selected = selected == weapon, weapon = weapon});
    end -- Add weapons
    table.sort(weaponTable[selected:GetSlot() + 1], SortWeaponBucket);
  end

  -- Ammo pickup
  hook.Add("HUDAmmoPickedUp", "hl2rbhud_pickup_ammo", function(ammoType, amount)
    if (not HL2RBHUD:IsEnabled() or not HL2RBHUD:IsPickupHistoryEnabled()) then return end
    HL2RBHUD:AddAmmoPickup(ammoType, amount);
    return true;
  end);

  -- Item pickup
  hook.Add("HUDItemPickedUp", "hl2rbhud_pickup_ammo", function(itemClass)
    if (not HL2RBHUD:IsEnabled() or not HL2RBHUD:IsPickupHistoryEnabled()) then return end
    if (HL2RBHUD.ItemOverride[itemClass]) then return true; end
    HL2RBHUD:AddItemPickup(itemClass);
    return true;
  end);

  -- Weapon pickup
  hook.Add("HUDWeaponPickedUp", "hl2rbhud_pickup_weapon", function(weapon)
    if (not HL2RBHUD:IsEnabled() or not HL2RBHUD:IsWeaponPickupEnabled()) then return end
    iSlot = weapon:GetSlot();
    name = string.len(string.format(PICKUP_STR, language.GetPhrase(weapon:GetPrintName())));
    cur = 0;
    UpdateWeapons(weapon);
    bAmount = 0;
    blinks = 0;
    anim1 = 0;
    active = true;
    alpha = 1;
    return true;
  end);

  -- Skip weapon pickup animation
  local INVENTORY_BINDS = {
    ["invprev"] = true,
    ["invnext"] = true,
    ["slot1"] = true,
    ["slot2"] = true,
    ["slot3"] = true,
    ["slot4"] = true,
    ["slot5"] = true,
    ["slot6"] = true
  };
  hook.Add("PlayerBindPress", "hl2rbhud_pickup_override", function(ply, bind, pressed)
    if (not HL2RBHUD:IsEnabled() or not HL2RBHUD:IsWeaponPickupEnabled()) then return end
    if (alpha > 0 and INVENTORY_BINDS[bind]) then alpha = 0; end
  end);

end
