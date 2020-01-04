--[[------------------------------------------------------------------
  CONFIGURATION
  Customization variables
]]--------------------------------------------------------------------

if CLIENT then

  -- Parameters
  HL2RBHUD.CONVAR_PREFIX = "hl2rbhud_";
  local DEFAULT_COLOUR = Color(255, 200, 100, 255);
  local DEFAULT_CRIT_COLOUR = Color(255, 0, 0, 255);
  local QI_COLOUR1 = Color(255, 230, 70);
  local QI_COLOUR2 = Color(255, 48, 0);
  local SUIT_COLOUR = Color(255, 180, 90);
  local PICKUP_COLOUR = Color(255, 215, 90);
  local PREFIX = HL2RBHUD.CONVAR_PREFIX;
  local TABLE_TYPE = "table";
  HL2RBHUD.CONVARS = {
    enable = 1,
    scale = 1,
    qi_scale = 1,
    qi_mode = 1,
    qi_invert = 0,
    health = 1,
    suit = 1,
    ammo = 1,
    quickinfo = 1,
    pickup = 1,
    custom_icons = 1,
    weapon = 1,
    flashlight = 0,
    no_suit = 0,
    health_colour = DEFAULT_COLOUR,
    health_colour_low = DEFAULT_CRIT_COLOUR,
    armour_colour = DEFAULT_COLOUR,
    suit_colour = SUIT_COLOUR,
    ammo_colour = DEFAULT_COLOUR,
    ammo_colour_low = DEFAULT_CRIT_COLOUR,
    pickup_colour = PICKUP_COLOUR,
    qi_h1_colour = QI_COLOUR1,
    qi_a1_colour = QI_COLOUR1,
    qi_h2_colour = QI_COLOUR2,
    qi_a2_colour = QI_COLOUR2
  };

  -- Initialize convars
  for convar, default in pairs(HL2RBHUD.CONVARS) do
    if (type(default) == TABLE_TYPE) then
      CreateClientConVar(PREFIX .. convar .. "_r", default.r, true);
      CreateClientConVar(PREFIX .. convar .. "_g", default.g, true);
      CreateClientConVar(PREFIX .. convar .. "_b", default.b, true);
      CreateClientConVar(PREFIX .. convar .. "_a", default.a, true);
    else
      CreateClientConVar(PREFIX .. convar, default, true);
    end
  end

  -- Reset config command
  concommand.Add(PREFIX .. "reset", function(ply, com, args)
    for convar, default in pairs(HL2RBHUD.CONVARS) do
      if (type(default) == TABLE_TYPE) then continue end
      RunConsoleCommand(PREFIX .. convar, default);
    end
  end);

  -- Reset colours command
  concommand.Add(PREFIX .. "reset_colour", function(ply, com, args)
    for convar, default in pairs(HL2RBHUD.CONVARS) do
      if (type(default) ~= TABLE_TYPE) then continue end
      RunConsoleCommand(PREFIX .. convar .. "_r", default.r);
      RunConsoleCommand(PREFIX .. convar .. "_g", default.g);
      RunConsoleCommand(PREFIX .. convar .. "_b", default.b);
      RunConsoleCommand(PREFIX .. convar .. "_a", default.a);
    end
  end);

  --[[------------------------------------------------------------------
    Whether the HUD is enabled
    @param {boolean} is enabled
  ]]--------------------------------------------------------------------
  function HL2RBHUD:IsEnabled()
    return GetConVar(PREFIX .. "enable"):GetInt() >= 1;
  end

  --[[------------------------------------------------------------------
    Returns the HUD scale
    @return {number} scale
  ]]--------------------------------------------------------------------
  function HL2RBHUD:GetScale()
    return GetConVar(PREFIX .. "scale"):GetFloat() * 1.3;
  end

  --[[------------------------------------------------------------------
    Whether the health and armour elements are enabled
    @return {boolean} is enabled
  ]]--------------------------------------------------------------------
  function HL2RBHUD:IsHealthEnabled()
    return GetConVar(PREFIX .. "health"):GetInt() >= 1;
  end

  --[[------------------------------------------------------------------
    Whether the auxiliary power elements are enabled
    @return {boolean} is enabled
  ]]--------------------------------------------------------------------
  function HL2RBHUD:IsAuxPowerEnabled()
    return GetConVar(PREFIX .. "suit"):GetInt() >= 1;
  end

  --[[------------------------------------------------------------------
    Whether the ammunition indicator is enabled
    @return {boolean} is enabled
  ]]--------------------------------------------------------------------
  function HL2RBHUD:IsAmmoEnabled()
    return GetConVar(PREFIX .. "ammo"):GetInt() >= 1;
  end

  --[[------------------------------------------------------------------
    Whether the quick info element is enabled
    @return {boolean} is enabled
  ]]--------------------------------------------------------------------
  function HL2RBHUD:IsQuickInfoEnabled()
    return GetConVar(PREFIX .. "quickinfo"):GetInt() >= 1;
  end

  --[[------------------------------------------------------------------
    Whether the quick info is inverted
    @return {boolean} is inverted
  ]]--------------------------------------------------------------------
  function HL2RBHUD:IsQuickInfoInverted()
    return GetConVar(PREFIX .. "qi_invert"):GetInt() >= 1;
  end

  --[[------------------------------------------------------------------
    Returns the quick info scale
    @return {number} scale
  ]]--------------------------------------------------------------------
  function HL2RBHUD:GetQuickInfoScale()
    return GetConVar(PREFIX .. "qi_scale"):GetFloat();
  end

  --[[------------------------------------------------------------------
    Returns the selected flashlight mode
    @return {number} flashlight mode
  ]]--------------------------------------------------------------------
  function HL2RBHUD:GetFlashlightMode()
    return GetConVar(PREFIX .. "flashlight"):GetInt();
  end

  --[[------------------------------------------------------------------
    Returns the selected quick info behaviour mode
    @return {number} quick info mode
  ]]--------------------------------------------------------------------
  function HL2RBHUD:GetQuickInfoMode()
    return GetConVar(PREFIX .. "qi_mode"):GetInt();
  end

  --[[------------------------------------------------------------------
    Whether pickup history is enabled
    @return {boolean} is enabled
  ]]--------------------------------------------------------------------
  function HL2RBHUD:IsPickupHistoryEnabled()
    return GetConVar(PREFIX .. "pickup"):GetInt() >= 1;
  end

  --[[------------------------------------------------------------------
    Whether weapon pickup animation is enabled
    @return {boolean} is enabled
  ]]--------------------------------------------------------------------
  function HL2RBHUD:IsWeaponPickupEnabled()
    return GetConVar(PREFIX .. "weapon"):GetInt() >= 1;
  end

  --[[------------------------------------------------------------------
    Whether the HUD should be drawn even without the suit
    @return {boolean} is shown without suit
  ]]--------------------------------------------------------------------
  function HL2RBHUD:ShouldDrawWithNoSuit()
    return GetConVar(PREFIX .. "no_suit"):GetInt() >= 1;
  end

  --[[------------------------------------------------------------------
    Whether the weapon pickup animation should use custom icons
    @return {boolean} use custom icons
  ]]--------------------------------------------------------------------
  function HL2RBHUD:ShouldUseCustomIcons()
    return GetConVar(PREFIX .. "custom_icons"):GetInt() >= 1;
  end

  -- Internal function; returns a colour structure based on the given convar
  local function GetColourConVar(convar)
    return Color(
      GetConVar(convar .. "_r"):GetInt(),
      GetConVar(convar .. "_g"):GetInt(),
      GetConVar(convar .. "_b"):GetInt(),
      GetConVar(convar .. "_a"):GetInt()
    );
  end

  --[[------------------------------------------------------------------
    Returns the health indicator colour
    @return {Color} colour
  ]]--------------------------------------------------------------------
  function HL2RBHUD:GetHealthColour()
    return GetColourConVar(PREFIX .. "health_colour");
  end

  --[[------------------------------------------------------------------
    Returns the health indicator colour on low health
    @return {Color} colour
  ]]--------------------------------------------------------------------
  function HL2RBHUD:GetHealthLowColour()
    return GetColourConVar(PREFIX .. "health_colour_low");
  end

  --[[------------------------------------------------------------------
    Returns the armour indicator colour
    @return {Color} colour
  ]]--------------------------------------------------------------------
  function HL2RBHUD:GetArmourColour()
    return GetColourConVar(PREFIX .. "armour_colour");
  end

  --[[------------------------------------------------------------------
    Returns the ammunition indicator colour
    @return {Color} colour
  ]]--------------------------------------------------------------------
  function HL2RBHUD:GetAmmoColour()
    return GetColourConVar(PREFIX .. "ammo_colour");
  end

  --[[------------------------------------------------------------------
    Returns the ammunition indicator colour on low ammo
    @return {Color} colour
  ]]--------------------------------------------------------------------
  function HL2RBHUD:GetAmmoLowColour()
    return GetColourConVar(PREFIX .. "ammo_colour_low");
  end

  --[[------------------------------------------------------------------
    Returns the aux power indicator colour
    @return {Color} colour
  ]]--------------------------------------------------------------------
  function HL2RBHUD:GetAuxPowerColour()
    return GetColourConVar(PREFIX .. "suit_colour");
  end

  --[[------------------------------------------------------------------
    Returns the pickup history colour
    @return {Color} colour
  ]]--------------------------------------------------------------------
  function HL2RBHUD:GetPickupHistoryColour()
    return GetColourConVar(PREFIX .. "pickup_colour");
  end

  --[[------------------------------------------------------------------
    Returns the health quick info bracket colour
    @return {Color} colour
  ]]--------------------------------------------------------------------
  function HL2RBHUD:GetQuickInfoHealthColour()
    return GetColourConVar(PREFIX .. "qi_h1_colour");
  end

  --[[------------------------------------------------------------------
    Returns the health quick info bracket colour on low health
    @return {Color} colour
  ]]--------------------------------------------------------------------
  function HL2RBHUD:GetQuickInfoHealthLowColour()
    return GetColourConVar(PREFIX .. "qi_h2_colour");
  end

  --[[------------------------------------------------------------------
    Returns the ammo quick info bracket colour
    @return {Color} colour
  ]]--------------------------------------------------------------------
  function HL2RBHUD:GetQuickInfoAmmoColour()
    return GetColourConVar(PREFIX .. "qi_a1_colour");
  end

  --[[------------------------------------------------------------------
    Returns the ammo quick info bracket colour on low ammo
    @return {Color} colour
  ]]--------------------------------------------------------------------
  function HL2RBHUD:GetQuickInfoAmmoLowColour()
    return GetColourConVar(PREFIX .. "qi_a2_colour");
  end

end

HL2RBHUD:IncludeFile("menu.lua");
HL2RBHUD:IncludeFile("presets.lua");
