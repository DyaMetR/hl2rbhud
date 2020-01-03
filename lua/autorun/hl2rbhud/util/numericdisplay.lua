--[[------------------------------------------------------------------
  NUMERIC DISPLAY
  Displays a number with a label
]]--------------------------------------------------------------------

if CLIENT then

  -- Parameters
  local NUM_W, NUM_H = 19, 28;
  local SNUM_W, SNUM_H = 9, 14;
  local TRANSPARENT = Color(0, 0, 0, 0);

  --[[------------------------------------------------------------------
    Draws a number
    @param {number} x
    @param {number} y
    @param {number} number
    @param {Color} colour
    @param {number|nil} scale
  ]]--------------------------------------------------------------------
  function HL2RBHUD:DrawNumber(x, y, number, colour, scale)
    scale = scale or 1;
    local digits = string.ToTable(tostring(number));
    local offset = (NUM_W + 0.3) * scale * table.Count(digits);
    for i, digit in pairs(digits) do
      HL2RBHUD:DrawSprite(x + ((i - 1) * (NUM_W + 0.3) * scale) - offset, y, digit, colour, scale, NUM_W, NUM_H);
    end
  end

  --[[------------------------------------------------------------------
    Draws a small number
    @param {number} x
    @param {number} y
    @param {number} number
    @param {Color} colour
    @param {number|nil} scale
  ]]--------------------------------------------------------------------
  function HL2RBHUD:DrawSmallNumber(x, y, number, colour, scale)
    scale = scale or 1;
    local digits = string.ToTable(tostring(number));
    local offset = SNUM_W * scale * table.Count(digits);
    for i, digit in pairs(digits) do
      HL2RBHUD:DrawSprite(x + ((i - 1) * SNUM_W * scale) - offset, y, digit .. "s", colour, scale);
    end
  end

  --[[------------------------------------------------------------------
    Draws a numeric display with a label
    @param {number} x
    @param {number} y
    @param {number} number
    @param {string} label sprite name
    @param {Color} colour
    @param {number|nil} scale
    @param {number|nil} amount of digits
    @param {number|nil} hightlighting amount
    @param {number|nil} bar percentage
    @param {number|nil} reserve ammo (enables ammo mode)
    @param {number|nil} alternate fire mode ammo (enables ammo mode)
    @param {number|nil} reserve ammo indicator highlight colour
    @param {number|nil} alternate fire mode ammo highlight colour
  ]]--------------------------------------------------------------------
  function HL2RBHUD:DrawNumericDisplay(x, y, number, label, colour, scale, digits, highlight, bar, reserve, alt, altCol, altHighlight)
    scale = scale or 1;
    digits = digits or 3;
    y = y - ((NUM_H + 10) * scale);
    altCol = altCol or col;
    highlight = highlight or TRANSPARENT;
    altHighlight = altHighlight or TRANSPARENT;

    -- Draw label
    HL2RBHUD:DrawSprite(x, y, label, colour, scale * 0.805);

    -- Draw background
    local w = (NUM_W * digits);
    local sprite = "TBG";
    if (digits <= 1) then
      sprite = "TBG1";
    elseif (digits >= 3) then
      local sprite2 = "TBG1";
      if (digits >= 4) then
        sprite2 = "TBG";
      end
      HL2RBHUD:DrawSprite(x + math.floor((NUM_W * 2) * scale), y + (9 * scale), sprite2, colour, scale);
    end
    HL2RBHUD:DrawSprite(x - math.floor(scale), y + (9 * scale), sprite, colour, scale);

    -- Draw foreground
    HL2RBHUD:DrawNumber(x + math.floor(w * scale), y + (9 * scale), number, colour, scale); -- primary clip
    for i=1, 2 do
      HL2RBHUD:DrawNumber(x + math.floor(w * scale), y + (9 * scale), number, highlight, scale);
    end -- highlight layers

    -- Draw bar
    if (bar) then
      local a, b = x + ((w - 1) * scale), y + (9 * scale);
      local u, v = 10, 27;
      HL2RBHUD:DrawSprite(a, b, "TBAR", Color(colour.r, colour.g, colour.b, colour.a * 0.1), scale, 10, 27);
      render.SetScissorRect(a, b + (v * scale * (1 - bar)), a + (u * scale), b + (v * scale), true);
      HL2RBHUD:DrawSprite(a, b, "TBAR", colour, scale, 10, 27);
      render.SetScissorRect(0, 0, 0, 0, false); -- current ammo bar
    end
    if (reserve) then
      local offset = 0;
      local zero = "SBG1";
      if (reserve > 999) then offset = 11; zero = "SBG"; end
      HL2RBHUD:DrawSprite(x + ((w + 12) * scale), y + (18 * scale), "SBG", colour, scale, nil);
      HL2RBHUD:DrawSprite(x + ((w + 13 + (SNUM_W * 2)) * scale), y + (18 * scale), zero, colour, scale, nil);
      HL2RBHUD:DrawSmallNumber(x + ((w + 13 + offset + (SNUM_W * 3)) * scale), y + (18 * scale), reserve, colour, scale);
      w = w + (SNUM_W * 3) + 16;
      if (reserve > 999) then w = w + SNUM_W + 2; end -- move alt if too big
    end -- reserve ammo
    if (alt) then
      local width = math.max(26 + (SNUM_W * (math.floor(math.log10(alt)) - 1)), 26);
      local offset = math.max(SNUM_W * (math.floor(math.log10(alt)) - 1), 0);
      draw.RoundedBox(0, x + ((w + 3) * scale), y + (13 * scale), width * scale, 24 * scale, Color(0, 0, 0, 100))

      -- Additional background
      if (alt > 99) then
        local sprite = "SBG1";
        if (alt > 999) then sprite = "SBG"; end
        HL2RBHUD:DrawSprite(x + ((w + 6) * scale), y + (18 * scale), sprite, altCol, scale);
      end

      -- Draw value
      x = x + (offset * scale);
      HL2RBHUD:DrawSprite(x + ((w + 6) * scale), y + (18 * scale), "SBG", altCol, scale);
      HL2RBHUD:DrawSmallNumber(x + ((w + 25) * scale), y + (18 * scale), alt, altCol, scale);
      for i=1, 2 do
        HL2RBHUD:DrawSmallNumber(x + ((w + 25) * scale), y + (18 * scale), alt, altHighlight, scale);
      end -- highlight layers
    end -- secondary fire ammo
  end

end
