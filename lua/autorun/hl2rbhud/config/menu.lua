--[[------------------------------------------------------------------
  MENU
  Options menu
]]--------------------------------------------------------------------

if CLIENT then

  -- Internal function; creates a colour panel
  local function CreateColourPanel(name, convar, panel)
    panel:AddControl( "Color", {
      Label = name,
      Red = convar .. "_r",
      Green = convar .. "_g",
      Blue = convar .. "_b",
      Alpha = convar .. "_a"
      }
    );
  end

  HL2RBHUD.ReloadPreset = true;
  local combobox0, label0;

  -- Populate the tool menu
  hook.Add( "PopulateToolMenu", "hl2rbhud_menu", function()
    spawnmenu.AddToolMenuOption( "Options", "DyaMetR", "hl2rbhud", "HL2 2002 HUD", nil, nil, function(panel)
      panel:ClearControls();

      panel:AddControl( "CheckBox", {
        Label = "Enabled",
        Command = "hl2rbhud_enable",
        }
      );

      panel:AddControl( "Slider", {
        Label = "Scale",
        Type = "Float",
        Min = 0,
        Max = 10,
        Decimal = 2,
        Command = "hl2rbhud_scale"}
      );

      panel:AddControl( "CheckBox", {
        Label = "Health and armour enabled",
        Command = "hl2rbhud_health",
        }
      );

      panel:AddControl( "CheckBox", {
        Label = "Ammunition enabled",
        Command = "hl2rbhud_ammo",
        }
      );

      panel:AddControl( "CheckBox", {
        Label = "Aux power enabled",
        Command = "hl2rbhud_suit",
        }
      );

      panel:AddControl( "CheckBox", {
        Label = "Should draw without the Suit",
        Command = "hl2rbhud_no_suit",
        }
      );

      panel:AddControl( "CheckBox", {
        Label = "Pickup history enabled",
        Command = "hl2rbhud_pickup",
        }
      );

      panel:AddControl( "CheckBox", {
        Label = "Weapon pickup animation enabled",
        Command = "hl2rbhud_weapon",
        }
      );

      panel:AddControl( "CheckBox", {
        Label = "Quick info enabled",
        Command = "hl2rbhud_quickinfo",
        }
      );

      panel:AddControl( "CheckBox", {
        Label = "Invert quick info",
        Command = "hl2rbhud_qi_invert",
        }
      );

      panel:AddControl( "Slider", {
        Label = "Quick info scale",
        Type = "Float",
        Min = 0,
        Max = 10,
        Decimal = 2,
        Command = "hl2rbhud_qi_scale"}
      );

      local combobox, label = panel:ComboBox("Quick info behaviour", "hl2rbhud_qi_mode");
      combobox:AddChoice("Default", 0);
      combobox:AddChoice("Original", 1);
      combobox:AddChoice("E3 2003", 2);

      if (AUXPOW) then
        local combobox, label = panel:ComboBox("Flashlight mode", "hl2rbhud_flashlight");
        combobox:AddChoice("Additional bar", 0);
        combobox:AddChoice("Show on tag", 1);
      end

      panel:AddControl("Button", {
    		Label = "Reset settings to default",
    		Command = "hl2rbhud_reset"
    	});

      -- Presets
      panel:AddControl( "Label" , { Text = "\nColour presets"} );
      local combobox1, label1 = panel:ComboBox("Load preset", "hl2rbhud_preset_load");

      panel:AddControl( "TextBox", {
        Label = "Save preset",
        Command = "hl2rbhud_preset_save"
      });

      combobox0, label0 = panel:ComboBox("Remove preset", "hl2rbhud_preset_remove");
      combobox0.Think = function()
        if (HL2RBHUD.ReloadPreset) then
          combobox0:Clear();
          combobox1:Clear();
          for preset, _ in pairs(HL2RBHUD.Presets) do
        		combobox0:AddChoice(preset);
            combobox1:AddChoice(preset);
          end
          HL2RBHUD.ReloadPreset = false;
        end
      end

      CreateColourPanel("Health colour", "hl2rbhud_health_colour", panel);
      CreateColourPanel("Health low colour", "hl2rbhud_health_colour_low", panel);
      CreateColourPanel("Armour colour", "hl2rbhud_armour_colour", panel);
      CreateColourPanel("Aux power colour", "hl2rbhud_suit_colour", panel);
      CreateColourPanel("Ammo colour", "hl2rbhud_ammo_colour", panel);
      CreateColourPanel("Ammo low colour", "hl2rbhud_ammo_colour_low", panel);
      CreateColourPanel("Pickup history colour", "hl2rbhud_pickup_colour", panel);
      CreateColourPanel("Quick info health colour", "hl2rbhud_qi_h1_colour", panel);
      CreateColourPanel("Quick info health low colour", "hl2rbhud_qi_h2_colour", panel);
      CreateColourPanel("Quick info ammo colour", "hl2rbhud_qi_a1_colour", panel);
      CreateColourPanel("Quick info ammo low colour", "hl2rbhud_qi_a2_colour", panel);

      panel:AddControl("Button", {
    		Label = "Reset colours to default",
    		Command = "hl2rbhud_reset_colour"
    	});

      -- Credits
      panel:AddControl( "Label",  { Text = "\nSpecial thanks to Matsilagi for support with resources and testing"});
      panel:AddControl( "Label",  { Text = "\nVersion " .. HL2RBHUD.Version .. "\n"});
    end );
  end);

  --[[
    Gets the current selected preset from the combobox
    @return {string} preset
  ]]
  function HL2RBHUD:GetSelectedPreset()
    return combobox0:GetSelected();
  end

end
