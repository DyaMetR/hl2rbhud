--[[------------------------------------------------------------------
  MENU
  Options menu
]]--------------------------------------------------------------------

if SERVER then return end

-- [[ Helper function to create a colour picker ]] --
local function AddColorControl(name, convar, panel)
  panel:AddControl("Color", {
    Label = name,
    Red = convar .. "_r",
    Green = convar .. "_g",
    Blue = convar .. "_b",
    Alpha = convar .. "_a" 
  });
end

-- [[ Populate tool menu ]] --
hook.Add( "PopulateToolMenu", "hl2rbhud_menu", function()
  spawnmenu.AddToolMenuOption( "Utilities", "Half-Life 2: 2002 HUD", "hl2rbhud", "#spawnmenu.utilities.settings", nil, nil, function(panel)
    panel:ClearControls();

    panel:ToolPresets("hl2rbhud", HL2RBHUD.cvarlist);

    panel:CheckBox("Enabled", "hl2rbhud_enable");
    panel:NumSlider("Scale", "hl2rbhud_scale", 0, 10, 2);
    panel:CheckBox("Should draw without the Suit", "hl2rbhud_no_suit");

    panel:Help("\n\nVital signs");
    panel:CheckBox("Enabled", "hl2rbhud_health");
    AddColorControl("Health colour", "hl2rbhud_health_colour", panel);
    AddColorControl("Health low colour", "hl2rbhud_health_colour_low", panel);
    AddColorControl("Suit battery colour", "hl2rbhud_armour_colour", panel);

    panel:Help("\n\nAmmunition");
    panel:CheckBox("Enabled", "hl2rbhud_ammo");
    panel:CheckBox("Hide ammo when in a vehicle", "hl2rbhud_ammo_hide_vehicle");
    AddColorControl("Colour", "hl2rbhud_ammo_colour", panel);
    AddColorControl("Warning colour", "hl2rbhud_ammo_colour_low", panel);

    panel:Help("\n\nAux. power");
    panel:CheckBox("Enabled", "hl2rbhud_suit");
    AddColorControl("Colour", "hl2rbhud_suit_colour", panel);

    panel:Help("\n\nPickup history");
    panel:CheckBox("Enabled", "hl2rbhud_pickup");
    panel:NumSlider("Scale", "hl2rbhud_pickup_scale", 0, 10, 2);
    AddColorControl("Colour", "hl2rbhud_pickup_colour", panel);
    panel:CheckBox("Weapon pickup animation", "hl2rbhud_pickup");
    panel:CheckBox("Custom weapon pickup icons", "hl2rbhud_custom_icons");

    panel:Help("\n\nQuick info");
    panel:CheckBox("Enabled", "hl2rbhud_quickinfo");
    panel:NumSlider("Scale", "hl2rbhud_qi_scale", 0, 10, 2);
    local combobox, label = panel:ComboBox("Style", "hl2rbhud_qi_mode");
      combobox:AddChoice("Default", 0);
      combobox:AddChoice("Original", 1);
      combobox:AddChoice("E3 2003", 2);
    AddColorControl("Health colour", "hl2rbhud_qi_h1_colour", panel);
    AddColorControl("Health warning colour", "hl2rbhud_qi_h2_colour", panel);
    AddColorControl("Ammo colour", "hl2rbhud_qi_a1_colour", panel);
    AddColorControl("Ammo warning colour", "hl2rbhud_qi_a2_colour", panel);
    panel:CheckBox("Inverted", "hl2rbhud_qi_invert");
    panel:CheckBox("Hide when zooming", "hl2rbhud_qi_zoom");
    panel:CheckBox("Hide when in a vehicle", "hl2rbhud_qi_vehicle");

    panel:Help("\n\nFlashlight");
    AddColorControl("Flashlight colour", "hl2rbhud_fl_colour", panel);
    panel:NumSlider("Background opacity", "hl2rbhud_fl_background", 0, 255);
    panel:NumSlider("Horizontal offset", "hl2rbhud_fl_x", 0, ScrW());
    panel:NumSlider("Vertical offset", "hl2rbhud_fl_y", 0, ScrH());
    if AUXPOW then
      local combobox, label = panel:ComboBox("Battery display mode", "hl2rbhud_flashlight");
      combobox:AddChoice("Additional bar", 0);
      combobox:AddChoice("Show on tag", 1);
    end

    panel:AddControl( "Label",  { Text = "\n\nMade by DyaMetR"});
    panel:AddControl( "Label",  { Text = "Special thanks to Matsilagi for support with resources and testing"});
    panel:AddControl( "Label",  { Text = "\nVersion " .. HL2RBHUD.Version .. "\n"});
  end);
end);