dofile_once("data/scripts/lib/utilities.lua")
local testing = true;
if testing then ModMagicNumbersFileAdd("mods/NotesExpanded/files/magic_numbers.xml") end -- For testing purposes
ModRegisterAudioEventMappings("mods/NotesExpanded/files/sounds/GUIDs.txt")
local music_data = dofile_once("mods/NotesExpanded/files/scripts/misc/music_data.lua")

local new_translations = ModTextFileGetContent("mods/NotesExpanded/translations.csv")

local function updateTranslations()
	local translations = ModTextFileGetContent("data/translations/common.csv")
	translations = translations .. new_translations
	translations = translations:gsub("\r", ""):gsub("\n\n+", "\n")
	ModTextFileSetContent("data/translations/common.csv", translations)
end

local function getNoteFromId(data)
	return data.id:gsub(".*_","")
end

local function pasteImageOntoImage(id_to, start_x, start_y, id_from,width_from,height_from)
	for w=0,width_from do
		for h=0,height_from do
			if (start_x+w>=16) then print("PASTING ONTO INVALID X:\t"..(start_x+w)) end
			if (start_y+h>=16) then print("PASTING ONTO INVALID Y:\t"..(start_x+w)) end
			ModImageSetPixel(id_to,start_x+w,start_y+h,ModImageGetPixel(id_from,w,h))
		end
	end
end

local id_k,width_k,height_k
local id_o,width_o,height_o
local id_ks,width_ks,height_ks
local id_os,width_os,height_os
local id_k2,width_k2,height_k2
local id_o2,width_o2,height_o2
local id_k3,width_k3,height_k3
local id_o3,width_o3,height_o3
local id_k0,width_k0,height_k0
local id_o0,width_o0,height_o0

local function makeSpritesEditable()
	id_k,width_k,height_k = ModImageMakeEditable("mods/NotesExpanded/files/ui_gfx/gun_actions_assets/kantele_note.png",6,12)
	id_o,width_o,height_o = ModImageMakeEditable("mods/NotesExpanded/files/ui_gfx/gun_actions_assets/ocarina_note.png",6,12)
	id_ks,width_ks,height_ks = ModImageMakeEditable("mods/NotesExpanded/files/ui_gfx/gun_actions_assets/kantele_sharp.png",5,5)
	id_os,width_os,height_os = ModImageMakeEditable("mods/NotesExpanded/files/ui_gfx/gun_actions_assets/ocarina_sharp.png",5,5)
	id_k2,width_k2,height_k2 = ModImageMakeEditable("mods/NotesExpanded/files/ui_gfx/gun_actions_assets/kantele_2.png",5,5)
	id_o2,width_o2,height_o2 = ModImageMakeEditable("mods/NotesExpanded/files/ui_gfx/gun_actions_assets/ocarina_2.png",5,5)
	id_k3,width_k3,height_k3 = ModImageMakeEditable("mods/NotesExpanded/files/ui_gfx/gun_actions_assets/kantele_3.png",5,5)
	id_o3,width_o3,height_o3 = ModImageMakeEditable("mods/NotesExpanded/files/ui_gfx/gun_actions_assets/ocarina_3.png",5,5)
	id_k0,width_k0,height_k0 = ModImageMakeEditable("mods/NotesExpanded/files/ui_gfx/gun_actions_assets/kantele_0.png",5,5)
	id_o0,width_o0,height_o0 = ModImageMakeEditable("mods/NotesExpanded/files/ui_gfx/gun_actions_assets/ocarina_0.png",5,5)
end

local function clearImage(id,width,height)
	for w=0,width do
		for h=0,height do
			ModImageSetPixel(id,w,h,0)
		end
	end
end

