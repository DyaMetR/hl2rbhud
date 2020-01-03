--[[------------------------------------------------------------------
  HIGHLIGHT
  Manages highlighting values for the display
]]--------------------------------------------------------------------

if CLIENT then

  HL2RBHUD.Highlights = {}; -- Highlight table

  --[[------------------------------------------------------------------
    Registers a highlight value to trigger
    @param {string} name
  ]]--------------------------------------------------------------------
  function HL2RBHUD:AddHighlight(name)
    HL2RBHUD.Highlights[name] = 0;
  end

  --[[------------------------------------------------------------------
    Gets the highlight current value
    @param {string} name
    @return {number} value
  ]]--------------------------------------------------------------------
  function HL2RBHUD:GetHighlight(name)
    return HL2RBHUD.Highlights[name];
  end

  --[[------------------------------------------------------------------
    Triggers a highlight
    @param {string} name
  ]]--------------------------------------------------------------------
  function HL2RBHUD:TriggerHighlight(name)
    HL2RBHUD.Highlights[name] = 1;
  end

  -- Animate the highlights
  local tick = 0;
  hook.Add("HUDPaint", "hl2rbhud_highlight", function()
    if (tick < CurTime()) then
      for name, value in pairs(HL2RBHUD.Highlights) do
        HL2RBHUD.Highlights[name] = math.max(value - 0.013, 0);
      end
      tick = CurTime() + 0.01;
    end
  end);

end
