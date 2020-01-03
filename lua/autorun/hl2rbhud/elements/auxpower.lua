--[[------------------------------------------------------------------
  AUXILIARY POWER
  Display the current auxiliary power amount left and the flashlight
  tooltip
]]--------------------------------------------------------------------

if CLIENT then

  -- Parameters
  local BACKGROUND = 0.4;
  local BLACK_COLOUR = Color(0, 0, 0, 100);
  local FLASHLIGHT_ON = "FLASHLIGHT: ON";
  local FLASHLIGHT_OFF = "FLASHLIGHT: OFF";
  local FLASHLIGHT = "FLASHLIGHT: %d%%";
  local W, H = 104, 17;

  -- Variables
  local power = 1;
  local flashlight = 1;
  local alpha = 0;
  local alpha1 = 0;
  local alpha2 = 0;
  local tick = 0;

  -- Internal function; animate elements
  local function Animate(value)
    if (tick < CurTime()) then
      if (value < 1) then
        alpha = math.min(alpha + 0.03, 1);
      else
        alpha = math.max(alpha - 0.03, 0);
      end -- bar alpha
      if (LocalPlayer():FlashlightIsOn()) then
        alpha1 = math.min(alpha1 + 0.05, 1);
      else
        alpha1 = math.max(alpha1 - 0.05, 0);
      end -- flashlight tip alpha
      if (AUXPOW and AUXPOW:GetFlashlight() < 1) then
        alpha2 = math.min(alpha2 + 0.05, 1);
      else
        alpha2 = math.max(alpha2 - 0.05, 0);
      end -- flashlight bar alpha
      tick = CurTime() + 0.01;
    end
  end

  --[[------------------------------------------------------------------
    Generates the flashlight font with the new scale
    @void
  ]]--------------------------------------------------------------------
  function HL2RBHUD:RefreshFont()
    surface.CreateFont( "hl2rbhud", {
      font = "Verdana",
      size = math.Round(13 * HL2RBHUD:GetScale()),
      weight = 1000,
      antialias = true
    });

    surface.CreateFont("hl2rbhud_pickup_ammo_num", {
      font = "HalfLife2",
      size = math.Round(9 * HL2RBHUD:GetScale()),
      additive = true,
      antialias = true,
      weight = 1000
    });

    surface.CreateFont("hl2rbhud_pickup_ammo", {
      font = "Tahoma",
      size = math.Round(10 * HL2RBHUD:GetScale()),
      additive = true,
      antialias = true,
      weight = 1000
    });
  end

  --[[------------------------------------------------------------------
    Draws the flashlight tip
    @param {number} x
    @param {number} y
    @param {number} scale
  ]]--------------------------------------------------------------------
  function HL2RBHUD:DrawFlashlight(x, y, scale)
    local label = FLASHLIGHT_OFF;
    local alpha = alpha1;
    local colour = HL2RBHUD:GetAuxPowerColour();
    local background = Color(colour.r * BACKGROUND, colour.g * BACKGROUND, colour.b * BACKGROUND, colour.a);
    if (AUXPOW and HL2RBHUD:GetFlashlightMode() >= 1) then
      alpha = alpha2;
      label = string.format(FLASHLIGHT, math.floor(AUXPOW:GetFlashlight() * 100));
    else
      if (LocalPlayer():FlashlightIsOn()) then
        label = FLASHLIGHT_ON;
      end
    end -- get flashlight label

    local a = surface.GetAlphaMultiplier();
    if (AUXPOW and HL2RBHUD:GetFlashlightMode() <= 0) then
      surface.SetAlphaMultiplier(alpha2);
      flashlight = Lerp(FrameTime() * 20, flashlight, AUXPOW:GetFlashlight());
      draw.RoundedBox(0, x, y, W * scale, H * scale, background);
      draw.RoundedBox(0, x, y, (W * scale) * flashlight, H * scale, colour);
      surface.SetAlphaMultiplier(a);
    end -- draw additional flashlight bar

    local x, y = 55, ScrH() - (163 * scale);
    surface.SetAlphaMultiplier(alpha);
    draw.RoundedBox(6, x, y, 150 * scale, 30 * scale, BLACK_COLOUR);
    draw.SimpleText(label, "hl2rbhud", x + (10 * scale), y + (8 * scale), Color(220, 200, 0));
    surface.SetAlphaMultiplier(a);
  end

  --[[------------------------------------------------------------------
    Draw the auxiliary power bar
    @param {number} x
    @param {number} y
    @param {number} scale
  ]]--------------------------------------------------------------------
  function HL2RBHUD:DrawAuxPower(x, y, scale)
    if (not HL2RBHUD:IsAuxPowerEnabled()) then return end
    local colour = HL2RBHUD:GetAuxPowerColour();
    local background = Color(colour.r * BACKGROUND, colour.g * BACKGROUND, colour.b * BACKGROUND, colour.a);
    local value = 1;
    local vanilla = 100;
    if (LocalPlayer().GetSuitPower) then vanilla = LocalPlayer():GetSuitPower(); end
    if (vanilla < 100) then
      value = vanilla * 0.01;
    else
      if (AUXPOW) then
        value = AUXPOW:GetPower();
      end
    end -- get priority value
    power = Lerp(FrameTime() * 20, power, value);
    Animate(value); -- animate alpha
    local a = surface.GetAlphaMultiplier();
    surface.SetAlphaMultiplier(alpha);
    draw.RoundedBox(0, x, y, W * scale, H * scale, background);
    draw.RoundedBox(0, x, y, (W * scale) * power, H * scale, colour);
    surface.SetAlphaMultiplier(a);
    HL2RBHUD:DrawFlashlight(x + ((W + 30) * scale), y, scale);
  end

  -- Font update
  HL2RBHUD:RefreshFont();
  cvars.AddChangeCallback("hl2rbhud_scale", function()
    HL2RBHUD:RefreshFont();
  end);

  -- Override Auxiliary Power addon drawing hooks
  hook.Add("AuxPowerHUDPaint", "auxpower_hl2rbhud_vanilla", function(power, labels)
    if (not HL2RBHUD:IsEnabled() or not HL2RBHUD:IsAuxPowerEnabled()) then return end
    return true;
  end);

  hook.Add("EP2FlashlightHUDPaint", "auxpower_hl2rbhud_ep2", function(power)
    if (not HL2RBHUD:IsEnabled() or not HL2RBHUD:IsAuxPowerEnabled()) then return end
    return true;
  end);

end