local function createNoteSprite(data)
	local note = getNoteFromId(data):gsub("sharp",""):gsub("flat",""):gsub("[0-9]d*",""):gsub("dis","d")
	local id,width,height = ModImageMakeEditable("data/ui_gfx/gun_actions/"..data.id..".png",16,16)
	if (data.vanilla_image or data.has_spell) then clearImage(id,width,height) end
	local id_note,width_note,height_note = ModImageMakeEditable("mods/NotesExpanded/files/ui_gfx/gun_actions_assets/"..data.instrument.."_"..note..".png",5,6)
	if (data.instrument == "kantele") then
		local moveoutofthewayforthesharp = 5
		pasteImageOntoImage(id,1,2,id_k,width_k,height_k)
		if (data.id:find("sharp") or data.id:find("dis")) then
			pasteImageOntoImage(id,9,2,id_ks,width_ks,height_ks)
			moveoutofthewayforthesharp = 8
		end
		
		pasteImageOntoImage(id,9,moveoutofthewayforthesharp,id_note,width_note,height_note)
		if (data.id:find("2")) then
			pasteImageOntoImage(id,1,2,id_k2,width_k2,height_k2)
		elseif (data.id:find("3")) then
			pasteImageOntoImage(id,1,2,id_k3,width_k3,height_k3)
		elseif (data.id:find("0")) then
			pasteImageOntoImage(id,1,2,id_k0,width_k0,height_k0)
		end
	else
		pasteImageOntoImage(id,1,2,id_o,width_o,height_o)
		if (data.id:find("sharp")) then
			pasteImageOntoImage(id,9,8,id_note,width_note,height_note)
			pasteImageOntoImage(id,9,2,id_os,width_os,height_os)
		else
			pasteImageOntoImage(id,9,5,id_note,width_note,height_note)
		end
		if (data.id:find("2")) then
			pasteImageOntoImage(id,1,2,id_o2,width_o2,height_o2)
		elseif (data.id:find("3")) then
			pasteImageOntoImage(id,1,2,id_o3,width_o3,height_o3)
		elseif (data.id:find("0")) then
			pasteImageOntoImage(id,1,2,id_o0,width_o0,height_o0)
		end
	end
end

local function createTranslation(data)
	new_translations = new_translations..[[,
action_notes_expanded_]]..data.id:lower()..[[,"]]..(data.instrument:gsub("^%l", string.upper))..[[ - Note ]]..getNoteFromId(data):gsub("sharp","#"):gsub("flat","b"):upper()..[[",,,,,,,,,,,,,]]
end

local function createNoteXML(id, data)
	local note = getNoteFromId(data)
	local template = ModTextFileGetContent("mods/NotesExpanded/files/entities/projectiles/deck/note_template.xml")
	local filepath = "mods/NotesExpanded/files/entities/projectiles/deck/"..data.instrument.."/"..data.id..".xml"
	ModTextFileSetContent(filepath, template)

    ---@type nxml
    local nxml = dofile_once("mods/NotesExpanded/luanxml/nxml.lua")
	for xml in nxml.edit_file(filepath) do
		-- edit the VariableStorageComponent
		local vscomp = xml:first_of("VariableStorageComponent")
		if vscomp then
			vscomp:set("name", data.instrument.."_note")
			vscomp:set("value_string", note)
		end

		-- edit the LuaComponent
		local luacomp = xml:first_of("LuaComponent")
		if luacomp then
			luacomp:set("script_source_file", "data/scripts/magic/"..data.instrument..".lua")
		end

		-- edit the AudioComponent
		local audiocomp = xml:first_of("AudioComponent")
		if audiocomp then
			audiocomp:set("event_root", "notesexpanded/"..data.instrument.."/"..note)
		end

		-- edit the SpriteParticleEmitterComponent
		math.randomseed(id)
		local specomp = xml:first_of("SpriteParticleEmitterComponent")
		if specomp then
			local color = math.random(3)
			local value = math.random(5)*2/10.0
			if color == 1 then specomp:set("color.r",value)
			elseif color == 2 then specomp:set("color.g",value)
			elseif color == 3 then specomp:set("color.b",value)
			end
		end
	end
end

local function loadNotes()
	makeSpritesEditable()
	for id,data in pairs(music_data) do
		createTranslation(data)
		createNoteXML(id, data)
		createNoteSprite(data)
	end
	print("initialized notes!")
end

function OnModPreInit()
	music_data = dofile_once("mods/NotesExpanded/files/scripts/misc/music_data.lua")
	loadNotes()
    updateTranslations()
    ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/NotesExpanded/files/scripts/gun/gun_actions.lua" )
	ModLuaFileAppend( "data/scripts/biomes/ocarina.lua", "mods/NotesExpanded/files/scripts/biomes/ocarina_appends.lua" )
end