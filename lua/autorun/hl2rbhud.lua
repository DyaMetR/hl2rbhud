--[[------------------
  Half-life 2 2002
  Heads Up Display
    Version 1.4
      6/1/20

By DyaMetR
]]--------------------

-- Main framework table
HL2RBHUD = {};

-- Version and patch notes
HL2RBHUD.Version = "1.4";

--[[
  METHODS
]]

--[[------------------------------------------------------------------
  Correctly includes a file
  @param {string} file
]]--------------------------------------------------------------------
function HL2RBHUD:IncludeFile(file)
  if SERVER then
    include(file);
    AddCSLuaFile(file);
  end
  if CLIENT then
    include(file);
  end
end

--[[
  INCLUDES
]]
HL2RBHUD:IncludeFile("hl2rbhud/core.lua");
