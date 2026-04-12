_spawn_secret = spawn_secret
function spawn_secret( x, y )
    local music_data = dofile_once("mods/NotesExpanded/files/scripts/misc/music_data.lua")
    local extra_ocarina_cards = {}
    local extra_kantele_cards = {}
    for _,note in ipairs(music_data) do
        if not note.has_spell then
            if note.instrument == "kantele" then
                table.insert(extra_kantele_cards, "NOTES_EXPANDED_"..note.id:upper())
            else
                table.insert(extra_ocarina_cards, "NOTES_EXPANDED_"..note.id:upper())
            end
        end
    end

	local kantele_distance = (10100-9870)/#extra_kantele_cards
    for i,v in ipairs( extra_kantele_cards ) do
		local x_ = x - #extra_kantele_cards * kantele_distance * 0.5 + ( i - 0.5 ) * kantele_distance

		CreateItemActionEntity( v, x_, y - 185 )
    end
    for i,v in ipairs( extra_kantele_cards ) do
		local x_ = x - #extra_kantele_cards * kantele_distance * 0.5 + ( i - 0.5 ) * kantele_distance

		CreateItemActionEntity( v, x_, y - 125 )
    end

	local ocarina_distance = (10100-9870)/#extra_ocarina_cards
    for i,v in ipairs( extra_ocarina_cards ) do
		local x_ = x - #extra_ocarina_cards * ocarina_distance * 0.5 + ( i - 0.5 ) * ocarina_distance

		CreateItemActionEntity( v, x_, y + 145 )
    end
    for i,v in ipairs( extra_ocarina_cards ) do
		local x_ = x - #extra_ocarina_cards * ocarina_distance * 0.5 + ( i - 0.5 ) * ocarina_distance

		CreateItemActionEntity( v, x_, y + 205 )
    end
    _spawn_secret( x, y )
end