--[[------------------------------------------------------------------
  PRESETS
  Save configuration presets to load them later
]]--------------------------------------------------------------------

if CLIENT then

  -- Parameters
  local LOCATION = "DATA";
  local CONVAR_PREFIX = HL2RBHUD.CONVAR_PREFIX;
  local DIR = "hl2rbhud/";
  local EXTENSION = ".txt";

  -- Variables
  local time = 0;

  HL2RBHUD.Presets = {};

  --[[------------------------------------------------------------------
    Reads and lists the prests found in the data folder
    @return {table} presets
  ]]--------------------------------------------------------------------
  function HL2RBHUD:CachePresets()
    print("Searching 'Half-Life 2 2002 HUD' presets...");
    local files, directories = file.Find(DIR .. "*", LOCATION);
    for _, file in pairs(files) do
      HL2RBHUD.Presets[string.sub(file, 0, string.len(file) - string.len(EXTENSION))] = true;
      print("'" .. file .. "' found");
    end
    print("Done.");
    HL2RBHUD.ReloadPreset = true;
  end

  --[[------------------------------------------------------------------
    Loads a preset from the disk
    @param {string} preset
  ]]--------------------------------------------------------------------
  function HL2RBHUD:LoadPreset(preset)
    print("Loading preset '" .. preset .. "'...");
    local file = file.Read(DIR .. preset .. EXTENSION, LOCATION);
    if (file) then
      local data = util.JSONToTable(file);
      for convar, value in pairs(data) do
        RunConsoleCommand(CONVAR_PREFIX .. convar, value);
      end
      print("Done.");
    else
      print("Couldn't load preset '" .. preset .. "': Not found in disk.");
    end
  end

  --[[------------------------------------------------------------------
    Saves the current configuration to the disk
    @param {string} preset
  ]]--------------------------------------------------------------------
  function HL2RBHUD:SavePreset(preset)
    -- Check if directory exists
    if (not file.Exists(DIR, LOCATION)) then
      file.CreateDir(DIR);
    end

    -- Save preset
    if (string.len(preset) <= 0 or time > CurTime()) then return end
    print("Saving configuration as '" .. preset .. "'...");
    local data = {};
    for convar, default in pairs(HL2RBHUD.CONVARS) do
      if (not type(default) == "table") then continue end
      data[convar .. "_r"] = GetConVar(HL2RBHUD.CONVAR_PREFIX .. convar .. "_r"):GetInt();
      data[convar .. "_g"] = GetConVar(HL2RBHUD.CONVAR_PREFIX .. convar .. "_g"):GetInt();
      data[convar .. "_b"] = GetConVar(HL2RBHUD.CONVAR_PREFIX .. convar .. "_b"):GetInt();
      data[convar .. "_a"] = GetConVar(HL2RBHUD.CONVAR_PREFIX .. convar .. "_a"):GetInt();
    end
    file.Write(DIR .. preset .. EXTENSION, util.TableToJSON(data));
    HL2RBHUD.Presets[preset] = true;
    HL2RBHUD.ReloadPreset = true;
    print("Done.");
    LocalPlayer():ChatPrint("Preset '" .. preset .. "' saved successfully.");
    time = CurTime() + 1;
  end

  --[[------------------------------------------------------------------
    Saves the current configuration to the disk
    @param {string} preset
  ]]--------------------------------------------------------------------
  function HL2RBHUD:RemovePreset(preset)
    print("Removing preset '" .. preset .. "'..." );
    file.Delete(DIR .. preset .. EXTENSION);
    HL2RBHUD.Presets[preset] = nil;
    HL2RBHUD.ReloadPreset = true;
    print("Done.");
    LocalPlayer():ChatPrint("Preset '" .. preset .. "' removed successfully.");
  end

  -- Load preset command
  concommand.Add("hl2rbhud_preset_load", function(ply, com, args)
    HL2RBHUD:LoadPreset(args[1]);
  end);

  -- Save preset command
  concommand.Add("hl2rbhud_preset_save", function(ply, com, args)
    HL2RBHUD:SavePreset(args[1]);
  end);

  -- Remove preset command
  concommand.Add("hl2rbhud_preset_remove", function(ply, com, args)
    local preset = HL2RBHUD:GetSelectedPreset();
    if (args[1] and string.len(args[1]) > 0) then preset = args[1]; end
    Derma_Query(
      "Are you sure you want to remove " .. preset .. "?",
      "Remove preset",
      "Yes",
      function()
        HL2RBHUD:RemovePreset(preset);
        HL2RBHUD.ReloadPreset = true;
      end,
      "No");
  end);

end
