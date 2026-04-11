dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")
dofile_once("data/scripts/lib/utilities.lua")
local mod_id = "NOTES_EXPANDED"
local new_sounds_of_music = {}
local music_data = dofile_once("mods/NotesExpanded/files/scripts/misc/music_data.lua")


for i,data in ipairs(music_data) do
	if (not data.has_spell) then
	    local note = {
			id                  = mod_id.."_"..data.id:upper(),
			name 		        = "$action_notes_expanded_"..data.id,
			description         = "$actiondesc_notes_expanded_generic_note",
			spawn_requires_flag = "card_unlocked_"..data.instrument,
			sprite 		        = "data/ui_gfx/gun_actions/"..data.id..".png",
			related_projectiles	= {"mods/NotesExpanded/files/entities/projectiles/deck/"..data.instrument.."/"..data.id..".xml"},
			type 		        = ACTION_TYPE_OTHER,
			spawn_level         = "10",
			spawn_probability   = "0",
			price               = 10,
			mana                = 1,
			action 		        = function()
			    	                add_projectile("mods/NotesExpanded/files/entities/projectiles/deck/"..data.instrument.."/"..data.id..".xml")
			    	                c.fire_rate_wait = c.fire_rate_wait + 15
			                    end,
	        author              = "Sharpy796",
	        origin              = "Notes Expanded",
			after				= data.after,
	    }

	    table.insert(new_sounds_of_music, note)
	end
end

if (false and ModSettingGet("NotesExpanded.inject_spells")) then
	-- TODO: fix this
else
	for _, note in ipairs(new_sounds_of_music) do
	    table.insert(actions, note)
	end
end
