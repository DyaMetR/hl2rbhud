--[[------------------------------------------------------------------
  ARMOUR
  Display current player's suit battery
]]--------------------------------------------------------------------

if CLIENT then

  -- Parameters
  local NAME = "armour";

  HL2RBHUD:AddHighlight(NAME);

  -- Variables
  local lastAp = 0;
  local highlight = Color(255, 255, 255, 255);

  --[[------------------------------------------------------------------
    Draws the player's armour
    @param {number} x
    @param {number} y
    @param {number|nil} scale
  ]]--------------------------------------------------------------------
  function HL2RBHUD:DrawArmour(x, y, scale)
    if (not HL2RBHUD:IsHealthEnabled()) then return end
    local ap = math.max(LocalPlayer():Armor(), 0);
    local colour = HL2RBHUD:GetArmourColour();
    if (lastAp ~= ap) then
      HL2RBHUD:TriggerHighlight(NAME);
      lastAp = ap;
    end
    highlight.a = 255 * HL2RBHUD:GetHighlight(NAME);
    HL2RBHUD:DrawNumericDisplay(x, y, ap, "HEV", colour, scale, math.max(math.floor(math.log10(ap)) + 1, 3), highlight);
  end

end
