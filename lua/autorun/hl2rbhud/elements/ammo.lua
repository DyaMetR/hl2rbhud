--[[------------------------------------------------------------------
  AMMUNITION
  Displays the ammunition left of the current selected weapon
]]--------------------------------------------------------------------

if CLIENT then

  -- Parameters
  local DEFAULT_WIDTH, SMALL_WIDTH, NUM_W, SNUM_W = 110, 28, 19, 9;
  local NAME, NAME2 = "ammo", "ammo2";

  -- Highlights
  HL2RBHUD:AddHighlight(NAME);
  HL2RBHUD:AddHighlight(NAME2);

  -- Variables
  local lastClip = 0;
  local lastAlt = 0;
  local colour1 = 0;
  local colour2 = 0;
  local tick = 0;

  -- Internal function; checks for ammo difference to trigger animations
  local function Animate(clip, alt)
    if (clip ~= lastClip) then
      HL2RBHUD:TriggerHighlight(NAME);
      lastClip = clip;
    end -- primary number
    if (alt and alt ~= lastAlt) then
      HL2RBHUD:TriggerHighlight(NAME2);
      lastAlt = alt;
    end -- secondary number
    if (tick < CurTime()) then
      if (clip <= 0) then
        colour1 = math.min(colour1 + 0.08, 1);
      else
        colour1 = math.max(colour1 - 0.08, 0);
      end -- primary colour
      if (alt) then
        if (alt <= 0) then
          colour2 = math.min(colour2 + 0.08, 1);
        else
          colour2 = math.max(colour2 - 0.08, 0);
        end -- secondary colour
      end
      tick = CurTime() + 0.01;
    end
  end

  --[[------------------------------------------------------------------
    Draws the ammunition left on the given weapon
    @param {number} x
    @param {number} y
    @param {Weapon} weapon
    @param {number|nil} scale
  ]]--------------------------------------------------------------------
  function HL2RBHUD:DrawAmmo(x, y, weapon, scale)
    if (not HL2RBHUD:IsAmmoEnabled() or not IsValid(weapon) or (LocalPlayer():InVehicle() and HL2RBHUD:ShouldHideAmmoInVehicle())) then return end
    scale = scale or 1;
    local colour = HL2RBHUD:GetAmmoColour();
    local lowColour = HL2RBHUD:GetAmmoLowColour();
    local clip = weapon:Clip1();
    local max = math.max(clip, weapon:GetMaxClip1());
    local primary = weapon:GetPrimaryAmmoType();
    local secondary = weapon:GetSecondaryAmmoType();
    local reserve = LocalPlayer():GetAmmoCount(primary);
    local alt = LocalPlayer():GetAmmoCount(secondary);
    if (primary <= 0 and secondary <= 0) then return end
    local w = DEFAULT_WIDTH;
    local number = clip;
    local resvNumber = reserve;
    local altNumber = nil;
    local bar = clip/max;
    local digits = 2;
    if (clip <= -1 or (primary <= 0 and secondary > 0)) then
      local ammo = primary;
      if (primary > 0) then
        number = reserve;
      else
        number = alt;
        ammo = secondary;
      end
      resvNumber = nil;
      bar = nil;
      w = SMALL_WIDTH + 9;
      max = math.max(game.GetAmmoMax(ammo), number);
    else
      if (resvNumber > 999) then w = w + 11; end -- give more space if too big
    end -- select values to display
    if (primary > 0 and secondary > 0) then
      altNumber = alt;
      if (altNumber > 99) then
        w = w + (SNUM_W * (math.floor(math.log10(altNumber)) - 1));
      end -- give space if too big
    end -- show secondary ammo
    local maxDigits = (math.floor(math.log10(max)) + 1);
    if (max > 0 and maxDigits > 2) then
      digits = maxDigits;
      w = w + (NUM_W * (digits - 2));
    end -- if main value is 3 digits, expand it
    Animate(number, altNumber); -- trigger animation
    local col = HL2RBHUD:IntersectColour(lowColour, colour, colour1);
    local altCol = HL2RBHUD:IntersectColour(lowColour, colour, colour2);
    local highlight = HL2RBHUD:IntersectColour(lowColour, color_white, colour1);
    local altHighlight = HL2RBHUD:IntersectColour(lowColour, color_white, colour2);
    highlight.a = col.a * HL2RBHUD:GetHighlight(NAME);
    altHighlight.a = col.a * HL2RBHUD:GetHighlight(NAME2);
    HL2RBHUD:DrawNumericDisplay(x - (w * scale), y, number, "AMMO", col, scale, digits, highlight, bar, resvNumber, altNumber, altCol, altHighlight);
  end

end
