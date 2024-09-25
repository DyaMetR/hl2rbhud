--[[------------------------------------------------------------------
  HEALTH
  Display current player's health
]]--------------------------------------------------------------------

if CLIENT then

  -- Parameters
  local NAME = "health";

  HL2RBHUD:AddHighlight(NAME);

  -- Variables
  local lastHp = 100;
  local highlight = Color(255, 255, 255, 255);
  local iColour = 0;

  --[[------------------------------------------------------------------
    Draws the player's health
    @param {number} x
    @param {number} y
    @param {number|nil} scale
  ]]--------------------------------------------------------------------
  function HL2RBHUD:DrawHealth(x, y, scale)
    if (not HL2RBHUD:IsHealthEnabled()) then return end
    local hp = math.max(LocalPlayer():Health(), 0);
    local colour = HL2RBHUD:GetHealthColour();
    local lowColour = HL2RBHUD:GetHealthLowColour();

    -- Highlight
    if (lastHp ~= hp) then
      HL2RBHUD:TriggerHighlight(NAME);
      lastHp = hp;
    end
    highlight = HL2RBHUD:IntersectColour(lowColour, color_white, iColour);
    highlight.a = 255 * HL2RBHUD:GetHighlight(NAME);

    -- Low health
    if (hp < 20) then
      HL2RBHUD:TriggerHighlight(NAME);
      iColour = math.min(iColour + 0.08, 1);
    else
      iColour = math.max(iColour - 0.08, 0);
    end
    local col = HL2RBHUD:IntersectColour(lowColour, colour, iColour);

    HL2RBHUD:DrawNumericDisplay(x, y, hp, "HEALTH", col, scale, math.max(math.floor(math.log10(hp)) + 1, 3), highlight);
  end

end
