dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")
dofile_once("data/scripts/lib/utilities.lua")
local MOD_ID = "NOTES_EXPANDED"
local mod_id = MOD_ID:lower()
local KANTELE = "KANTELE_"
local kantele = KANTELE:lower()
local OCARINA = "OCARINA_"
local ocarina = OCARINA:lower()
local new_sounds_of_music = {
	{
		id          = MOD_ID.."_KANTELE_C",
		name 		= "$action_notes_expanded_kantele_c",
		description = "$actiondesc_notes_expanded_generic_note",
		spawn_requires_flag = "card_unlocked_kantele",
		sprite 		= "mods/NotesExpanded/files/ui_gfx/gun_actions/kantele_c.png",
		related_projectiles	= {"mods/NotesExpanded/files/entities/projectiles/deck/kantele/kantele_c.xml"},
		type 		= ACTION_TYPE_OTHER,
		spawn_level                       = "10", -- OCARINA_D
		spawn_probability                 = "0", -- OCARINA_D
		price = 10,
		mana = 1,
		action 		= function()
			add_projectile("mods/NotesExpanded/files/entities/projectiles/deck/kantele/kantele_c.xml")
			c.fire_rate_wait = c.fire_rate_wait + 15
		end,
	},
}

local music_data = {
    {id = "kantele_c", image = "kantele_c"},
    {id = "kantele_csharp", image = "kantele_c", flat = "kantele_dflat"}, -- bad image
    -- {id = "kantele_dsharp", flat = "kantele_eflat"}, -- already made
    {id = "kantele_f", image = "kantele_f"},
    {id = "kantele_fsharp", image = "kantele_c", flat = "kantele_gflat"}, -- bad image
    {id = "kantele_gsharp", image = "kantele_gsharp",
    flat = "kantele_aflat"},
    {id = "kantele_asharp", image = "kantele_c", flat = "kantele_bflat"}, -- bad image
    {id = "kantele_b", image = "kantele_b"},
    {id = "kantele_c2", image = "kantele_c"}, -- bad image
}

for i,data in ipairs(music_data) do
    local note = {
		id                  = MOD_ID.."_"..data.id:upper(),
		name 		        = "$action_notes_expanded_"..data.id,
		description         = "$actiondesc_notes_expanded_generic_note",
		spawn_requires_flag = "card_unlocked_kantele",
		sprite 		        = ("mods/NotesExpanded/files" and data.image == nil or "data").."/ui_gfx/gun_actions/"..(data.id and data.image == nil or data.image)..".png",
		related_projectiles	= {"mods/NotesExpanded/files/entities/projectiles/deck/kantele/"..data.id..".xml"},
		type 		        = ACTION_TYPE_OTHER,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 10,
		mana                = 1,
		action 		        = function()
		    	                add_projectile("mods/NotesExpanded/files/entities/projectiles/deck/kantele/"..data.id..".xml")
		    	                c.fire_rate_wait = c.fire_rate_wait + 15
		                    end,
        author              = "Sharpy796",
        origin              = "Notes Expanded",
    }

    table.insert(new_sounds_of_music, note)
end


for _, note in ipairs(new_sounds_of_music) do
    table.insert(actions, note)
end