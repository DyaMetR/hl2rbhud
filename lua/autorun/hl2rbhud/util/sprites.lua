--[[------------------------------------------------------------------
  SPRITES
  Sprite rendering utilities
]]--------------------------------------------------------------------

if CLIENT then

  -- Parameters
  local FILE_W, FILE_H = 256, 256;
  local NUM_W, NUM_H = 19, 28;
  local SNUM_W, SNUM_H = 10, 14;
  local CHAR_W, CHAR_H, L_CHAR_H, C_NUM_Y, C_NUM_H = 6, 7, 8, 66, 8;
  local SPACE = " ";

  -- Texture
  local TEXTURE = surface.GetTextureID("hl2rbhud/hud1");
  local QI_TEXTURE = surface.GetTextureID("hl2rbhud/qi_center");
  local QI_DATA = {texture = QI_TEXTURE, w = 128, h = 128};

  -- Spritesheet
  local SPRITESHEET = { -- default sprites
    TBG = {x = 202, y = 0, w = 37, h = 28},
    TBG1 = {x = 221, y = 0, w = 18, h = 28},
    SBAR = {x = 239, y = 0, w = 12, h = 28},
    SBG = {x = 100, y = 29, w = 18, h = 12},
    SBG1 = {x = 100, y = 29, w = 10, h = 12},
    TBAR = {x = 0, y = 43, w = 19, h = 37},
    AMMO = {x = 120, y = 31, w = 32, h = 10},
    HEALTH = {x = 162, y = 30, w = 48, h = 10},
    HEV = {x = 220, y = 30, w = 26, h = 10},
    LQI = {x = 0, y = 43, w = 26, h = 44, texture = QI_DATA},
    RQI = {x = 30, y = 43, w = 26, h = 44, texture = QI_DATA}
  };

  for i=0, 9 do -- add numbers to default sprites
    SPRITESHEET[tostring(i)] = {x = (20 * i) + 1, y = 0, w = NUM_W, h = NUM_H};
    SPRITESHEET[i .. "s"] = {x = (10 * i), y = 28, w = SNUM_W, h = SNUM_H};
  end

  --[[------------------------------------------------------------------
    Renders a sprite
    @param {number} x
    @param {number} y
    @param {string} sprite
    @param {Color} colour
    @param {number} scale
    @param {number|nil} custom width
    @param {number|nil} custom height
  ]]--------------------------------------------------------------------
  function HL2RBHUD:DrawSprite(x, y, sprite, colour, scale, transform_w, transform_h)
    if (not SPRITESHEET[sprite]) then return 0, 0; end
    scale = scale or 1;
    local data = SPRITESHEET[sprite];
    local w, h = transform_w or data.w, transform_h or data.h;
    local texture, fW, fH = TEXTURE, FILE_W, FILE_H;
    if (data.texture) then
      texture = data.texture.texture;
      fW = data.texture.w;
      fH = data.texture.h;
    end
    local a, b = math.Round(w * scale), math.Round(h * scale);
    surface.SetTexture(texture);
    surface.SetDrawColor(colour);
    surface.DrawTexturedRectUV(x, y, a, b, data.x/fW, data.y/fH, (data.x + data.w)/fW, (data.y + data.h)/fH);
    return a, b;
  end

  --[[------------------------------------------------------------------
    Adds a sprite to use
    @param {string} name
    @param {table} textureData
    @param {number} x
    @param {number} y
    @param {number} w
    @param {number} h
  ]]--------------------------------------------------------------------
  function HL2RBHUD:AddSprite(name, textureData, x, y, w, h)
    SPRITESHEET[name] = { x = x, y = y, w = w, h = h, texture = textureData };
  end

  --[[------------------------------------------------------------------
    Returns the dimensions of a sprite
    @param {string} sprite
    @return {number} width
    @return {number} height
  ]]--------------------------------------------------------------------
  function HL2RBHUD:GetSpriteSize(sprite)
    if (not SPRITESHEET[sprite]) then return 0, 0; end
    return SPRITESHEET[sprite].w, SPRITESHEET[sprite].h;
  end

end
