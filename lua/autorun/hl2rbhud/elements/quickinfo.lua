--[[------------------------------------------------------------------
  QUICK INFO
  Displays a couple of bars indicating health and ammo on the crosshair
]]--------------------------------------------------------------------

if CLIENT then

  -- Parameters
  local CRITICAL = .25;
  local WARNING_SOUND = "common/warning.wav";
  local TIME = 1.38;
  local MIN_ALPHA0 = 0.32;
  local MIN_ALPHA1 = 0.34;
  local MIN_ALPHA2 = 0.15;
  local ZOOM_SPEED = 0.15;

  -- Variables
  local lastHp = 1;
  local lastAmmo = 0;
  local alpha = 1;
  local fadeIn = false;
  local hTime = 0; -- crit health bar animation
  local aTime = 0; -- crit ammo bar animation
  local hLow = false; -- was warned about health
  local aLow = false; -- was warned about ammo
  local tick = 0;
  local zoom = 1;

  -- Internal function; gets ammo percentage
  local function GetAmmo(weapon)
    if (not IsValid(weapon)) then return 1; end
    local primary = weapon:GetPrimaryAmmoType();
    local secondary = weapon:GetSecondaryAmmoType();
    local clip = weapon:Clip1();
    local max = weapon:GetMaxClip1();
    if (primary <= 0 and secondary <= 0) then return 1; end
    if (primary <= 0 and secondary > 0) then
      clip = LocalPlayer():GetAmmoCount(secondary);
      primary = secondary;
    else
      if (clip <= -1) then
        clip = LocalPlayer():GetAmmoCount(primary);
        max = game.GetAmmoMax(primary);
      end
    end
    if (max == GetConVar("gmod_maxammo") or max <= 0) then
      max = 10;
    end
    return clip/max;
  end

  -- Animates the bars
  local function Animate(health, ammo)
    local mode = HL2RBHUD:GetQuickInfoMode();
    -- Alpha effect when values change
    if (lastHp ~= health or lastAmmo ~= ammo) then
      if (mode == 1) then
        alpha = MIN_ALPHA1;
      elseif (mode >= 2) then
        alpha = 1;
      else
        fadeIn = true;
      end
      lastAmmo = ammo;
      lastHp = health;
    end
    -- Warning
    if (health <= CRITICAL and not hLow) then
      surface.PlaySound(WARNING_SOUND);
      hTime = CurTime() + TIME;
      hLow = true;
    elseif (health > CRITICAL) then
      hLow = false;
    end
    if (ammo <= CRITICAL and not aLow) then
      surface.PlaySound(WARNING_SOUND);
      aTime = CurTime() + TIME;
      aLow = true;
    elseif (ammo > CRITICAL) then
      aLow = false;
    end
    -- Animate fade in/out
    if (tick < CurTime()) then
      if (mode <= 0) then
        if (fadeIn) then
          if (alpha < 1) then
            alpha = math.min(alpha + 0.035, 1);
          else
            fadeIn = false;
          end
        else
          alpha = math.max(alpha - 0.008, MIN_ALPHA0);
        end
      elseif (mode == 1 and alpha < 1) then
        alpha = math.min(alpha + 0.01, 1);
      elseif (mode >= 2 and alpha > MIN_ALPHA2) then
        alpha = math.max(alpha - 0.01, MIN_ALPHA2);
      end -- regular animation
      if (HL2RBHUD:ShouldHideQuickInfoOnZoom() and LocalPlayer():GetCanZoom() and LocalPlayer():KeyDown(IN_ZOOM)) then
        zoom = math.max(zoom - ZOOM_SPEED, 0);
      else
        zoom = math.min(zoom + ZOOM_SPEED, 1);
      end -- zoom animation
      tick = CurTime() + 0.025;
    end
    -- Animate critical bars
    if (aTime > CurTime()) then ammo = 1; end
    if (hTime > CurTime()) then health = 1; end
    return health, ammo;
  end

  --[[------------------------------------------------------------------
    Draws the quick info on the crosshair
    @param {number} scale
  ]]--------------------------------------------------------------------
  function HL2RBHUD:DrawQuickInfo(scale)
    if (not HL2RBHUD:IsQuickInfoEnabled() or (LocalPlayer():InVehicle() and HL2RBHUD:ShouldHideQuickInfoInVehicle())) then return end
    local health, ammo = Animate(LocalPlayer():Health() * 0.01, GetAmmo(LocalPlayer():GetActiveWeapon()));
    if hook.Run('HL2RBHUD_DrawQuickInfo', health, ammo) ~= nil then return end
    local w, h = 26 * scale, 44 * scale;
    local x, y = (ScrW() * 0.5) - w - (4 * scale), (ScrH() * 0.5) - (h * 0.5) + scale;
    local a = (ScrW() * 0.5) + (4 * scale);
    local blink = (math.sin(CurTime() * 16) + 3.5) / 3

    local hLow1 = hLow;
    local aLow1 = aLow;
    if (HL2RBHUD:IsQuickInfoInverted()) then
      local oldHealth = health;
      health = ammo;
      ammo = oldHealth;
      hLow1 = aLow;
      aLow1 = hLow;
    end -- invert values

    -- Health
    local hColour = HL2RBHUD:GetQuickInfoHealthColour();
    local hA = alpha * zoom; -- opacity
    if (hLow1) then
      hColour = HL2RBHUD:GetQuickInfoHealthLowColour();
      hA = alpha * blink;
    end -- low health
    local bgCol = Color(hColour.r, hColour.g, hColour.b, 20 * hA); -- background colour
    HL2RBHUD:DrawSprite(x, y, "LQI", bgCol, scale); -- draw background
    render.SetScissorRect(x, y + (h * (1 - health)), x + w, y + h, true);
    HL2RBHUD:DrawSprite(x, y, "LQI", Color(hColour.r, hColour.g, hColour.b, 200 * hA), scale);
    render.SetScissorRect(0, 0, 0, 0, false);

    -- Ammo
    local aColour = HL2RBHUD:GetQuickInfoAmmoColour();
    local aA = alpha * zoom; -- opacity
    if (aLow1) then
      aColour = HL2RBHUD:GetQuickInfoAmmoLowColour();
      aA = alpha * blink;
    end -- low ammo
    bgCol = Color(aColour.r, aColour.g, aColour.b, 20 * aA); -- background colour
    HL2RBHUD:DrawSprite(a, y, "RQI", bgCol, scale); -- draw background
    render.SetScissorRect(a, y + (h * (1 - ammo)), a + w, y + h, true);
    HL2RBHUD:DrawSprite(a, y, "RQI", Color(aColour.r, aColour.g, aColour.b, 200 * aA), scale);
    render.SetScissorRect(0, 0, 0, 0, false);
  end

end
