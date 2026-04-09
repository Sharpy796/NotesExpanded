dofile("data/scripts/lib/mod_settings.lua")

local mod_id = "NotesExpanded" -- This should match the name of your mod's folder.
mod_settings_version = 1 -- This is a magic global that can be used to migrate settings to new mod versions. call mod_settings_get_version() before mod_settings_update() to get the old value. 
mod_settings =
{
    {
        id = "inject_spells",
        ui_name = "Inject Spells",
        ui_description = "Injects the new note spells into their appropriate spots in the progress menu.",
        value_default = true,
        scope = MOD_SETTING_SCOPE_RUNTIME_RESTART
    },
    {
        id = "accidental",
        ui_name = "Accidental",
        ui_description = "Swaps accidentals between sharp and flat.",
        type = "enum",
        values = {
            [1] = "Sharp",
            [2] = "Flat",
        },
        default = 1,
        scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
    },
    -- {
    --     id = "aprilfools",
    --     ui_name = "April Fools",
    --     ui_description = "Music majors will enjoy this.",
    --     value_default = false,
    --     scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
    -- },
}


function ModSettingsUpdate( init_scope )
    if init_scope == 0 then -- On new game
        -- do stuff on new game
    end
    local old_version = mod_settings_get_version( mod_id )
    mod_settings_update( mod_id, mod_settings, init_scope )
end

function ModSettingsGuiCount()
    return mod_settings_gui_count( mod_id, mod_settings )
end

function ModSettingsGui( gui, in_main_menu )
    mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )
end